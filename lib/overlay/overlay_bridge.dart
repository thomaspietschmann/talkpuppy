import 'package:flutter/services.dart';

import 'overlay_controller.dart';

/// The overlay engine's side of the `talkpuppy/overlay` channel. The
/// Kotlin accessibility service sends commands; this reports session
/// progress back. Every message carries the session id, so results of a
/// session the native side already gave up on are ignored there.
class OverlayBridge implements OverlayHost {
  OverlayBridge({MethodChannel? channel})
    : _channel = channel ?? const MethodChannel('talkpuppy/overlay');

  final MethodChannel _channel;
  OverlayController? _controller;

  /// Starts handling commands for [controller] and tells the native side
  /// that the engine is ready.
  Future<void> attach(OverlayController controller) async {
    _controller = controller;
    _channel.setMethodCallHandler(_handle);
    await _channel.invokeMethod<void>('ready');
  }

  Future<Object?> _handle(MethodCall call) async {
    final controller = _controller;
    if (controller == null) return null;
    final args = (call.arguments as Map?)?.cast<String, Object?>() ?? {};
    final sessionId = args['sessionId'] as String? ?? '';
    switch (call.method) {
      case 'startSession':
        // Not awaited: progress arrives through sessionState/result, and
        // the native side must be able to send stop meanwhile.
        controller.startSession(sessionId);
      case 'stopSession':
        controller.stopSession(sessionId);
      case 'cancelSession':
        await controller.cancelSession(sessionId);
      case 'unloadModel':
        await controller.unloadModel();
      default:
        throw MissingPluginException('overlay: ${call.method}');
    }
    return null;
  }

  @override
  void sessionState(String sessionId, String state) =>
      _send('sessionState', {'sessionId': sessionId, 'state': state});

  @override
  void amplitude(String sessionId, double level) =>
      _send('amplitude', {'sessionId': sessionId, 'level': level});

  @override
  void result(String sessionId, String text, String language, int durationMs) =>
      _send('result', {
        'sessionId': sessionId,
        'text': text,
        'language': language,
        'durationMs': durationMs,
      });

  @override
  void error(String sessionId, OverlayErrorKind kind, String detail) => _send(
    'error',
    {'sessionId': sessionId, 'kind': kind.name, 'detail': detail},
  );

  void _send(String method, Map<String, Object?> args) {
    _channel.invokeMethod<void>(method, args).catchError((Object _) {
      // The native side went away (service stopped); nothing to report to.
    });
  }
}
