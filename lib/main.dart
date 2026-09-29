import 'dart:async';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';

import 'app.dart';
import 'l10n/app_localizations.dart';
import 'l10n/locales.dart';
import 'licenses.dart';
import 'overlay/overlay_main.dart';
import 'services/backup_exclusion.dart';
import 'services/history_store.dart';
import 'services/model_manager.dart';
import 'services/overlay_setup_service.dart';
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

/// Entry point of the second, UI-less Flutter engine the Android
/// accessibility service starts for the floating record button.
@pragma('vm:entry-point')
Future<void> overlayMain() => runOverlayEngine();

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
      _lifecycleListener = AppLifecycleListener(
        onHide: () async {
          await controller.handleAppBackgrounded();
          // Only one model in memory: with the floating button on, the
          // overlay loads its own while the app is in the background.
          if (settings.overlayEnabled) await controller.releaseModel();
        },
        onShow: () async {
          await controller.purgeExpired(kHistoryRetention);
          // The overlay may have been closed from its ✕ meanwhile (written
          // by the accessibility service, not through this engine).
          await settings.reload();
          if (settings.overlayEnabled) {
            // Back in the app: the overlay closes, like picture-in-picture.
            settings.overlayEnabled = false;
            // It frees its model now (or after a running dictation); load
            // ours only once that's done.
            await OverlaySetupService.waitUntilOverlayIdle();
            await controller.ensureCurrentModelLoaded();
          }
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
