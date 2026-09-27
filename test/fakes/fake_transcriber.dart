import 'package:talkpuppy/models/model_spec.dart';
import 'package:talkpuppy/services/transcriber_service.dart';

/// A [Transcriber] that returns a scripted result instead of running real
/// recognition, so state-machine tests don't need a native sherpa-onnx
/// isolate.
class FakeTranscriber implements Transcriber {
  String nextText = 'Hallo Welt';
  String nextLanguage = 'de';
  bool throwOnTranscribe = false;
  int ensureModelCalls = 0;
  int transcribeCalls = 0;
  List<String> transcribedPaths = [];

  @override
  Future<void> ensureModel({
    required ModelSpec model,
    required String modelDir,
    required String vadModelPath,
    String forcedLanguage = 'auto',
  }) async {
    ensureModelCalls++;
  }

  @override
  Future<TranscriptionResult> transcribeFile(String wavPath) async {
    transcribeCalls++;
    transcribedPaths.add(wavPath);
    if (throwOnTranscribe) {
      throw TranscriberException('boom');
    }
    return TranscriptionResult(text: nextText, language: nextLanguage);
  }
}
