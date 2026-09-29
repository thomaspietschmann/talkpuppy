/// Which sherpa-onnx recognizer family a model belongs to. This decides how
/// [ModelSpec] is turned into a recognizer config in the transcriber
/// service: the first two are offline (whole clip after recording), the
/// last one is a streaming model that can show text while recording.
enum ModelEngine { whisper, nemoTransducer, nemoStreaming }

/// One file that has to be downloaded for a model to become usable.
///
/// Hugging Face repos prefix files with the model size (e.g.
/// `tiny-encoder.int8.onnx`), but the rest of the app addresses model files
/// by a normalized [localName] (e.g. `encoder.int8.onnx`) so the transcriber
/// doesn't need to know which model is currently loaded.
class ModelFileSpec {
  const ModelFileSpec({
    required this.remoteName,
    required this.localName,
    required this.sizeBytes,
    required this.sha256,
  });

  final String remoteName;
  final String localName;

  /// Exact size of the file at the pinned revision in [ModelSpec.baseUrl].
  final int sizeBytes;

  /// Lowercase hex SHA-256 of the file. A download is only accepted if it
  /// matches — guards against captive-portal HTML pages, truncated
  /// transfers and tampering, since these files are parsed by native code.
  final String sha256;
}

/// Describes one downloadable offline speech-recognition model.
class ModelSpec {
  const ModelSpec({
    required this.id,
    required this.displayName,
    required this.engine,
    required this.baseUrl,
    required this.files,
    required this.languages,
    required this.recommendedRamGb,
    this.supportsForcedLanguage = false,
  });

  /// Stable identifier, also used as the on-disk directory name under
  /// `<app support dir>/models/<id>/`.
  final String id;

  final String displayName;
  final ModelEngine engine;

  /// Directory URL (with trailing slash) files are resolved against.
  final String baseUrl;

  final List<ModelFileSpec> files;

  /// ISO-639-1 codes this model can recognize. Contains `'auto'` when the
  /// model can detect the spoken language on its own.
  final List<String> languages;

  /// Whether a specific language can be forced (whisper and the streaming
  /// Nemotron model; Parakeet is auto-detect only).
  final bool supportsForcedLanguage;

  /// Rough device RAM recommendation, used to pick a sensible default in
  /// onboarding.
  final int recommendedRamGb;

  int get totalSizeBytes => files.fold(0, (sum, f) => sum + f.sizeBytes);

  bool get supportsAutoLanguageDetection => languages.contains('auto');

  /// Streaming models transcribe while recording (live preview).
  bool get isStreaming => engine == ModelEngine.nemoStreaming;

  /// Whether [language] (an ISO-639-1 code) can be forced with this model.
  bool canForceLanguage(String language) =>
      supportsForcedLanguage && languages.contains(language);
}
