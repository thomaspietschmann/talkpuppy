import 'dart:async';
import 'dart:io';

import 'package:path/path.dart' as p;

import '../models/catalog.dart';
import '../models/model_spec.dart';
import '../services/model_manager.dart';
import '../services/recorder_service.dart';
import '../services/settings_service.dart';
import '../services/transcriber_service.dart';
import '../state/app_controller.dart'
    show kMinClipDuration, kRecorderStartTimeout;

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
/// app's engine and with the app's transcriber (and so its loaded model).
/// The native side owns the button and the foreground service (which must
/// be running before [startSession] is called, or Android hands out
/// silence); this class only records and transcribes.
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
    required this.serialize,
    this.onBusyChanged,
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

  /// Runs transcriber work in the app's queue ([AppController.serialized]),
  /// so the app and the button never interleave "load model, transcribe".
  final Future<T> Function<T>(Future<T> Function() action) serialize;

  /// Told when a dictation starts and ends; the app blocks its own
  /// recording (and model deletion) meanwhile.
  final void Function(bool busy)? onBusyChanged;

  String? _sessionId;
  String? _wavPath;
  Future<Object?>? _modelLoad;
  bool _stopping = false;
  StreamSubscription<double>? _ampSub;
  StreamSubscription<void>? _interruptSub;

  bool get isBusy => _sessionId != null;

  Future<void> startSession(String sessionId) async {
    if (_sessionId != null) {
      // A stale session the native side gave up on; drop it.
      await _discard();
    }
    _sessionId = sessionId;
    _stopping = false;
    onBusyChanged?.call(true);

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
      await recorder
          .start(wavPath)
          .timeout(
            kRecorderStartTimeout,
            onTimeout: () {
              // Not awaited: a plugin that hangs on start may hang on
              // cancel too.
              unawaited(recorder.cancel().catchError((Object _) {}));
              throw TimeoutException('microphone did not start');
            },
          );
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
        result = await serialize(() => transcriber.transcribeFile(wavPath));
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
      // Usually a no-op: the app has the same model loaded already.
      await serialize(
        () => transcriber.ensureModel(
          model: model,
          modelDir: modelManager.modelDir(model),
          vadModelPath: vadModelPath,
          forcedLanguage: language,
        ),
      );
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

  /// Ends the session and removes the audio.
  Future<void> _finish() async {
    final wavPath = _wavPath;
    _wavPath = null;
    _sessionId = null;
    _stopping = false;
    // Don't leave a load running unobserved.
    await _modelLoad;
    _modelLoad = null;
    if (wavPath != null) {
      try {
        await File(wavPath).delete();
      } on FileSystemException {
        // Already gone.
      }
    }
    onBusyChanged?.call(false);
  }

  void dispose() {
    _ampSub?.cancel();
    _interruptSub?.cancel();
  }
}
