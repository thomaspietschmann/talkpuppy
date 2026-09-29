import 'dart:io';

import 'package:flutter/services.dart';

/// The app's side of the Android floating button (`talkpuppy/overlay_setup`
/// channel): whether its accessibility service is on, opening the system
/// settings, and coordinating who holds a model in memory. Every call is a
/// harmless no-op on iOS and in tests.
class OverlaySetupService {
  static const _channel = MethodChannel('talkpuppy/overlay_setup');

  static bool get isSupported => Platform.isAndroid;

  static Future<bool> isServiceEnabled() async {
    if (!isSupported) return false;
    try {
      return await _channel.invokeMethod<bool>('isServiceEnabled') ?? false;
    } on MissingPluginException {
      return false;
    }
  }

  /// Whether the user turned on the system "Shortcut" for our accessibility
  /// service, which pins a confusing app icon to the screen edge.
  static Future<bool> isShortcutEnabled() async {
    if (!isSupported) return false;
    try {
      return await _channel.invokeMethod<bool>('isShortcutEnabled') ?? false;
    } on MissingPluginException {
      return false;
    }
  }

  /// Talkpuppy's page in the accessibility settings (falls back to the list).
  static Future<void> openServiceSettings() => _call('openServiceSettings');

  static Future<void> openAccessibilitySettings() =>
      _call('openAccessibilitySettings');

  /// Android 13+: lets the recording notification (with its Stop button)
  /// show. Recording works without it too.
  static Future<void> requestNotificationPermission() =>
      _call('requestNotificationPermission');

  /// Sends the app to the background, where the floating button takes over.
  static Future<void> minimizeApp() => _call('minimizeApp');

  static Future<void> _call(String method) async {
    if (!isSupported) return;
    try {
      await _channel.invokeMethod<void>(method);
    } on MissingPluginException {
      // Not available (tests, other platforms).
    }
  }
}
