import 'dart:io';

import 'package:flutter/services.dart';

/// Excludes [path] from iCloud backup on iOS (no-op elsewhere; Android backup
/// is disabled in the manifest). Used for the large, re-downloadable models
/// and for the private recording history, which should never leave the
/// device.
Future<void> excludeFromBackup(String path) async {
  if (!Platform.isIOS) return;
  try {
    await const MethodChannel(
      'talkpuppy/ios_backup',
    ).invokeMethod('excludeFromBackup', {'path': path});
  } catch (_) {
    // Best-effort: nothing breaks if this fails.
  }
}
