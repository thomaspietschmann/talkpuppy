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

/// The languages nvidia/nemotron-3.5-asr-streaming-0.6b is rated
/// "transcription-ready" or "broad-coverage" for. Its "adaptation-ready"
/// locales (el, lt, lv, mt, sl, he, th, nn) are left out on purpose.
const List<String> kNemotronLanguages = [
  'ar',
  'bg',
  'cs',
  'da',
  'de',
  'en',
  'es',
  'et',
  'fi',
  'fr',
  'hi',
  'hr',
  'hu',
  'it',
  'ja',
  'ko',
  'nb',
  'nl',
  'pl',
  'pt',
  'ro',
  'ru',
  'sk',
  'sv',
  'tr',
  'uk',
  'vi',
  'zh',
];

const _hfCsukuangfj = 'https://huggingface.co/csukuangfj';

/// All models the app can download and use, ordered roughly from
/// "best on a capable phone" to "fits anywhere".
final List<ModelSpec> kModelCatalog = [
  ModelSpec(
    id: 'parakeet-tdt-0.6b-v3-int8',
    displayName: 'Parakeet TDT 0.6B v3',
    engine: ModelEngine.nemoTransducer,
    baseUrl:
        '$_hfCsukuangfj/sherpa-onnx-nemo-parakeet-tdt-0.6b-v3-int8/'
        'resolve/2bda32ec70b097a55adaa07d9a7173915b43cc78/',
    files: const [
      ModelFileSpec(
        remoteName: 'encoder.int8.onnx',
        localName: 'encoder.int8.onnx',
        sizeBytes: 652184281,
        sha256:
            'acfc2b4456377e15d04f0243af540b7fe7c992f8d898d751cf134c3a55fd2247',
      ),
      ModelFileSpec(
        remoteName: 'decoder.int8.onnx',
        localName: 'decoder.int8.onnx',
        sizeBytes: 11845275,
        sha256:
            '179e50c43d1a9de79c8a24149a2f9bac6eb5981823f2a2ed88d655b24248db4e',
      ),
      ModelFileSpec(
        remoteName: 'joiner.int8.onnx',
        localName: 'joiner.int8.onnx',
        sizeBytes: 6355277,
        sha256:
            '3164c13fc2821009440d20fcb5fdc78bff28b4db2f8d0f0b329101719c0948b3',
      ),
      ModelFileSpec(
        remoteName: 'tokens.txt',
        localName: 'tokens.txt',
        sizeBytes: 93939,
        sha256:
            'd58544679ea4bc6ac563d1f545eb7d474bd6cfa467f0a6e2c1dc1c7d37e3c35d',
      ),
    ],
    languages: ['auto', ...kParakeetLanguages],
    recommendedRamGb: 6,
  ),
  ModelSpec(
    id: 'nemotron-3.5-streaming-0.6b-1120ms-int8',
    displayName: 'Nemotron 3.5 Streaming',
    engine: ModelEngine.nemoStreaming,
    // The 1120 ms chunk export: the most accurate of the five, and still
    // fast enough for a live preview.
    baseUrl:
        'https://huggingface.co/csukuangfj2/'
        'sherpa-onnx-nemotron-3.5-asr-streaming-0.6b-1120ms-int8-2026-06-11/'
        'resolve/cba1c96ca5ef0e8393b50584ae153a79145dc492/',
    files: const [
      ModelFileSpec(
        remoteName: 'encoder.int8.onnx',
        localName: 'encoder.int8.onnx',
        sizeBytes: 657601521,
        sha256:
            '2fff2166acaa535bd969fb223c1f0783d71029f143cb298bc54c2afe85abf772',
      ),
      ModelFileSpec(
        remoteName: 'decoder.int8.onnx',
        localName: 'decoder.int8.onnx',
        sizeBytes: 14978075,
        sha256:
            '19f9c98fc6d0a2c33a65a43b36fdb2e914c26c0aa9764be3aebc502a1e982fb0',
      ),
      ModelFileSpec(
        remoteName: 'joiner.int8.onnx',
        localName: 'joiner.int8.onnx',
        sizeBytes: 9504438,
        sha256:
            '4101c7c679a0bc30483794b27a059e34e79232aa2068d78d51231a22c8b0d7ce',
      ),
      ModelFileSpec(
        remoteName: 'tokens.txt',
        localName: 'tokens.txt',
        sizeBytes: 131440,
        sha256:
            '729cc103155bafa785f9cd45746cd41cabe97eab7182fc04d594129587958f8a',
      ),
    ],
    languages: ['auto', ...kNemotronLanguages],
    supportsForcedLanguage: true,
    recommendedRamGb: 6,
  ),
  ModelSpec(
    id: 'whisper-small-int8',
    displayName: 'Whisper Small',
    engine: ModelEngine.whisper,
    baseUrl:
        '$_hfCsukuangfj/sherpa-onnx-whisper-small/resolve/8f3c18b358db4d1f2fc1eae49d75cd20989e4309/',
    files: const [
      ModelFileSpec(
        remoteName: 'small-encoder.int8.onnx',
        localName: 'encoder.int8.onnx',
        sizeBytes: 112442483,
        sha256:
            '4cbe7b22fa9026b843b60a68640c747de05bafb1a11b57edc0e66c232d9f33a9',
      ),
      ModelFileSpec(
        remoteName: 'small-decoder.int8.onnx',
        localName: 'decoder.int8.onnx',
        sizeBytes: 262226114,
        sha256:
            'acad50b5c782696e91b55914cc5ab4f756f1532f76e22aa6fc615f39fb69a8ee',
      ),
      ModelFileSpec(
        remoteName: 'small-tokens.txt',
        localName: 'tokens.txt',
        sizeBytes: 816730,
        sha256:
            'b34b360dbb493e781e479794586d661700670d65564001f23024971d1f2fa126',
      ),
    ],
    languages: ['auto', ...kCommonLanguages],
    supportsForcedLanguage: true,
    recommendedRamGb: 4,
  ),
  ModelSpec(
    id: 'whisper-base-int8',
    displayName: 'Whisper Base',
    engine: ModelEngine.whisper,
    baseUrl:
        '$_hfCsukuangfj/sherpa-onnx-whisper-base/resolve/bb53ee204431c90d314c1cc08d28d23e5b7927cc/',
    files: const [
      ModelFileSpec(
        remoteName: 'base-encoder.int8.onnx',
        localName: 'encoder.int8.onnx',
        sizeBytes: 29120534,
        sha256:
            '0b8fb1304b6109976038efff5ace81720e00386f3ff6b54ee8c75291ca0a1e11',
      ),
      ModelFileSpec(
        remoteName: 'base-decoder.int8.onnx',
        localName: 'decoder.int8.onnx',
        sizeBytes: 130672026,
        sha256:
            '9759d217388a01b3a4c7c15533201067b48ae819c4daafc8624e64b9409dc02d',
      ),
      ModelFileSpec(
        remoteName: 'base-tokens.txt',
        localName: 'tokens.txt',
        sizeBytes: 816730,
        sha256:
            'b34b360dbb493e781e479794586d661700670d65564001f23024971d1f2fa126',
      ),
    ],
    languages: ['auto', ...kCommonLanguages],
    supportsForcedLanguage: true,
    recommendedRamGb: 3,
  ),
  ModelSpec(
    id: 'whisper-tiny-int8',
    displayName: 'Whisper Tiny',
    engine: ModelEngine.whisper,
    baseUrl:
        '$_hfCsukuangfj/sherpa-onnx-whisper-tiny/resolve/65176e2deb88badc814a94058666cadccc29b61c/',
    files: const [
      ModelFileSpec(
        remoteName: 'tiny-encoder.int8.onnx',
        localName: 'encoder.int8.onnx',
        sizeBytes: 12937772,
        sha256:
            'd24fb083ae3b1041fc24e97971d60e280c9342201fbb67b0ab428a8b4a51a434',
      ),
      ModelFileSpec(
        remoteName: 'tiny-decoder.int8.onnx',
        localName: 'decoder.int8.onnx',
        sizeBytes: 89855401,
        sha256:
            'd2fece8dd42771f1df975c6c0445770d0c292bf7547c2cae04a6c0cc57540925',
      ),
      ModelFileSpec(
        remoteName: 'tiny-tokens.txt',
        localName: 'tokens.txt',
        sizeBytes: 816730,
        sha256:
            'b34b360dbb493e781e479794586d661700670d65564001f23024971d1f2fa126',
      ),
    ],
    languages: ['auto', ...kCommonLanguages],
    supportsForcedLanguage: true,
    recommendedRamGb: 2,
  ),
];

ModelSpec modelById(String id) => kModelCatalog.firstWhere(
  (m) => m.id == id,
  orElse: () => kModelCatalog.last,
);
