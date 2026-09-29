import 'dart:io';

import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:talkpuppy/overlay/overlay_bridge.dart';
import 'package:talkpuppy/overlay/overlay_controller.dart';
import 'package:talkpuppy/services/model_manager.dart';
import 'package:talkpuppy/services/settings_service.dart';

import '../fakes/fake_recorder_service.dart';
import '../fakes/fake_transcriber.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();
  const channel = MethodChannel('talkpuppy/overlay');

  test('attach works when the accessibility service is not listening', () async {
    // No mock handler: like the real app with the service turned off.
    SharedPreferences.setMockInitialValues({});
    final dir = Directory.systemTemp.createTempSync('talkpuppy_bridge_test_');
    addTearDown(() => dir.deleteSync(recursive: true));
    final bridge = OverlayBridge(channel: channel);
    final controller = OverlayController(
      recorder: FakeRecorderService(),
      transcriber: FakeTranscriber(),
      settings: await SettingsService.create(),
      modelManager: ModelManager(Directory('${dir.path}/models')),
      vadModelPath: 'unused.onnx',
      audioDir: Directory('${dir.path}/overlay'),
      host: bridge,
      serialize: <T>(Future<T> Function() action) => action(),
    );
    await expectLater(bridge.attach(controller), completes);
  });
}
