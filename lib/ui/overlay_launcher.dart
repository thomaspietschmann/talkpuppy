import 'package:flutter/material.dart';

import '../l10n/l10n_text.dart';
import '../services/overlay_setup_service.dart';
import '../services/settings_service.dart';

/// "Minimize and show overlay" (Android): turns the floating button on and
/// sends the app to the background. The first time, the accessibility
/// service has to be enabled in the system settings; after the user comes
/// back with it on, the app minimizes on its own. While the app is open the
/// button stays, greyed out; the ✕ closes it.
class OverlayLauncher {
  OverlayLauncher(this.settings);

  final SettingsService settings;

  /// Set while the user is in the accessibility settings for us.
  bool _awaitingService = false;

  Future<void> launch(BuildContext context) async {
    // Android 13+: the recording notification carries the Stop button.
    // Asked here, while the app is still in front to show the dialog.
    await OverlaySetupService.requestNotificationPermission();
    if (await OverlaySetupService.isServiceEnabled()) {
      await _minimize();
      return;
    }
    if (!context.mounted) return;
    final proceed = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(context.l10n.overlaySetupTitle),
        content: SingleChildScrollView(
          child: Text(
            '${context.l10n.overlaySetupBody}\n\n${context.l10n.overlaySetupShortcut}\n\n'
            '${context.l10n.overlayRestrictedHint}',
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: Text(context.l10n.cancel),
          ),
          FilledButton(
            onPressed: () => Navigator.pop(context, true),
            child: Text(context.l10n.overlayOpenAccessibility),
          ),
        ],
      ),
    );
    if (proceed != true) return;
    _awaitingService = true;
    await OverlaySetupService.openAccessibilitySettings();
  }

  /// Call when the app comes back to the foreground.
  Future<void> onResumed() async {
    if (!_awaitingService) return;
    _awaitingService = false;
    if (await OverlaySetupService.isServiceEnabled()) await _minimize();
  }

  Future<void> _minimize() async {
    // Written before minimizing: the app frees its model on the way out
    // when the overlay is on, and the service shows the button on change.
    settings.overlayEnabled = true;
    await OverlaySetupService.minimizeApp();
  }
}
