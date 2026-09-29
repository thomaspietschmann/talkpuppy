import 'dart:async';
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:path/path.dart' as p;
import 'package:wakelock_plus/wakelock_plus.dart';

import '../models/catalog.dart';
import '../models/model_spec.dart';
import '../models/recording.dart';
import '../services/history_store.dart';
import '../services/model_manager.dart';
import '../services/recorder_service.dart';
import '../services/sensitive_clipboard.dart';
import '../services/settings_service.dart';
import '../services/transcriber_service.dart';
import 'app_error.dart';

/// Discards a clip shorter than this — almost certainly an accidental tap.
const Duration kMinClipDuration = Duration(milliseconds: 500);

/// How long the microphone keeps running after stop is tapped with a
/// streaming model. Its live preview lags behind the voice, so people tend
/// to tap while still finishing the last word; the tail keeps that word
/// (and the last audio buffers) in the recording. Offline models stop
/// immediately.
const Duration kStopTail = Duration(milliseconds: 700);

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
    this.useWakelock = true,
    this.stopTail = kStopTail,
  });

  final RecorderService recorder;
  final Transcriber transcriber;
  final HistoryStore historyStore;
  final SettingsService settings;
  final ModelManager modelManager;
  final String vadModelPath;

  /// Keep the screen on while recording. Off in tests (no platform plugin).
  final bool useWakelock;

  /// See [kStopTail]; zero in tests.
  final Duration stopTail;

  RecordingPhase phase = RecordingPhase.idle;
  /// The current error, if [phase] is [RecordingPhase.error].
  AppError? error;
  Recording? activeRecording;
  double amplitude = 0;

  /// What the streaming model has recognized so far in the current
  /// recording (live preview). Null when no live session is running, e.g.
  /// with an offline model.
  String? liveText;

  /// When the current recording started, so the UI can show an elapsed
  /// timer. Null unless [phase] is [RecordingPhase.recording].
  DateTime? recordingStartedAt;

  /// Whether the currently selected model is downloaded and loaded, i.e.
  /// whether recording is actually possible right now.
  bool modelReady = false;

  /// Why the selected model couldn't be loaded, if it is downloaded but
  /// broken. Null when the model is fine or simply not installed.
  AppError? modelError;

  bool _appendMode = false;
  bool _starting = false;

  /// Whether the transcriber runs a live session for the current recording,
  /// and for which model.
  bool _live = false;
  String? _liveModelId;
  String? _pendingWavPath;
  StreamSubscription<double>? _ampSub;
  StreamSubscription<void>? _interruptSub;
  int _idCounter = 0;

  /// Tail of the transcriber work queue. The isolate handles one command at
  /// a time, but "load model X, then transcribe" is two commands — without
  /// this, a retranscribe (or a model switch) could slip in between and a
  /// clip would be decoded with the wrong model/language.
  Future<void> _transcriberQueue = Future.value();

  Future<T> _serialized<T>(Future<T> Function() action) {
    final result = _transcriberQueue.then((_) => action());
    _transcriberQueue = result.then((_) {}, onError: (_) {});
    return result;
  }

  String _generateId() {
    _idCounter++;
    return '${DateTime.now().microsecondsSinceEpoch}-$_idCounter';
  }

  Future<void> init() async {
    await ensureCurrentModelLoaded();
  }

  /// True while a recording or transcription is in flight. History edits
  /// (delete, retranscribe) are refused then, so they can't yank the state
  /// out from under a live microphone.
  bool get isBusy =>
      _starting ||
      phase == RecordingPhase.recording ||
      phase == RecordingPhase.transcribing;

  /// Whether the live preview continues [activeRecording] (so its text is
  /// shown in front of the preview) rather than starting a new one.
  bool get isAppendingLive => liveText != null && _appendMode;

  bool get canRecord =>
      modelReady &&
      !_starting &&
      (phase == RecordingPhase.idle ||
          phase == RecordingPhase.done ||
          phase == RecordingPhase.error);

  /// (Re-)loads whichever model [SettingsService.selectedModelId] points at
  /// into the transcriber, for live recording. Safe to call repeatedly,
  /// including after retranscribing with a different model.
  Future<void> ensureCurrentModelLoaded() => _serialized(_loadCurrentModel);

  /// Must only be called from inside [_serialized].
  Future<void> _loadCurrentModel() async {
    final modelId = settings.selectedModelId;
    if (modelId == null) {
      modelReady = false;
      modelError = null;
      notifyListeners();
      return;
    }
    final model = modelById(modelId);
    if (!await modelManager.isDownloaded(model)) {
      modelReady = false;
      modelError = null;
      notifyListeners();
      return;
    }
    try {
      await transcriber.ensureModel(
        model: model,
        modelDir: modelManager.modelDir(model),
        vadModelPath: vadModelPath,
        // Models that can't force this language auto-detect instead.
        forcedLanguage: model.canForceLanguage(settings.defaultLanguage)
            ? settings.defaultLanguage
            : 'auto',
      );
      modelReady = true;
      modelError = null;
      if (_live && model.id != _liveModelId) {
        // Switching models mid-recording dropped the live session; don't
        // leave its last text frozen on screen.
        liveText = null;
      }
    } catch (e) {
      modelReady = false;
      modelError = AppError(
        AppErrorKind.modelLoad,
        modelName: model.displayName,
        detail: '$e',
      );
    }
    notifyListeners();
  }

  Future<void> startNewRecording() => _startRecording(appendMode: false);

  Future<void> startContinueRecording() => _startRecording(appendMode: true);

  Future<void> _startRecording({required bool appendMode}) async {
    if (!canRecord) return;
    // Claim the start synchronously so a fast double tap can't start the
    // recorder twice.
    _starting = true;
    _appendMode = appendMode && activeRecording != null;
    error = null;
    notifyListeners();

    try {
      await historyStore.ensureDirExists();
      _pendingWavPath = historyStore.wavPathFor(historyStore.newWavFileName());
      if (!await recorder.hasPermission()) {
        throw const _ErrorOf(AppError(AppErrorKind.micPermission));
      }
      _live = await _startLiveSession();
      await recorder.start(
        _pendingWavPath!,
        onSamples: _live ? transcriber.feedLive : null,
      );
    } catch (e) {
      await _dropLiveSession();
      final path = _pendingWavPath;
      _pendingWavPath = null;
      if (path != null) await _deleteFileIfExists(path);
      _starting = false;
      _fail(
        e is _ErrorOf
            ? e.error
            : AppError(AppErrorKind.recorderStart, detail: '$e'),
      );
      return;
    }

    _starting = false;
    phase = RecordingPhase.recording;
    recordingStartedAt = DateTime.now();
    if (useWakelock) unawaited(WakelockPlus.enable());
    notifyListeners();

    // A call or alarm pauses the microphone; finish right away so what was
    // said so far is transcribed and saved rather than silently lost.
    await _interruptSub?.cancel();
    _interruptSub = recorder.interruptions.listen(
      (_) => stopAndTranscribe(interrupted: true),
    );

    await _ampSub?.cancel();
    _ampSub = recorder.amplitudeStream.listen((dbfs) {
      // dBFS is roughly -45 (silence) to 0 (loud); normalize to 0..1.
      amplitude = ((dbfs + 45) / 45).clamp(0, 1);
      notifyListeners();
    });
  }

  /// Starts a live session if the selected model is a streaming one.
  /// Best effort: without it the clip is simply transcribed from the file
  /// after recording, like with the offline models.
  Future<bool> _startLiveSession() async {
    final modelId = settings.selectedModelId;
    if (modelId == null || !modelById(modelId).isStreaming) return false;
    try {
      return await _serialized(() async {
        await _loadCurrentModel();
        if (!modelReady) return false;
        await transcriber.startLive(_onLiveText);
        liveText = '';
        _liveModelId = modelId;
        return true;
      });
    } catch (_) {
      return false;
    }
  }

  void _onLiveText(String text) {
    if (!_live) return;
    liveText = text;
    notifyListeners();
  }

  /// Ends the live session without using its result.
  Future<void> _dropLiveSession() async {
    liveText = null;
    if (!_live) return;
    _live = false;
    try {
      await _serialized(transcriber.cancelLive);
    } catch (_) {
      // The session is gone either way.
    }
  }

  /// Ends the recording and transcribes it. [interrupted] means the
  /// microphone is already gone (call, alarm, app in background), so the
  /// stop tail is skipped.
  Future<void> stopAndTranscribe({bool interrupted = false}) async {
    if (phase != RecordingPhase.recording) return;
    // Leave the recording phase right away so a second tap can't stop
    // twice; with a live session the microphone (and preview) keeps
    // running for the tail.
    final tail = _live && !interrupted ? stopTail : Duration.zero;
    phase = RecordingPhase.transcribing;
    recordingStartedAt = null;
    notifyListeners();
    await _interruptSub?.cancel();
    _interruptSub = null;
    if (tail > Duration.zero) await Future<void>.delayed(tail);

    await _ampSub?.cancel();
    _ampSub = null;
    amplitude = 0;
    if (useWakelock) unawaited(WakelockPlus.disable());
    final wavPath = _pendingWavPath;
    _pendingWavPath = null;

    final Duration duration;
    try {
      duration = await recorder.stop();
    } catch (e) {
      await _dropLiveSession();
      if (wavPath != null) await _deleteFileIfExists(wavPath);
      _fail(AppError(AppErrorKind.recorderStop, detail: '$e'));
      return;
    }

    if (wavPath == null) {
      await _dropLiveSession();
      phase = _restingPhase;
      notifyListeners();
      return;
    }

    // The tail doesn't count towards the accidental-tap check.
    if (duration - tail < kMinClipDuration) {
      await _dropLiveSession();
      await _deleteFileIfExists(wavPath);
      phase = _restingPhase;
      notifyListeners();
      return;
    }

    phase = RecordingPhase.transcribing;
    notifyListeners();

    final modelId = settings.selectedModelId ?? '';
    final now = DateTime.now();
    final live = _live;
    _live = false;
    TranscriptionResult? result;
    Object? failure;
    try {
      result = await _serialized(() async {
        // The live result first: it only needs the recognizer that is still
        // loaded, even if the model files were deleted meanwhile. If the
        // model was switched mid-recording, that reload already dropped the
        // session and this fails over to the file.
        if (live) {
          try {
            return await transcriber.finishLive();
          } catch (_) {
            // Fall through to the recorded file.
          }
        }
        await _loadCurrentModel();
        if (!modelReady) {
          throw _ErrorOf(
            modelError ?? const AppError(AppErrorKind.noModel),
          );
        }
        return transcriber.transcribeFile(wavPath);
      });
    } catch (e) {
      failure = e;
    }
    liveText = null;

    // On failure the audio is still kept as an error clip: it stays covered
    // by the 3-day purge and can be retranscribed once the model works.
    final clip = Clip(
      id: _generateId(),
      wavFileName: p.basename(wavPath),
      text: result?.text ?? '',
      language: result?.language ?? '',
      modelId: modelId,
      durationMs: duration.inMilliseconds,
      createdAt: now,
      status: failure == null ? ClipStatus.done : ClipStatus.error,
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

    if (failure != null) {
      _fail(
        failure is _ErrorOf
            ? failure.error
            : AppError(AppErrorKind.transcription, detail: '$failure'),
      );
      return;
    }

    // Nothing recognized (e.g. only background noise): don't wipe whatever
    // the user had on the clipboard.
    if (settings.autoCopy && activeRecording!.text.isNotEmpty) {
      await SensitiveClipboard.copy(activeRecording!.text);
    }
    if (settings.haptics) {
      await HapticFeedback.mediumImpact();
    }
    phase = RecordingPhase.done;
    notifyListeners();
  }

  Future<void> cancelRecording() async {
    if (phase != RecordingPhase.recording) return;
    // Claim the phase synchronously, like stopAndTranscribe, so a stop (or
    // backgrounding) can't run while the recorder is being cancelled.
    phase = RecordingPhase.transcribing;
    await _interruptSub?.cancel();
    _interruptSub = null;
    await _ampSub?.cancel();
    _ampSub = null;
    amplitude = 0;
    recordingStartedAt = null;
    if (useWakelock) unawaited(WakelockPlus.disable());
    try {
      await recorder.cancel();
    } catch (_) {
      // Nothing more we can do; the file is removed below either way.
    }
    await _dropLiveSession();
    final wavPath = _pendingWavPath;
    _pendingWavPath = null;
    if (wavPath != null) {
      await _deleteFileIfExists(wavPath);
    }
    phase = _restingPhase;
    notifyListeners();
  }

  /// Called when the app goes to the background. iOS and Android both cut
  /// the microphone for backgrounded apps, so finish what we have rather
  /// than leaving a recording that silently captures nothing.
  Future<void> handleAppBackgrounded() async {
    if (phase == RecordingPhase.recording) {
      await stopAndTranscribe(interrupted: true);
    }
  }

  /// Re-runs recognition over every clip of [recording] with [model] forced
  /// to [language] (or `'auto'`). Used when the input language was detected
  /// wrong the first time. Refused while a recording/transcription runs.
  Future<void> retranscribeRecording(
    Recording recording, {
    required ModelSpec model,
    required String language,
  }) async {
    if (isBusy) return;
    phase = RecordingPhase.transcribing;
    error = null;
    notifyListeners();
    try {
      final newClips = await _serialized(() async {
        await transcriber.ensureModel(
          model: model,
          modelDir: modelManager.modelDir(model),
          vadModelPath: vadModelPath,
          forcedLanguage: language,
        );
        final clips = <Clip>[];
        for (final clip in recording.clips) {
          final result = await transcriber.transcribeFile(
            historyStore.wavPathFor(clip.wavFileName),
          );
          clips.add(
            clip.copyWith(
              text: result.text,
              language: result.language,
              modelId: model.id,
              status: ClipStatus.done,
            ),
          );
        }
        return clips;
      });
      recording.clips
        ..clear()
        ..addAll(newClips);
      recording.updatedAt = DateTime.now();
      await historyStore.persistChange();

      if (activeRecording?.id == recording.id &&
          settings.autoCopy &&
          recording.text.isNotEmpty) {
        await SensitiveClipboard.copy(recording.text);
      }
      phase = _restingPhase;
      notifyListeners();
    } catch (e) {
      // The existing clips are left untouched on failure.
      _fail(AppError(AppErrorKind.retranscribe, detail: '$e'));
    }
    // The retranscribe model/language may differ from the live default;
    // make sure the next fresh recording uses the default again.
    unawaited(ensureCurrentModelLoaded());
  }

  /// Frees the loaded model while the app is in the background, so the
  /// Android floating button (its own engine) can load one without two
  /// models sitting in memory. The next recording or
  /// [ensureCurrentModelLoaded] loads it again.
  Future<void> releaseModel() => _serialized(() async {
    if (isBusy) return;
    await transcriber.unloadModel();
  });

  /// Deletes recordings older than [maxAge]. Runs at startup and whenever
  /// the app comes back to the foreground, since a resident process may
  /// otherwise keep old audio for days. Skipped while a recording or
  /// transcription runs.
  Future<void> purgeExpired(Duration maxAge) async {
    if (isBusy) return;
    await historyStore.purgeOlderThan(maxAge);
    final active = activeRecording;
    if (active != null &&
        !historyStore.recordings.any((r) => r.id == active.id)) {
      activeRecording = null;
      if (phase == RecordingPhase.done) phase = RecordingPhase.idle;
      notifyListeners();
    }
  }

  /// Dismisses an error state and returns to idle/done so the user can try
  /// again.
  void dismissError() {
    error = null;
    if (phase == RecordingPhase.error) phase = _restingPhase;
    notifyListeners();
  }

  Future<void> copyToClipboard(Recording recording) async {
    await SensitiveClipboard.copy(recording.text);
    if (settings.haptics) {
      await HapticFeedback.selectionClick();
    }
  }

  /// Returns false (and does nothing) while a recording/transcription runs.
  Future<bool> deleteRecording(String id) async {
    if (isBusy) return false;
    await historyStore.deleteRecording(id);
    if (activeRecording?.id == id) {
      activeRecording = null;
      phase = RecordingPhase.idle;
    }
    notifyListeners();
    return true;
  }

  /// Returns false (and does nothing) while a recording/transcription runs.
  Future<bool> deleteAllRecordings() async {
    if (isBusy) return false;
    await historyStore.deleteAll();
    activeRecording = null;
    phase = RecordingPhase.idle;
    notifyListeners();
    return true;
  }

  /// Where the state machine rests when nothing is in flight.
  RecordingPhase get _restingPhase =>
      activeRecording == null ? RecordingPhase.idle : RecordingPhase.done;

  void _fail(AppError appError) {
    error = appError;
    phase = RecordingPhase.error;
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
    _interruptSub?.cancel();
    super.dispose();
  }
}

/// Carries an [AppError] through a `throw` inside the controller.
class _ErrorOf implements Exception {
  const _ErrorOf(this.error);
  final AppError error;

  @override
  String toString() => error.toString();
}
