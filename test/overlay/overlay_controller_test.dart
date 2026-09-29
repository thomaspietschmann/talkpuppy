import 'dart:io';

import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:talkpuppy/models/catalog.dart';
import 'package:talkpuppy/overlay/overlay_controller.dart';
import 'package:talkpuppy/services/model_manager.dart';
import 'package:talkpuppy/services/settings_service.dart';

import '../fakes/fake_recorder_service.dart';
import '../fakes/fake_transcriber.dart';

/// Records what the controller reports to the native side.
class _FakeHost implements OverlayHost {
  final events = <String>[];
  final results = <String>[];
  final errors = <OverlayErrorKind>[];
  final levels = <double>[];

  @override
  void sessionState(String sessionId, String state) =>
      events.add('$sessionId:$state');

  @override
  void amplitude(String sessionId, double level) => levels.add(level);

  @override
  void result(String sessionId, String text, String language, int durationMs) {
    events.add('$sessionId:result');
    results.add(text);
  }

  @override
  void error(String sessionId, OverlayErrorKind kind, String detail) {
    events.add('$sessionId:error');
    errors.add(kind);
  }
}

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  late Directory tempDir;
  late FakeRecorderService recorder;
  late FakeTranscriber transcriber;
  late SettingsService settings;
  late ModelManager modelManager;
  late _FakeHost host;
  late OverlayController controller;

  Future<void> installModel(String id) async {
    final model = modelById(id);
    final dir = Directory(modelManager.modelDir(model));
    await dir.create(recursive: true);
    for (final f in model.files) {
      File('${dir.path}/${f.localName}').openSync(mode: FileMode.write)
        ..truncateSync(f.sizeBytes)
        ..closeSync();
    }
  }

  OverlayController build({Duration idle = const Duration(minutes: 3)}) =>
      OverlayController(
        recorder: recorder,
        transcriber: transcriber,
        settings: settings,
        modelManager: modelManager,
        vadModelPath: 'unused.onnx',
        audioDir: Directory('${tempDir.path}/overlay'),
        host: host,
        idleUnloadAfter: idle,
      );

  setUp(() async {
    tempDir = Directory.systemTemp.createTempSync('talkpuppy_overlay_test_');
    SharedPreferences.setMockInitialValues({});
    settings = await SettingsService.create();
    modelManager = ModelManager(Directory('${tempDir.path}/models'));
    await installModel('whisper-tiny-int8');
    settings.selectedModelId = 'whisper-tiny-int8';
    recorder = FakeRecorderService();
    transcriber = FakeTranscriber();
    host = _FakeHost();
    controller = build();
  });

  tearDown(() {
    controller.dispose();
    if (tempDir.existsSync()) tempDir.deleteSync(recursive: true);
  });

  test('records, transcribes and reports the text', () async {
    transcriber.nextText = 'Hallo Welt';
    await controller.startSession('s1');
    expect(recorder.recording, isTrue);
    expect(host.events, ['s1:recording']);
    expect(transcriber.currentKey, 'whisper-tiny-int8|auto');

    await controller.stopSession('s1');
    expect(host.events, ['s1:recording', 's1:transcribing', 's1:result']);
    expect(host.results, ['Hallo Welt']);
    expect(controller.isBusy, isFalse);
  });

  test('deletes the recording afterwards', () async {
    await controller.startSession('s1');
    final wav = File(recorder.lastStartedPath!);
    expect(wav.existsSync(), isTrue);
    await controller.stopSession('s1');
    expect(wav.existsSync(), isFalse);
  });

  test('uses the app language where the model can force it', () async {
    settings.defaultLanguage = 'de';
    await controller.startSession('s1');
    await controller.stopSession('s1');
    expect(transcriber.currentKey, 'whisper-tiny-int8|de');
  });

  test('reports an error when no model is installed', () async {
    settings.selectedModelId = 'parakeet-tdt-0.6b-v3-int8';
    await controller.startSession('s1');
    expect(host.errors, [OverlayErrorKind.noModel]);
    expect(recorder.recording, isFalse);
    expect(controller.isBusy, isFalse);
  });

  test('a too-short clip gives an empty result without transcribing', () async {
    recorder.nextDuration = const Duration(milliseconds: 200);
    await controller.startSession('s1');
    await controller.stopSession('s1');
    expect(host.results, ['']);
    expect(transcriber.transcribeCalls, 0);
  });

  test('a model that fails to load is reported at stop', () async {
    transcriber.ensureModelFailures = 1;
    await controller.startSession('s1');
    await controller.stopSession('s1');
    expect(host.errors, [OverlayErrorKind.modelLoad]);
  });

  test('an interruption (call, alarm) stops and delivers the text', () async {
    transcriber.nextText = 'Bis hierhin';
    await controller.startSession('s1');
    recorder.interrupt();
    for (var i = 0; i < 200 && controller.isBusy; i++) {
      await Future<void>.delayed(const Duration(milliseconds: 2));
    }
    expect(host.results, ['Bis hierhin']);
  });

  test('cancel drops the recording without a result', () async {
    await controller.startSession('s1');
    final wav = File(recorder.lastStartedPath!);
    await controller.cancelSession('s1');
    expect(recorder.recording, isFalse);
    expect(host.results, isEmpty);
    expect(wav.existsSync(), isFalse);
  });

  test('ignores commands for another session', () async {
    await controller.startSession('s1');
    await controller.stopSession('other');
    expect(recorder.recording, isTrue);
    await controller.stopSession('s1');
    expect(host.results, hasLength(1));
  });

  test('unloads the model after the idle time', () async {
    controller.dispose();
    controller = build(idle: const Duration(milliseconds: 20));
    await controller.startSession('s1');
    await controller.stopSession('s1');
    expect(transcriber.unloadCalls, 0);
    await Future<void>.delayed(const Duration(milliseconds: 60));
    expect(transcriber.unloadCalls, 1);
  });

  test('an unload request during a session waits for its end', () async {
    await controller.startSession('s1');
    await controller.unloadModel();
    expect(transcriber.unloadCalls, 0);
    await controller.stopSession('s1');
    expect(transcriber.unloadCalls, 1);
    expect(host.results, hasLength(1));
  });

  test('picks up settings the app changed meanwhile', () async {
    await installModel('whisper-base-int8');
    await controller.startSession('s1');
    await controller.stopSession('s1');
    // Written by "the app" (another engine) directly to the store.
    SharedPreferences.setMockInitialValues({
      'flutter.selectedModelId': 'whisper-base-int8',
    });
    await controller.startSession('s2');
    await controller.stopSession('s2');
    expect(transcriber.currentKey, startsWith('whisper-base-int8'));
  });
}
