import 'dart:io';

import 'package:flutter/widgets.dart';
import 'package:path/path.dart' as p;
import 'package:path_provider/path_provider.dart';

import '../services/model_manager.dart';
import '../services/recorder_service.dart';
import '../services/settings_service.dart';
import '../services/transcriber_service.dart';
import '../services/vad_asset.dart';
import 'overlay_bridge.dart';
import 'overlay_controller.dart';

/// Body of the overlay engine's entrypoint (`overlayMain` in main.dart),
/// started by the Android accessibility service without any UI. Shares
/// models and settings with the app; recordings go to the cache directory,
/// which Android never backs up.
Future<void> runOverlayEngine() async {
  WidgetsFlutterBinding.ensureInitialized();
  final settings = await SettingsService.create();
  final modelManager = await ModelManager.create();
  final vadModelPath = await extractBundledVadModel();
  final transcriber = TranscriberService();
  await transcriber.start();
  final cacheDir = await getTemporaryDirectory();

  final bridge = OverlayBridge();
  final controller = OverlayController(
    recorder: MicRecorderService(),
    transcriber: transcriber,
    settings: settings,
    modelManager: modelManager,
    vadModelPath: vadModelPath,
    audioDir: Directory(p.join(cacheDir.path, 'overlay')),
    host: bridge,
  );
  await bridge.attach(controller);
}
