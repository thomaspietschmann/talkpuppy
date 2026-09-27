import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:path/path.dart' as p;
import 'package:path_provider/path_provider.dart';

import 'app.dart';
import 'services/history_store.dart';
import 'services/model_manager.dart';
import 'services/recorder_service.dart';
import 'services/settings_service.dart';
import 'services/transcriber_service.dart';
import 'state/app_controller.dart';
import 'state/controller_scope.dart';

/// How long a history entry is kept before it's purged automatically.
const Duration kHistoryRetention = Duration(days: 3);

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const _BootstrapApp());
}

/// Shows a minimal splash while the app's services (settings, history,
/// model manager, the transcriber isolate) are set up, then hands off to
/// the real app. This only ever runs once per app launch.
class _BootstrapApp extends StatefulWidget {
  const _BootstrapApp();

  @override
  State<_BootstrapApp> createState() => _BootstrapAppState();
}

class _BootstrapAppState extends State<_BootstrapApp> {
  Widget? _child;
  Object? _error;

  @override
  void initState() {
    super.initState();
    _bootstrap();
  }

  Future<void> _bootstrap() async {
    try {
      final settings = await SettingsService.create();
      final historyStore = await HistoryStore.create();
      await historyStore.purgeOlderThan(kHistoryRetention);
      final modelManager = await ModelManager.create();
      final vadModelPath = await _extractBundledVadModel();

      final recorder = MicRecorderService();
      final transcriber = TranscriberService();
      await transcriber.start();

      final controller = AppController(
        recorder: recorder,
        transcriber: transcriber,
        historyStore: historyStore,
        settings: settings,
        modelManager: modelManager,
        vadModelPath: vadModelPath,
      );
      await controller.init();

      if (!mounted) return;
      setState(() {
        _child = ControllerScope(
          controller: controller,
          settings: settings,
          historyStore: historyStore,
          modelManager: modelManager,
          child: const TalkpuppyApp(),
        );
      });
    } catch (e) {
      if (!mounted) return;
      setState(() => _error = e);
    }
  }

  @override
  Widget build(BuildContext context) {
    if (_child != null) return _child!;
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: Center(
          child: _error == null
              ? const CircularProgressIndicator()
              : Padding(
                  padding: const EdgeInsets.all(24),
                  child: Text(
                    'Talkpuppy konnte nicht gestartet werden:\n$_error',
                    textAlign: TextAlign.center,
                  ),
                ),
        ),
      ),
    );
  }
}

/// The Silero VAD model is bundled as a Flutter asset (it's tiny), but
/// sherpa-onnx needs a real file path, not an asset key — so it's copied
/// out to app support storage once.
Future<String> _extractBundledVadModel() async {
  final supportDir = await getApplicationSupportDirectory();
  final file = File(p.join(supportDir.path, 'silero_vad.onnx'));
  if (!await file.exists()) {
    final data = await rootBundle.load('assets/models/silero_vad.onnx');
    await file.writeAsBytes(
      data.buffer.asUint8List(data.offsetInBytes, data.lengthInBytes),
    );
  }
  return file.path;
}
