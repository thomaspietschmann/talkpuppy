import 'model_spec.dart';

/// Curated set of languages offered as quick-pick chips in the UI (the
/// underlying Whisper models understand ~99 languages; this list covers the
/// common ones so the "re-transcribe" sheet doesn't turn into a long list).
const List<String> kCommonLanguages = [
  'en',
  'de',
  'fr',
  'es',
  'it',
  'pt',
  'nl',
  'pl',
  'ru',
  'tr',
  'ja',
  'zh',
  'ko',
  'ar',
];

/// The 25 European languages nvidia/parakeet-tdt-0.6b-v3 was trained on.
const List<String> kParakeetLanguages = [
  'bg',
  'hr',
  'cs',
  'da',
  'nl',
  'en',
  'et',
  'fi',
  'fr',
  'de',
  'el',
  'hu',
  'it',
  'lv',
  'lt',
  'mt',
  'pl',
  'pt',
  'ro',
  'sk',
  'sl',
  'es',
  'sv',
  'ru',
  'uk',
];

const _hfCsukuangfj = 'https://huggingface.co/csukuangfj';

/// All models the app can download and use, ordered roughly from
/// "best on a capable phone" to "fits anywhere".
final List<ModelSpec> kModelCatalog = [
  ModelSpec(
    id: 'parakeet-tdt-0.6b-v3-int8',
    displayName: 'Parakeet TDT 0.6B v3',
    description:
        'Sehr schnell und sehr genau, 25 europäische Sprachen inkl. '
        'Deutsch, erkennt die Sprache automatisch. Empfohlen für Geräte '
        'mit mindestens 6 GB RAM.',
    engine: ModelEngine.nemoTransducer,
    baseUrl: '$_hfCsukuangfj/sherpa-onnx-nemo-parakeet-tdt-0.6b-v3-int8/'
        'resolve/main/',
    files: const [
      ModelFileSpec(
        remoteName: 'encoder.int8.onnx',
        localName: 'encoder.int8.onnx',
        sizeBytes: 652000000,
      ),
      ModelFileSpec(
        remoteName: 'decoder.int8.onnx',
        localName: 'decoder.int8.onnx',
        sizeBytes: 11800000,
      ),
      ModelFileSpec(
        remoteName: 'joiner.int8.onnx',
        localName: 'joiner.int8.onnx',
        sizeBytes: 6360000,
      ),
      ModelFileSpec(
        remoteName: 'tokens.txt',
        localName: 'tokens.txt',
        sizeBytes: 93900,
      ),
    ],
    languages: ['auto', ...kParakeetLanguages],
    recommendedRamGb: 6,
  ),
  ModelSpec(
    id: 'whisper-small-int8',
    displayName: 'Whisper Small',
    description:
        'Ausgewogen zwischen Geschwindigkeit und Genauigkeit, 99 Sprachen, '
        'Sprache kann fest eingestellt werden. Für Geräte mit mindestens '
        '4 GB RAM.',
    engine: ModelEngine.whisper,
    baseUrl: '$_hfCsukuangfj/sherpa-onnx-whisper-small/resolve/main/',
    files: const [
      ModelFileSpec(
        remoteName: 'small-encoder.int8.onnx',
        localName: 'encoder.int8.onnx',
        sizeBytes: 112000000,
      ),
      ModelFileSpec(
        remoteName: 'small-decoder.int8.onnx',
        localName: 'decoder.int8.onnx',
        sizeBytes: 262000000,
      ),
      ModelFileSpec(
        remoteName: 'small-tokens.txt',
        localName: 'tokens.txt',
        sizeBytes: 817000,
      ),
    ],
    languages: ['auto', ...kCommonLanguages],
    supportsForcedLanguage: true,
    recommendedRamGb: 4,
  ),
  ModelSpec(
    id: 'whisper-base-int8',
    displayName: 'Whisper Base',
    description:
        'Leichtgewichtig für ältere Geräte, 99 Sprachen, Sprache kann fest '
        'eingestellt werden. Für Geräte mit mindestens 3 GB RAM.',
    engine: ModelEngine.whisper,
    baseUrl: '$_hfCsukuangfj/sherpa-onnx-whisper-base/resolve/main/',
    files: const [
      ModelFileSpec(
        remoteName: 'base-encoder.int8.onnx',
        localName: 'encoder.int8.onnx',
        sizeBytes: 29100000,
      ),
      ModelFileSpec(
        remoteName: 'base-decoder.int8.onnx',
        localName: 'decoder.int8.onnx',
        sizeBytes: 131000000,
      ),
      ModelFileSpec(
        remoteName: 'base-tokens.txt',
        localName: 'tokens.txt',
        sizeBytes: 817000,
      ),
    ],
    languages: ['auto', ...kCommonLanguages],
    supportsForcedLanguage: true,
    recommendedRamGb: 3,
  ),
  ModelSpec(
    id: 'whisper-tiny-int8',
    displayName: 'Whisper Tiny',
    description:
        'Minimal, lädt am schnellsten. 99 Sprachen, Sprache kann fest '
        'eingestellt werden. Läuft auf praktisch jedem Gerät.',
    engine: ModelEngine.whisper,
    baseUrl: '$_hfCsukuangfj/sherpa-onnx-whisper-tiny/resolve/main/',
    files: const [
      ModelFileSpec(
        remoteName: 'tiny-encoder.int8.onnx',
        localName: 'encoder.int8.onnx',
        sizeBytes: 12900000,
      ),
      ModelFileSpec(
        remoteName: 'tiny-decoder.int8.onnx',
        localName: 'decoder.int8.onnx',
        sizeBytes: 89900000,
      ),
      ModelFileSpec(
        remoteName: 'tiny-tokens.txt',
        localName: 'tokens.txt',
        sizeBytes: 817000,
      ),
    ],
    languages: ['auto', ...kCommonLanguages],
    supportsForcedLanguage: true,
    recommendedRamGb: 2,
  ),
];

ModelSpec modelById(String id) =>
    kModelCatalog.firstWhere((m) => m.id == id, orElse: () => kModelCatalog.last);
