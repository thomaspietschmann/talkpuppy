import 'dart:io';

import 'package:flutter/services.dart';
import 'package:path/path.dart' as p;
import 'package:path_provider/path_provider.dart';

import 'backup_exclusion.dart';

/// The Silero VAD model is bundled as a Flutter asset (it's tiny), but
/// sherpa-onnx needs a real file path, not an asset key — so it's copied
/// out to app support storage once. Shared by the app and the Android
/// overlay engine.
Future<String> extractBundledVadModel() async {
  final supportDir = await getApplicationSupportDirectory();
  final file = File(p.join(supportDir.path, 'silero_vad.onnx'));
  final data = await rootBundle.load('assets/models/silero_vad.onnx');
  // Re-extract if missing or a previous write was cut short.
  if (!await file.exists() || await file.length() != data.lengthInBytes) {
    final tmp = File('${file.path}.tmp');
    await tmp.writeAsBytes(
      data.buffer.asUint8List(data.offsetInBytes, data.lengthInBytes),
      flush: true,
    );
    await tmp.rename(file.path);
  }
  // Bundled with the app anyway; no reason to back it up.
  await excludeFromBackup(file.path);
  return file.path;
}
