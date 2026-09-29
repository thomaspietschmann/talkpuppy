import 'package:flutter/services.dart';

/// Copies transcripts to the clipboard marked as sensitive, so they don't
/// travel further than needed: on Android 13+ the clip carries
/// `EXTRA_IS_SENSITIVE` (no preview overlay, skipped by clipboard sync
/// tools), on iOS it is `localOnly` (not sent to other devices via
/// Universal Clipboard). Falls back to Flutter's plain clipboard where the
/// native side isn't available (tests, desktop).
class SensitiveClipboard {
  static const _channel = MethodChannel('talkpuppy/clipboard');

  static Future<void> copy(String text) async {
    try {
      await _channel.invokeMethod<void>('copySensitive', {'text': text});
    } on MissingPluginException {
      await Clipboard.setData(ClipboardData(text: text));
    } on PlatformException {
      await Clipboard.setData(ClipboardData(text: text));
    }
  }
}
