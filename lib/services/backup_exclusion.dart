import 'dart:io';

import 'package:flutter/services.dart';

/// Excludes [path] (a file, or a directory including everything in it)
/// from iCloud backup on iOS; no-op elsewhere, since Android backup and
/// device transfer are disabled in the manifest and data extraction rules.
/// Used for the app support directory as a whole, the private recording
/// history and the models: none of them may ever leave the device.
Future<void> excludeFromBackup(String path) async {
  if (!Platform.isIOS) return;
  const channel = MethodChannel('talkpuppy/ios_backup');
  // The native side verifies the flag; retry once if it didn't stick.
  for (var attempt = 0; attempt < 2; attempt++) {
    try {
      await channel.invokeMethod('excludeFromBackup', {'path': path});
      return;
    } catch (_) {
      // Nothing else to do here; it's reapplied on every start and
      // whenever a directory is (re)created.
    }
  }
}
