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

/// Owns a persistent background isolate that keeps a loaded sherpa-onnx
/// recognizer (and VAD) alive across calls, since constructing one from a
/// large ONNX model takes real time.
///
/// All FFI objects (recognizer, VAD, streams) live and die inside that one
/// isolate; only plain data crosses the isolate boundary.
class TranscriberService {
  Isolate? _isolate;
  SendPort? _commandPort;
  String? _loadedModelKey;

  Future<void> start() async {
    final initPort = ReceivePort();
    _isolate = await Isolate.spawn(
      _isolateMain,
      initPort.sendPort,
      debugName: 'transcriber',
    );
    _commandPort = await initPort.first as SendPort;
  }

  /// Loads [model]'s files from [modelDir] into the worker isolate unless
  /// that exact (model, forced language) combination is already loaded.
  Future<void> ensureModel({
    required ModelSpec model,
    required String modelDir,
    required String vadModelPath,
    String forcedLanguage = 'auto',
  }) async {
    final key = '${model.id}|$forcedLanguage';
    if (_loadedModelKey == key) return;

    final files = <String, String>{
      for (final f in model.files) f.localName: p.join(modelDir, f.localName),
    };

    final reply = await _send({
      'type': 'loadModel',
      'modelId': model.id,
      'engine': model.engine == ModelEngine.whisper
          ? 'whisper'
          : 'nemoTransducer',
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

  Future<Map<String, dynamic>> _send(Map<String, dynamic> message) async {
    final commandPort = _commandPort;
    if (commandPort == null) {
      throw StateError('TranscriberService.start() was not called');
    }
    final replyPort = ReceivePort();
    commandPort.send({...message, 'replyPort': replyPort.sendPort});
    final response = await replyPort.first;
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
  }
}

const int _kNumThreads = 2;
const int _kVadWindowSize = 512;
const double _kVadMaxSpeechDurationSeconds = 25.0;

/// Entry point for the worker isolate. Runs until it receives a 'shutdown'
/// command.
void _isolateMain(SendPort initSendPort) {
  sherpa_onnx.initBindings();

  final commandPort = ReceivePort();
  initSendPort.send(commandPort.sendPort);

  sherpa_onnx.OfflineRecognizer? recognizer;
  sherpa_onnx.VoiceActivityDetector? vad;
  String? loadedKey;

  commandPort.listen((dynamic message) {
    final map = message as Map<String, dynamic>;
    final SendPort replyPort = map['replyPort'] as SendPort;
    final type = map['type'] as String;

    try {
      switch (type) {
        case 'loadModel':
          final modelId = map['modelId'] as String;
          final language = map['language'] as String? ?? 'auto';
          final key = '$modelId|$language';
          if (loadedKey != key) {
            recognizer?.free();
            recognizer = _buildRecognizer(
              engine: map['engine'] as String,
              files: Map<String, String>.from(map['files'] as Map),
              language: language,
            );
            loadedKey = key;
          }
          vad ??= _buildVad(map['vadModelPath'] as String);
          replyPort.send({'ok': true});
        case 'transcribe':
          final activeRecognizer = recognizer;
          final activeVad = vad;
          if (activeRecognizer == null || activeVad == null) {
            replyPort.send({'ok': false, 'error': 'No model loaded'});
            break;
          }
          final result = _transcribeWithVad(
            activeRecognizer,
            activeVad,
            map['wavPath'] as String,
          );
          replyPort.send({
            'ok': true,
            'text': result.text,
            'language': result.language,
          });
        case 'shutdown':
          recognizer?.free();
          vad?.free();
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

sherpa_onnx.OfflineRecognizer _buildRecognizer({
  required String engine,
  required Map<String, String> files,
  required String language,
}) {
  final sherpa_onnx.OfflineModelConfig modelConfig;
  if (engine == 'whisper') {
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
    return const TranscriptionResult(text: '', language: '');
  }

  vad.reset();

  final buffer = StringBuffer();
  var detectedLanguage = '';

  void decodeSegment(Float32List samples) {
    if (samples.isEmpty) return;
    final stream = recognizer.createStream();
    stream.acceptWaveform(samples: samples, sampleRate: wave.sampleRate);
    recognizer.decode(stream);
    final result = recognizer.getResult(stream);
    stream.free();

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

  return TranscriptionResult(text: buffer.toString(), language: detectedLanguage);
}
