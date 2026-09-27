import 'package:flutter/services.dart';

/// Reads the device's total physical RAM through a tiny native platform
/// channel (Android: `ActivityManager.MemoryInfo`, iOS:
/// `ProcessInfo.physicalMemory`) — there's no cross-platform Dart API for
/// this. Used only to pick a sane default model during onboarding.
class DeviceRamService {
  static const _channel = MethodChannel('talkpuppy/device_info');

  /// Total device RAM in whole GB, rounded to the nearest GB. Falls back to
  /// a conservative `4` if the platform call fails (e.g. desktop/web during
  /// development).
  static Future<int> totalRamGb() async {
    try {
      final bytes = await _channel.invokeMethod<int>('totalRamBytes');
      if (bytes == null || bytes <= 0) return 4;
      return (bytes / (1024 * 1024 * 1024)).round();
    } catch (_) {
      return 4;
    }
  }
}
