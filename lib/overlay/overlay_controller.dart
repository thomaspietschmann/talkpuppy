import 'dart:async';
import 'dart:io';

import 'package:path/path.dart' as p;

import '../models/catalog.dart';
import '../models/model_spec.dart';
import '../services/model_manager.dart';
import '../services/recorder_service.dart';
import '../services/settings_service.dart';
import '../services/transcriber_service.dart';
import '../state/app_controller.dart' show kMinClipDuration;

/// Why an overlay session failed; the native side shows a matching message.
enum OverlayErrorKind { noModel, modelLoad, recorderStart, recorderStop, transcription }

/// What [OverlayController] reports back to the native overlay (Kotlin).
/// Implemented by the method-channel bridge; faked in tests.
abstract class OverlayHost {
  /// `recording` once the microphone runs, `transcribing` after stop.
  void sessionState(String sessionId, String state);

  /// Microphone level 0..1, roughly every 100 ms while recording.
  void amplitude(String sessionId, double level);

  /// The transcript; empty when nothing was recognized or the clip was too
  /// short to be anything but an accidental tap.
  void result(String sessionId, String text, String language, int durationMs);

  void error(String sessionId, OverlayErrorKind kind, String detail);
}

/// Runs one dictation at a time for the Android floating button, in the
/// overlay's own Flutter engine. The native side owns the UI and the
/// foreground service (which must be running before [startSession] is
/// called, or Android hands out silence); this class only records and
/// transcribes.
///
/// Unlike [AppController] there is no history or clipboard handling here:
/// the text goes back to the native side, which delivers it.
class OverlayController {
  OverlayController({
    required this.recorder,
    required this.transcriber,
    required this.settings,
    required this.modelManager,
    required this.vadModelPath,
    required this.audioDir,
    required this.host,
    this.idleUnloadAfter = const Duration(minutes: 3),
  });

  final RecorderService recorder;
  final Transcriber transcriber;
  final SettingsService settings;
  final ModelManager modelManager;
  final String vadModelPath;

  /// Where recordings are written while they're transcribed. They're
  /// deleted right after (the overlay keeps no history yet).
  final Directory audioDir;

  final OverlayHost host;

  /// How long the model stays loaded after a session, so quick follow-up
  /// dictations don't wait for it again.
  final Duration idleUnloadAfter;

  String? _sessionId;
  String? _wavPath;
  Future<Object?>? _modelLoad;
  bool _stopping = false;
  bool _modelLoaded = false;
  bool _unloadRequested = false;
  StreamSubscription<double>? _ampSub;
  StreamSubscription<void>? _interruptSub;
  Timer? _idleUnloadTimer;

  bool get isBusy => _sessionId != null;

  Future<void> startSession(String sessionId) async {
    if (_sessionId != null) {
      // A stale session the native side gave up on; drop it.
      await _discard();
    }
    _idleUnloadTimer?.cancel();
    _sessionId = sessionId;
    _stopping = false;

    // The app may have changed the model or language since last time.
    await settings.reload();
    final model = await _resolveModel();
    if (model == null) {
      _fail(sessionId, OverlayErrorKind.noModel, '');
      await _discard();
      return;
    }
    // Load in parallel with recording, so speech right after the tap isn't
    // lost while a large model loads. Errors surface at stop.
    _modelLoad = _loadModel(model);

    await audioDir.create(recursive: true);
    final wavPath = p.join(
      audioDir.path,
      'overlay-${DateTime.now().microsecondsSinceEpoch}.wav',
    );
    _wavPath = wavPath;
    try {
      await recorder.start(wavPath);
    } catch (e) {
      _fail(sessionId, OverlayErrorKind.recorderStart, '$e');
      await _discard();
      return;
    }
    if (_sessionId != sessionId) return;

    _interruptSub = recorder.interruptions.listen(
      (_) => stopSession(sessionId),
    );
    _ampSub = recorder.amplitudeStream.listen((dbfs) {
      host.amplitude(sessionId, ((dbfs + 45) / 45).clamp(0, 1).toDouble());
    });
    host.sessionState(sessionId, 'recording');
  }

  /// Stops and transcribes. Also used for interruptions (call, alarm).
  Future<void> stopSession(String sessionId) async {
    if (_sessionId != sessionId || _stopping) return;
    _stopping = true;
    await _cancelSubscriptions();
    host.sessionState(sessionId, 'transcribing');

    final wavPath = _wavPath;
    Duration duration;
    try {
      duration = await recorder.stop();
    } catch (e) {
      _fail(sessionId, OverlayErrorKind.recorderStop, '$e');
      await _discard();
      return;
    }

    try {
      if (wavPath == null || duration < kMinClipDuration) {
        host.result(sessionId, '', '', duration.inMilliseconds);
        return;
      }
      final loadError = await _modelLoad;
      if (loadError != null) {
        _fail(sessionId, OverlayErrorKind.modelLoad, '$loadError');
        return;
      }
      final TranscriptionResult result;
      try {
        result = await transcriber.transcribeFile(wavPath);
      } catch (e) {
        _fail(sessionId, OverlayErrorKind.transcription, '$e');
        return;
      }
      if (_sessionId == sessionId) {
        host.result(
          sessionId,
          result.text,
          result.language,
          duration.inMilliseconds,
        );
      }
    } finally {
      await _finish();
    }
  }

  /// Drops the recording without a result (long press, service gone).
  Future<void> cancelSession(String sessionId) async {
    if (_sessionId != sessionId) return;
    await _discard();
  }

  /// Frees the model, e.g. because the app came to the foreground and
  /// wants its own. Deferred until a running session is done.
  Future<void> unloadModel() async {
    _idleUnloadTimer?.cancel();
    if (isBusy) {
      _unloadRequested = true;
      return;
    }
    await _unload();
  }

  /// The app's selected model, if it's installed. Checked on disk each
  /// time: the app may have downloaded or deleted models since this engine
  /// started.
  Future<ModelSpec?> _resolveModel() async {
    final id = settings.selectedModelId;
    if (id == null) return null;
    final model = modelById(id);
    return await modelManager.isDownloaded(model) ? model : null;
  }

  /// Returns the error instead of throwing, so an unawaited failure can't
  /// become an unhandled async error before stop looks at it.
  Future<Object?> _loadModel(ModelSpec model) async {
    try {
      final language = model.canForceLanguage(settings.defaultLanguage)
          ? settings.defaultLanguage
          : 'auto';
      await transcriber.ensureModel(
        model: model,
        modelDir: modelManager.modelDir(model),
        vadModelPath: vadModelPath,
        forcedLanguage: language,
      );
      _modelLoaded = true;
      return null;
    } catch (e) {
      return e;
    }
  }

  void _fail(String sessionId, OverlayErrorKind kind, String detail) {
    if (_sessionId == sessionId) host.error(sessionId, kind, detail);
  }

  Future<void> _cancelSubscriptions() async {
    await _ampSub?.cancel();
    _ampSub = null;
    await _interruptSub?.cancel();
    _interruptSub = null;
  }

  Future<void> _discard() async {
    await _cancelSubscriptions();
    try {
      if (await recorder.isRecording()) await recorder.cancel();
    } catch (_) {
      // Nothing more to do; the file is removed below.
    }
    await _finish();
  }

  /// Ends the session: removes the audio and schedules the model unload.
  Future<void> _finish() async {
    final wavPath = _wavPath;
    _wavPath = null;
    _sessionId = null;
    _stopping = false;
    // Wait for a load still in flight, so an unload can't race it.
    await _modelLoad;
    _modelLoad = null;
    if (wavPath != null) {
      try {
        await File(wavPath).delete();
      } on FileSystemException {
        // Already gone.
      }
    }
    if (_unloadRequested) {
      await _unload();
    } else if (_modelLoaded) {
      _idleUnloadTimer = Timer(idleUnloadAfter, _unload);
    }
  }

  Future<void> _unload() async {
    _unloadRequested = false;
    _idleUnloadTimer?.cancel();
    if (!_modelLoaded) return;
    _modelLoaded = false;
    try {
      await transcriber.unloadModel();
    } catch (_) {
      // Best effort; the next session reloads either way.
    }
  }

  void dispose() {
    _idleUnloadTimer?.cancel();
    _ampSub?.cancel();
    _interruptSub?.cancel();
  }
}
