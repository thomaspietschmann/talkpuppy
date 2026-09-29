import 'dart:async';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:path/path.dart' as p;
import 'package:path_provider/path_provider.dart';

import 'app.dart';
import 'l10n/app_localizations.dart';
import 'l10n/locales.dart';
import 'licenses.dart';
import 'overlay/overlay_bridge.dart';
import 'overlay/overlay_controller.dart';
import 'services/backup_exclusion.dart';
import 'services/history_store.dart';
import 'services/model_manager.dart';
import 'services/recorder_service.dart';
import 'services/settings_service.dart';
import 'services/transcriber_service.dart';
import 'services/vad_asset.dart';
import 'state/app_controller.dart';
import 'state/controller_scope.dart';

/// How long a history entry is kept before it's purged automatically.
const Duration kHistoryRetention = Duration(days: 3);

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  registerModelLicenses();
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
  AppLifecycleListener? _lifecycleListener;
  Timer? _purgeTimer;

  @override
  void initState() {
    super.initState();
    _bootstrap();
  }

  @override
  void dispose() {
    _lifecycleListener?.dispose();
    _purgeTimer?.cancel();
    super.dispose();
  }

  Future<void> _bootstrap() async {
    try {
      // Nothing in app support storage (recordings, transcripts, models)
      // may ever reach iCloud. Each store also excludes its own directory;
      // this covers everything else and any file created later.
      await excludeFromBackup((await getApplicationSupportDirectory()).path);
      final settings = await SettingsService.create();
      final historyStore = await HistoryStore.create();
      await historyStore.purgeOlderThan(kHistoryRetention);
      final modelManager = await ModelManager.create();
      final vadModelPath = await extractBundledVadModel();

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
      if (Platform.isAndroid) {
        await _attachFloatingButton(
          controller: controller,
          transcriber: transcriber,
          settings: settings,
          modelManager: modelManager,
          vadModelPath: vadModelPath,
        );
      }
      _lifecycleListener = AppLifecycleListener(
        onHide: controller.handleAppBackgrounded,
        onShow: () async {
          await controller.purgeExpired(kHistoryRetention);
          // The floating button may have been closed from its ✕ (written
          // by the accessibility service, not through Dart).
          await settings.reload();
        },
      );
      // While the app stays in the foreground for long, too.
      _purgeTimer = Timer.periodic(
        const Duration(hours: 1),
        (_) => controller.purgeExpired(kHistoryRetention),
      );

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
    // Settings aren't loaded yet here, so this follows the system language.
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      supportedLocales: [for (final code in kAppLanguages.keys) Locale(code)],
      localizationsDelegates: kLocalizationsDelegates,
      localeListResolutionCallback: (deviceLocales, _) =>
          resolveAppLocale(deviceLocales),
      home: Scaffold(
        body: Center(
          child: _error == null
              ? const CircularProgressIndicator()
              : Builder(
                  builder: (context) => Padding(
                    padding: const EdgeInsets.all(24),
                    child: Text(
                      AppLocalizations.of(context).startupFailed('$_error'),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
        ),
      ),
    );
  }
}

/// Android: the floating button's recordings run here, in the app's engine,
/// with the app's transcriber and loaded model (the native side shares
/// this engine, see TalkpuppyEngine.kt). Recordings go to the cache
/// directory, which Android never backs up, and are deleted right after.
Future<void> _attachFloatingButton({
  required AppController controller,
  required TranscriberService transcriber,
  required SettingsService settings,
  required ModelManager modelManager,
  required String vadModelPath,
}) async {
  final cacheDir = await getTemporaryDirectory();
  final bridge = OverlayBridge();
  final overlay = OverlayController(
    recorder: MicRecorderService(),
    transcriber: transcriber,
    settings: settings,
    modelManager: modelManager,
    vadModelPath: vadModelPath,
    audioDir: Directory(p.join(cacheDir.path, 'overlay')),
    host: bridge,
    serialize: controller.serialized,
    onBusyChanged: (busy) => controller.overlayBusy = busy,
  );
  await bridge.attach(overlay);
}
