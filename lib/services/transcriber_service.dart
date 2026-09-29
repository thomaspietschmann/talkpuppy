import 'dart:async';
import 'dart:isolate';
import 'dart:typed_data';

import 'package:path/path.dart' as p;
import 'package:sherpa_onnx/sherpa_onnx.dart' as sherpa_onnx;

import '../models/model_spec.dart';

/// Text plus the language sherpa-onnx reported for it.
///
/// Whisper models report a detected (or forced) language code. The NeMo
/// transducer models (Parakeet) don't emit this metadata even though they
/// do recognize multiple languages, so [language] is empty for those.
class TranscriptionResult {
  const TranscriptionResult({required this.text, required this.language});

  final String text;
  final String language;
}

class TranscriberException implements Exception {
  TranscriberException(this.message);
  final String message;

  @override
  String toString() => 'TranscriberException: $message';
}

/// What [AppController] needs from a transcriber. Pulled out as an
/// interface so tests can swap in a fake instead of spawning a real
/// sherpa-onnx isolate.
abstract class Transcriber {
  Future<void> ensureModel({
    required ModelSpec model,
    required String modelDir,
    required String vadModelPath,
    String forcedLanguage = 'auto',
  });

  Future<TranscriptionResult> transcribeFile(String wavPath);

  /// Starts a live session on the loaded model, which must be a streaming
  /// one. [onText] receives the whole transcript so far every time it
  /// changes.
  Future<void> startLive(void Function(String text) onText);

  /// Feeds 16 kHz mono samples into the live session. Fire-and-forget.
  void feedLive(Float32List samples);

  /// Flushes the live session and returns its final transcript. Throws if
  /// the session was lost (e.g. the model was switched mid-recording), in
  /// which case the caller falls back to [transcribeFile].
  Future<TranscriptionResult> finishLive();

  /// Drops the live session without a result.
  Future<void> cancelLive();
}

/// Owns a persistent background isolate that keeps a loaded sherpa-onnx
/// recognizer (and VAD) alive across calls, since constructing one from a
/// large ONNX model takes real time.
///
/// All FFI objects (recognizer, VAD, streams) live and die inside that one
/// isolate; only plain data crosses the isolate boundary.
class TranscriberService implements Transcriber {
  Isolate? _isolate;
  SendPort? _commandPort;
  String? _loadedModelKey;
  ReceivePort? _exitPort;
  final Completer<void> _died = Completer<void>();

  static final _diedReply = <String, dynamic>{
    'ok': false,
    // Technical detail; the UI wraps it in a localized sentence.
    'error': 'transcriber process stopped unexpectedly, restart the app',
  };

  Future<void> start() async {
    final initPort = ReceivePort();
    final exitPort = ReceivePort();
    _exitPort = exitPort;
    // onError/onExit both land here, so a crash (e.g. native library failed
    // to load) fails pending requests instead of hanging them forever.
    exitPort.listen((_) {
      if (!_died.isCompleted) _died.complete();
    });
    _isolate = await Isolate.spawn(
      _isolateMain,
      initPort.sendPort,
      debugName: 'transcriber',
      onError: exitPort.sendPort,
      onExit: exitPort.sendPort,
    );
    final first = await Future.any<Object?>([
      initPort.first,
      _died.future.then((_) => null),
    ]);
    initPort.close();
    if (first is! SendPort) {
      throw TranscriberException(_diedReply['error'] as String);
    }
    _commandPort = first;
  }

  /// Loads [model]'s files from [modelDir] into the worker isolate unless
  /// that exact (model, forced language) combination is already loaded.
  @override
  Future<void> ensureModel({
    required ModelSpec model,
    required String modelDir,
    required String vadModelPath,
    String forcedLanguage = 'auto',
  }) async {
    final key = '${model.id}|$forcedLanguage';
    if (_loadedModelKey == key) return;
    // Unknown until the isolate confirms; a failed load leaves nothing
    // loaded there either.
    _loadedModelKey = null;

    final files = <String, String>{
      for (final f in model.files) f.localName: p.join(modelDir, f.localName),
    };

    final reply = await _send({
      'type': 'loadModel',
      'modelId': model.id,
      'engine': model.engine.name,
      'files': files,
      'language': forcedLanguage,
      'vadModelPath': vadModelPath,
    });

    if (reply['ok'] != true) {
      throw TranscriberException(reply['error'] as String? ?? 'unknown error');
    }
    _loadedModelKey = key;
  }

  /// Transcribes a 16 kHz mono WAV file with the currently loaded model.
  /// The audio is segmented with VAD internally so clips longer than
  /// Whisper's ~30s window still work.
  @override
  Future<TranscriptionResult> transcribeFile(String wavPath) async {
    final reply = await _send({'type': 'transcribe', 'wavPath': wavPath});
    if (reply['ok'] != true) {
      throw TranscriberException(reply['error'] as String? ?? 'unknown error');
    }
    return TranscriptionResult(
      text: reply['text'] as String,
      language: reply['language'] as String,
    );
  }

  ReceivePort? _livePort;

  @override
  Future<void> startLive(void Function(String text) onText) async {
    _closeLivePort();
    final livePort = ReceivePort();
    _livePort = livePort;
    livePort.listen((text) => onText(text as String));
    final reply = await _send({
      'type': 'liveStart',
      'textPort': livePort.sendPort,
    });
    if (reply['ok'] != true) {
      _closeLivePort();
      throw TranscriberException(reply['error'] as String? ?? 'unknown error');
    }
  }

  @override
  void feedLive(Float32List samples) {
    if (_died.isCompleted) return;
    // Samples are copied into the message; no reply is expected.
    _commandPort?.send({'type': 'liveAudio', 'samples': samples});
  }

  @override
  Future<TranscriptionResult> finishLive() async {
    try {
      final reply = await _send({'type': 'liveFinish'});
      if (reply['ok'] != true) {
        throw TranscriberException(
          reply['error'] as String? ?? 'unknown error',
        );
      }
      return TranscriptionResult(
        text: reply['text'] as String,
        language: reply['language'] as String,
      );
    } finally {
      _closeLivePort();
    }
  }

  @override
  Future<void> cancelLive() async {
    try {
      await _send({'type': 'liveCancel'});
    } finally {
      _closeLivePort();
    }
  }

  void _closeLivePort() {
    _livePort?.close();
    _livePort = null;
  }

  Future<Map<String, dynamic>> _send(Map<String, dynamic> message) async {
    final commandPort = _commandPort;
    if (commandPort == null) {
      throw StateError('TranscriberService.start() was not called');
    }
    if (_died.isCompleted) return _diedReply;
    final replyPort = ReceivePort();
    commandPort.send({...message, 'replyPort': replyPort.sendPort});
    final response = await Future.any<Object?>([
      replyPort.first,
      _died.future.then((_) => _diedReply),
    ]);
    replyPort.close();
    return response as Map<String, dynamic>;
  }

  Future<void> dispose() async {
    if (_commandPort != null) {
      try {
        await _send({'type': 'shutdown'});
      } catch (_) {
        // Isolate may already be gone; nothing to do.
      }
    }
    _isolate?.kill(priority: Isolate.immediate);
    _isolate = null;
    _commandPort = null;
    _loadedModelKey = null;
    _closeLivePort();
    _exitPort?.close();
    _exitPort = null;
  }
}

const int _kNumThreads = 2;
const int _kVadWindowSize = 512;
const double _kVadMaxSpeechDurationSeconds = 25.0;

/// Silence appended before flushing a streaming session: the cache-aware
/// encoder only emits the last chunk's tokens once it has seen a full
/// chunk (1.12 s) plus its right context after them.
const int _kStreamingTailPaddingSamples = 32000; // 2 s at 16 kHz

/// Silence fed before the audio: without it the model tends to drop the
/// first word when speech starts right away.
const int _kStreamingLeadPaddingSamples = 4800; // 0.3 s at 16 kHz

/// Samples per [OnlineStream.acceptWaveform] call when a whole file is run
/// through a streaming model.
const int _kStreamingFileChunkSamples = 16000 ~/ 10;

/// Everything the worker isolate keeps alive between commands. Exactly one
/// of [offline] / [online] is set while a model is loaded.
class _WorkerState {
  sherpa_onnx.OfflineRecognizer? offline;
  sherpa_onnx.OnlineRecognizer? online;
  sherpa_onnx.VoiceActivityDetector? vad;
  String? loadedKey;

  /// Forced language for the streaming model ('auto' = detect). Streaming
  /// models take it per stream, so changing it needs no reload.
  String language = 'auto';

  _LiveSession? live;

  void freeRecognizers() {
    live?.free();
    live = null;
    offline?.free();
    offline = null;
    online?.free();
    online = null;
    loadedKey = null;
  }
}

/// A streaming recognition over audio that arrives piece by piece — the
/// microphone during a live preview, or a file read in chunks. Endpoints
/// (pauses) finish a segment: its text is committed and the stream reset,
/// which keeps the hypothesis short however long the recording gets.
class _StreamingSession {
  _StreamingSession(this.recognizer, this.language)
    : stream = recognizer.createStream() {
    try {
      _applyLanguage();
      stream.acceptWaveform(
        samples: Float32List(_kStreamingLeadPaddingSamples),
        sampleRate: 16000,
      );
    } catch (_) {
      stream.free();
      rethrow;
    }
  }

  final sherpa_onnx.OnlineRecognizer recognizer;
  final String language;
  final sherpa_onnx.OnlineStream stream;
  final _committed = StringBuffer();

  void _applyLanguage() {
    stream.setOption(key: 'language', value: language);
  }

  /// [sampleRate] other than 16 kHz is resampled by sherpa-onnx.
  void accept(Float32List samples, {int sampleRate = 16000}) {
    stream.acceptWaveform(samples: samples, sampleRate: sampleRate);
    _decodeAvailable();
  }

  void _decodeAvailable() {
    while (recognizer.isReady(stream)) {
      recognizer.decode(stream);
    }
    if (recognizer.isEndpoint(stream)) {
      _commit();
      recognizer.reset(stream);
      _applyLanguage();
    }
  }

  void _commit() {
    final text = recognizer.getResult(stream).text.trim();
    if (text.isEmpty) return;
    if (_committed.isNotEmpty) _committed.write(' ');
    _committed.write(text);
  }

  /// Committed segments plus the current, still-changing one.
  String get text {
    final current = recognizer.getResult(stream).text.trim();
    if (current.isEmpty) return _committed.toString();
    if (_committed.isEmpty) return current;
    return '$_committed $current';
  }

  String finish() {
    stream.acceptWaveform(
      samples: Float32List(_kStreamingTailPaddingSamples),
      sampleRate: 16000,
    );
    stream.inputFinished();
    while (recognizer.isReady(stream)) {
      recognizer.decode(stream);
    }
    _commit();
    return _committed.toString();
  }

  void free() => stream.free();
}

/// A [_StreamingSession] fed from the microphone that pushes its text to
/// the UI isolate whenever it changes.
class _LiveSession {
  _LiveSession(this.session, this.textPort);

  final _StreamingSession session;
  final SendPort textPort;
  String _lastSent = '';

  void accept(Float32List samples) {
    session.accept(samples);
    final text = session.text;
    if (text != _lastSent) {
      _lastSent = text;
      textPort.send(text);
    }
  }

  void free() => session.free();
}

/// Entry point for the worker isolate. Runs until it receives a 'shutdown'
/// command.
void _isolateMain(SendPort initSendPort) {
  sherpa_onnx.initBindings();

  final commandPort = ReceivePort();
  initSendPort.send(commandPort.sendPort);

  final state = _WorkerState();

  commandPort.listen((dynamic message) {
    final map = message as Map<String, dynamic>;
    final type = map['type'] as String;

    // Audio chunks arrive every ~100 ms and expect no reply.
    if (type == 'liveAudio') {
      try {
        state.live?.accept(map['samples'] as Float32List);
      } catch (_) {
        // A failing session is dropped; liveFinish then reports the loss
        // and the controller falls back to transcribing the file.
        state.live?.free();
        state.live = null;
      }
      return;
    }

    final SendPort replyPort = map['replyPort'] as SendPort;
    try {
      switch (type) {
        case 'loadModel':
          final modelId = map['modelId'] as String;
          final engine = map['engine'] as String;
          final language = map['language'] as String? ?? 'auto';
          final streaming = engine == ModelEngine.nemoStreaming.name;
          // The streaming model gets its language per stream, so only the
          // offline models need a rebuild when it changes.
          final key = streaming ? modelId : '$modelId|$language';
          if (state.loadedKey != key) {
            // Clear state before building: if the build throws, we must not
            // keep a pointer to a freed recognizer or claim the old model is
            // still loaded.
            state.freeRecognizers();
            final files = Map<String, String>.from(map['files'] as Map);
            if (streaming) {
              state.online = _buildOnlineRecognizer(files);
            } else {
              state.offline = _buildOfflineRecognizer(
                engine: engine,
                files: files,
                language: language,
              );
            }
            state.loadedKey = key;
          }
          state.language = language;
          state.vad ??= _buildVad(map['vadModelPath'] as String);
          replyPort.send({'ok': true});
        case 'transcribe':
          final wavPath = map['wavPath'] as String;
          final TranscriptionResult result;
          if (state.online != null) {
            result = _transcribeStreaming(
              state.online!,
              state.language,
              wavPath,
            );
          } else if (state.offline != null && state.vad != null) {
            result = _transcribeWithVad(state.offline!, state.vad!, wavPath);
          } else {
            replyPort.send({'ok': false, 'error': 'No model loaded'});
            break;
          }
          replyPort.send({
            'ok': true,
            'text': result.text,
            'language': result.language,
          });
        case 'liveStart':
          final online = state.online;
          if (online == null) {
            replyPort.send({'ok': false, 'error': 'No streaming model loaded'});
            break;
          }
          state.live?.free();
          state.live = _LiveSession(
            _StreamingSession(online, state.language),
            map['textPort'] as SendPort,
          );
          replyPort.send({'ok': true});
        case 'liveFinish':
          final live = state.live;
          if (live == null) {
            replyPort.send({'ok': false, 'error': 'live session was lost'});
            break;
          }
          state.live = null;
          final String text;
          try {
            text = live.session.finish();
          } finally {
            live.free();
          }
          replyPort.send({
            'ok': true,
            'text': text,
            // The session's own language: the default may have changed
            // since it started.
            'language': _reportedLanguage(live.session.language),
          });
        case 'liveCancel':
          state.live?.free();
          state.live = null;
          replyPort.send({'ok': true});
        case 'shutdown':
          state.freeRecognizers();
          state.vad?.free();
          state.vad = null;
          replyPort.send({'ok': true});
          commandPort.close();
        default:
          replyPort.send({'ok': false, 'error': 'Unknown command: $type'});
      }
    } catch (e) {
      replyPort.send({'ok': false, 'error': e.toString()});
    }
  });
}

/// Nemotron filters its language tag out of the text and doesn't report
/// what it detected, so only a forced language is known.
String _reportedLanguage(String language) => language == 'auto' ? '' : language;

sherpa_onnx.OfflineRecognizer _buildOfflineRecognizer({
  required String engine,
  required Map<String, String> files,
  required String language,
}) {
  final sherpa_onnx.OfflineModelConfig modelConfig;
  if (engine == ModelEngine.whisper.name) {
    modelConfig = sherpa_onnx.OfflineModelConfig(
      whisper: sherpa_onnx.OfflineWhisperModelConfig(
        encoder: files['encoder.int8.onnx']!,
        decoder: files['decoder.int8.onnx']!,
        language: language == 'auto' ? '' : language,
        task: 'transcribe',
      ),
      tokens: files['tokens.txt']!,
      modelType: 'whisper',
      numThreads: _kNumThreads,
      debug: false,
    );
  } else {
    modelConfig = sherpa_onnx.OfflineModelConfig(
      transducer: sherpa_onnx.OfflineTransducerModelConfig(
        encoder: files['encoder.int8.onnx']!,
        decoder: files['decoder.int8.onnx']!,
        joiner: files['joiner.int8.onnx']!,
      ),
      tokens: files['tokens.txt']!,
      numThreads: _kNumThreads,
      debug: false,
    );
  }
  return sherpa_onnx.OfflineRecognizer(
    sherpa_onnx.OfflineRecognizerConfig(model: modelConfig),
  );
}

sherpa_onnx.OnlineRecognizer _buildOnlineRecognizer(Map<String, String> files) {
  return sherpa_onnx.OnlineRecognizer(
    sherpa_onnx.OnlineRecognizerConfig(
      model: sherpa_onnx.OnlineModelConfig(
        transducer: sherpa_onnx.OnlineTransducerModelConfig(
          encoder: files['encoder.int8.onnx']!,
          decoder: files['decoder.int8.onnx']!,
          joiner: files['joiner.int8.onnx']!,
        ),
        tokens: files['tokens.txt']!,
        numThreads: _kNumThreads,
        debug: false,
      ),
      // Endpoints split long recordings into segments (see
      // _StreamingSession): after 2.4 s of silence with nothing
      // recognized, 1.2 s after speech, or at 20 s of continuous speech.
      enableEndpoint: true,
      rule1MinTrailingSilence: 2.4,
      rule2MinTrailingSilence: 1.2,
      rule3MinUtteranceLength: 20,
    ),
  );
}

/// Runs a whole WAV file through the streaming model (retranscribe, or a
/// recording whose live session was lost). No VAD needed: the streaming
/// session segments at pauses by itself.
TranscriptionResult _transcribeStreaming(
  sherpa_onnx.OnlineRecognizer recognizer,
  String language,
  String wavPath,
) {
  final wave = sherpa_onnx.readWave(wavPath);
  if (wave.samples.isEmpty) {
    throw StateError('recording could not be read');
  }
  final session = _StreamingSession(recognizer, language);
  try {
    for (var i = 0; i < wave.samples.length; i += _kStreamingFileChunkSamples) {
      final end = (i + _kStreamingFileChunkSamples).clamp(
        0,
        wave.samples.length,
      );
      session.accept(
        Float32List.sublistView(wave.samples, i, end),
        sampleRate: wave.sampleRate,
      );
    }
    return TranscriptionResult(
      text: session.finish(),
      language: _reportedLanguage(language),
    );
  } finally {
    session.free();
  }
}

sherpa_onnx.VoiceActivityDetector _buildVad(String vadModelPath) {
  return sherpa_onnx.VoiceActivityDetector(
    config: sherpa_onnx.VadModelConfig(
      sileroVad: sherpa_onnx.SileroVadModelConfig(
        model: vadModelPath,
        minSilenceDuration: 0.5,
        minSpeechDuration: 0.25,
        windowSize: _kVadWindowSize,
        maxSpeechDuration: _kVadMaxSpeechDurationSeconds,
      ),
      sampleRate: 16000,
    ),
    bufferSizeInSeconds: 30,
  );
}

TranscriptionResult _transcribeWithVad(
  sherpa_onnx.OfflineRecognizer recognizer,
  sherpa_onnx.VoiceActivityDetector vad,
  String wavPath,
) {
  final wave = sherpa_onnx.readWave(wavPath);
  if (wave.samples.isEmpty) {
    // readWave returns empty samples for missing/unreadable files. Fail
    // loudly so a retranscribe can't silently wipe a good transcript.
    throw StateError('recording could not be read');
  }

  vad.reset();

  final buffer = StringBuffer();
  var detectedLanguage = '';

  void decodeSegment(Float32List samples) {
    if (samples.isEmpty) return;
    final stream = recognizer.createStream();
    final sherpa_onnx.OfflineRecognizerResult result;
    try {
      stream.acceptWaveform(samples: samples, sampleRate: wave.sampleRate);
      recognizer.decode(stream);
      result = recognizer.getResult(stream);
    } finally {
      stream.free();
    }

    final text = result.text.trim();
    if (text.isNotEmpty) {
      if (buffer.isNotEmpty) buffer.write(' ');
      buffer.write(text);
    }
    if (detectedLanguage.isEmpty && result.lang.isNotEmpty) {
      detectedLanguage = result.lang;
    }
  }

  void drainVadSegments() {
    while (!vad.isEmpty()) {
      final segment = vad.front();
      vad.pop();
      decodeSegment(segment.samples);
    }
  }

  var i = 0;
  while (i + _kVadWindowSize <= wave.samples.length) {
    vad.acceptWaveform(wave.samples.sublist(i, i + _kVadWindowSize));
    i += _kVadWindowSize;
    drainVadSegments();
  }
  if (i < wave.samples.length) {
    // Pad the trailing partial window with silence so Silero still sees it.
    final tail = Float32List(_kVadWindowSize);
    final remaining = wave.samples.sublist(i);
    tail.setRange(0, remaining.length, remaining);
    vad.acceptWaveform(tail);
    drainVadSegments();
  }
  vad.flush();
  drainVadSegments();

  // Safety net: if VAD never detected speech (e.g. very quiet audio or a
  // clip shorter than Silero's minimum speech duration), fall back to
  // decoding the raw audio directly rather than silently returning nothing.
  if (buffer.isEmpty) {
    final maxSamples = 25 * wave.sampleRate;
    final samples = wave.samples.length > maxSamples
        ? wave.samples.sublist(0, maxSamples)
        : wave.samples;
    decodeSegment(samples);
  }

  return TranscriptionResult(
    text: buffer.toString(),
    language: detectedLanguage,
  );
}
