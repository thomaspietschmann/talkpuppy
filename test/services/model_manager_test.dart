import 'package:flutter_test/flutter_test.dart';
import 'package:talkpuppy/services/model_manager.dart';

void main() {
  final requested = Uri.parse(
    'https://huggingface.co/csukuangfj/sherpa-onnx-whisper-base/resolve/abc/base-tokens.txt',
  );

  test('a relative redirect stays on https', () {
    // What Hugging Face sends for small (non-LFS) files.
    final location = Uri.parse(
      '/api/resolve-cache/models/csukuangfj/sherpa-onnx-whisper-base/abc/base-tokens.txt?x=1',
    );
    expect(ModelManager.isHttpsAfterRedirects(requested, location), isTrue);
  });

  test('an absolute https redirect (CDN) is fine', () {
    final location = Uri.parse('https://cas-bridge.xethub.hf.co/xet-bridge-us/abc');
    expect(ModelManager.isHttpsAfterRedirects(requested, location), isTrue);
  });

  test('no redirect at all is fine', () {
    expect(ModelManager.isHttpsAfterRedirects(requested, requested), isTrue);
  });

  test('a downgrade to plain http is refused', () {
    final location = Uri.parse('http://example.com/tokens.txt');
    expect(ModelManager.isHttpsAfterRedirects(requested, location), isFalse);
  });
}
