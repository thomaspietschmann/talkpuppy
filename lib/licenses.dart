import 'package:flutter/foundation.dart';

/// Registers licenses of the speech models with Flutter's [LicenseRegistry]
/// so they show up on the in-app license page next to the package licenses
/// Flutter collects automatically.
///
/// - Silero VAD is bundled in the app (MIT: notice must be included).
/// - Parakeet (CC BY 4.0: attribution required) and Whisper (MIT) are
///   downloaded at runtime; they're listed so users see what they run.
void registerModelLicenses() {
  LicenseRegistry.addLicense(() async* {
    yield LicenseEntryWithLineBreaks(
      const ['Silero VAD'],
      _mit('Copyright (c) 2020-present Silero Team'),
    );
    yield LicenseEntryWithLineBreaks(
      const ['Whisper (OpenAI)'],
      _mit('Copyright (c) 2022 OpenAI'),
    );
    yield const LicenseEntryWithLineBreaks(
      ['Parakeet TDT 0.6B v3 (NVIDIA)'],
      'Parakeet TDT 0.6B v3 by NVIDIA Corporation\n'
      'https://huggingface.co/nvidia/parakeet-tdt-0.6b-v3\n\n'
      'Licensed under the Creative Commons Attribution 4.0 International '
      'License (CC BY 4.0): https://creativecommons.org/licenses/by/4.0/\n\n'
      'Talkpuppy uses the int8-quantized ONNX conversion published at '
      'https://huggingface.co/csukuangfj/'
      'sherpa-onnx-nemo-parakeet-tdt-0.6b-v3-int8. No further changes were '
      'made to the model.',
    );
  });
}

String _mit(String copyright) => '$copyright\n\n$_mitBody';

const _mitBody =
    'Permission is hereby granted, free of charge, to any person obtaining a '
    'copy of this software and associated documentation files (the '
    '"Software"), to deal in the Software without restriction, including '
    'without limitation the rights to use, copy, modify, merge, publish, '
    'distribute, sublicense, and/or sell copies of the Software, and to '
    'permit persons to whom the Software is furnished to do so, subject to '
    'the following conditions:\n\n'
    'The above copyright notice and this permission notice shall be included '
    'in all copies or substantial portions of the Software.\n\n'
    'THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS '
    'OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF '
    'MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. '
    'IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY '
    'CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, '
    'TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE '
    'SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.';
