import 'dart:async';

import 'package:talkpuppy/models/model_spec.dart';
import 'package:talkpuppy/services/transcriber_service.dart';

/// A [Transcriber] that returns a scripted result instead of running real
/// recognition, so state-machine tests don't need a native sherpa-onnx
/// isolate.
class FakeTranscriber implements Transcriber {
  String nextText = 'Hallo Welt';
  String nextLanguage = 'de';
  bool throwOnTranscribe = false;

  /// Number of upcoming [ensureModel] calls that should throw.
  int ensureModelFailures = 0;

  /// When set, [transcribeFile] waits for this before returning — lets a
  /// test hold a transcription "in flight".
  Completer<void>? transcribeGate;

  int ensureModelCalls = 0;
  int transcribeCalls = 0;
  List<String> transcribedPaths = [];

  /// Every call in order, e.g. `load:whisper-tiny-int8|auto`, `transcribe`.
  final List<String> log = [];

  /// The model/language key loaded most recently, and the key that was
  /// active when each transcription *finished* — if something reloaded the
  /// model mid-transcription, this exposes it.
  String? currentKey;
  final List<String?> finishedWithKey = [];

  @override
  Future<void> ensureModel({
    required ModelSpec model,
    required String modelDir,
    required String vadModelPath,
    String forcedLanguage = 'auto',
  }) async {
    ensureModelCalls++;
    log.add('load:${model.id}|$forcedLanguage');
    if (ensureModelFailures > 0) {
      ensureModelFailures--;
      currentKey = null;
      throw TranscriberException('model broken');
    }
    currentKey = '${model.id}|$forcedLanguage';
  }

  @override
  Future<TranscriptionResult> transcribeFile(String wavPath) async {
    transcribeCalls++;
    transcribedPaths.add(wavPath);
    log.add('transcribe');
    final gate = transcribeGate;
    if (gate != null) await gate.future;
    finishedWithKey.add(currentKey);
    if (throwOnTranscribe) {
      throw TranscriberException('boom');
    }
    return TranscriptionResult(text: nextText, language: nextLanguage);
  }
}
