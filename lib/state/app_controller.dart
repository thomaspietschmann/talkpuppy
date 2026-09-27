import 'dart:async';
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:path/path.dart' as p;

import '../models/catalog.dart';
import '../models/model_spec.dart';
import '../models/recording.dart';
import '../services/history_store.dart';
import '../services/model_manager.dart';
import '../services/recorder_service.dart';
import '../services/settings_service.dart';
import '../services/transcriber_service.dart';

/// Discards a clip shorter than this — almost certainly an accidental tap.
const Duration kMinClipDuration = Duration(milliseconds: 500);

enum RecordingPhase { idle, recording, transcribing, done, error }

/// Central state machine: orchestrates recorder -> transcriber -> history
/// store, and drives auto-copy/haptics. This is the single source of truth
/// the home screen's record button and transcript card render from.
class AppController extends ChangeNotifier {
  AppController({
    required this.recorder,
    required this.transcriber,
    required this.historyStore,
    required this.settings,
    required this.modelManager,
    required this.vadModelPath,
  });

  final RecorderService recorder;
  final Transcriber transcriber;
  final HistoryStore historyStore;
  final SettingsService settings;
  final ModelManager modelManager;
  final String vadModelPath;

  RecordingPhase phase = RecordingPhase.idle;
  String? errorMessage;
  Recording? activeRecording;
  double amplitude = 0;

  /// When the current recording started, so the UI can show an elapsed
  /// timer. Null unless [phase] is [RecordingPhase.recording].
  DateTime? recordingStartedAt;

  /// Whether the currently selected model is downloaded and loaded, i.e.
  /// whether recording is actually possible right now.
  bool modelReady = false;

  bool _appendMode = false;
  String? _pendingWavPath;
  StreamSubscription<double>? _ampSub;
  int _idCounter = 0;

  String _generateId() {
    _idCounter++;
    return '${DateTime.now().microsecondsSinceEpoch}-$_idCounter';
  }

  Future<void> init() async {
    await ensureCurrentModelLoaded();
  }

  /// (Re-)loads whichever model [SettingsService.selectedModelId] points at
  /// into the transcriber, for live (auto-language) recording. Safe to call
  /// repeatedly, including after retranscribing with a different model.
  Future<void> ensureCurrentModelLoaded() async {
    final modelId = settings.selectedModelId;
    if (modelId == null) {
      modelReady = false;
      notifyListeners();
      return;
    }
    final model = modelById(modelId);
    if (!await modelManager.isDownloaded(model)) {
      modelReady = false;
      notifyListeners();
      return;
    }
    try {
      await transcriber.ensureModel(
        model: model,
        modelDir: modelManager.modelDir(model),
        vadModelPath: vadModelPath,
        // Only whisper models honor this; nemo transducer models always
        // auto-detect regardless of what's passed here.
        forcedLanguage: settings.defaultLanguage,
      );
      modelReady = true;
    } catch (_) {
      modelReady = false;
    }
    notifyListeners();
  }

  bool get canRecord =>
      modelReady &&
      (phase == RecordingPhase.idle || phase == RecordingPhase.done);

  Future<void> startNewRecording() => _startRecording(appendMode: false);

  Future<void> startContinueRecording() => _startRecording(appendMode: true);

  Future<void> _startRecording({required bool appendMode}) async {
    if (!canRecord) return;
    _appendMode = appendMode && activeRecording != null;
    await historyStore.ensureDirExists();
    final fileName = historyStore.newWavFileName();
    _pendingWavPath = historyStore.wavPathFor(fileName);

    await recorder.start(_pendingWavPath!);
    phase = RecordingPhase.recording;
    errorMessage = null;
    recordingStartedAt = DateTime.now();
    notifyListeners();

    await _ampSub?.cancel();
    _ampSub = recorder.amplitudeStream.listen((dbfs) {
      // dBFS is roughly -45 (silence) to 0 (loud); normalize to 0..1.
      amplitude = ((dbfs + 45) / 45).clamp(0, 1);
      notifyListeners();
    });
  }

  Future<void> stopAndTranscribe() async {
    if (phase != RecordingPhase.recording) return;
    await _ampSub?.cancel();
    _ampSub = null;
    amplitude = 0;
    recordingStartedAt = null;

    final duration = await recorder.stop();
    final wavPath = _pendingWavPath;
    _pendingWavPath = null;

    if (wavPath == null) {
      phase = RecordingPhase.idle;
      notifyListeners();
      return;
    }

    if (duration < kMinClipDuration) {
      await _deleteFileIfExists(wavPath);
      phase = activeRecording == null
          ? RecordingPhase.idle
          : RecordingPhase.done;
      notifyListeners();
      return;
    }

    phase = RecordingPhase.transcribing;
    notifyListeners();

    try {
      await ensureCurrentModelLoaded();
      final result = await transcriber.transcribeFile(wavPath);
      final now = DateTime.now();
      final clip = Clip(
        id: _generateId(),
        wavFileName: p.basename(wavPath),
        text: result.text,
        language: result.language,
        modelId: settings.selectedModelId ?? '',
        durationMs: duration.inMilliseconds,
        createdAt: now,
      );

      if (_appendMode && activeRecording != null) {
        activeRecording!.clips.add(clip);
        activeRecording!.updatedAt = now;
        await historyStore.persistChange();
      } else {
        final recording = Recording(
          id: _generateId(),
          createdAt: now,
          updatedAt: now,
          clips: [clip],
        );
        activeRecording = recording;
        await historyStore.addRecording(recording);
      }

      if (settings.autoCopy) {
        await Clipboard.setData(ClipboardData(text: activeRecording!.text));
      }
      if (settings.haptics) {
        await HapticFeedback.mediumImpact();
      }
      phase = RecordingPhase.done;
    } catch (e) {
      errorMessage = e.toString();
      phase = RecordingPhase.error;
    }
    notifyListeners();
  }

  Future<void> cancelRecording() async {
    if (phase != RecordingPhase.recording) return;
    await _ampSub?.cancel();
    _ampSub = null;
    amplitude = 0;
    recordingStartedAt = null;
    await recorder.cancel();
    final wavPath = _pendingWavPath;
    _pendingWavPath = null;
    if (wavPath != null) {
      await _deleteFileIfExists(wavPath);
    }
    phase = activeRecording == null
        ? RecordingPhase.idle
        : RecordingPhase.done;
    notifyListeners();
  }

  /// Re-runs recognition over every clip of [recording] with [model] forced
  /// to [language] (or `'auto'`). Used when the input language was detected
  /// wrong the first time.
  Future<void> retranscribeRecording(
    Recording recording, {
    required ModelSpec model,
    required String language,
  }) async {
    phase = RecordingPhase.transcribing;
    notifyListeners();
    try {
      await transcriber.ensureModel(
        model: model,
        modelDir: modelManager.modelDir(model),
        vadModelPath: vadModelPath,
        forcedLanguage: language,
      );
      final newClips = <Clip>[];
      for (final clip in recording.clips) {
        final result = await transcriber.transcribeFile(
          historyStore.wavPathFor(clip.wavFileName),
        );
        newClips.add(
          clip.copyWith(
            text: result.text,
            language: result.language,
            modelId: model.id,
          ),
        );
      }
      recording.clips
        ..clear()
        ..addAll(newClips);
      recording.updatedAt = DateTime.now();
      await historyStore.persistChange();

      if (activeRecording?.id == recording.id && settings.autoCopy) {
        await Clipboard.setData(ClipboardData(text: recording.text));
      }
      phase = RecordingPhase.done;
    } catch (e) {
      errorMessage = e.toString();
      phase = RecordingPhase.error;
    }
    notifyListeners();
    // The retranscribe model/language may differ from the live default;
    // make sure the next fresh recording uses the default again.
    unawaited(ensureCurrentModelLoaded());
  }

  /// Dismisses an error state and returns to idle/done so the user can try
  /// again.
  void dismissError() {
    errorMessage = null;
    phase = activeRecording == null
        ? RecordingPhase.idle
        : RecordingPhase.done;
    notifyListeners();
  }

  Future<void> copyToClipboard(Recording recording) async {
    await Clipboard.setData(ClipboardData(text: recording.text));
    if (settings.haptics) {
      await HapticFeedback.selectionClick();
    }
  }

  Future<void> deleteRecording(String id) async {
    await historyStore.deleteRecording(id);
    if (activeRecording?.id == id) {
      activeRecording = null;
      phase = RecordingPhase.idle;
    }
    notifyListeners();
  }

  Future<void> deleteAllRecordings() async {
    await historyStore.deleteAll();
    activeRecording = null;
    phase = RecordingPhase.idle;
    notifyListeners();
  }

  Future<void> _deleteFileIfExists(String path) async {
    final file = File(path);
    if (await file.exists()) {
      await file.delete();
    }
  }

  @override
  void dispose() {
    _ampSub?.cancel();
    super.dispose();
  }
}
