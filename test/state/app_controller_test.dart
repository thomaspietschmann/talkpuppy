import 'dart:async';
import 'dart:io';

import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:talkpuppy/models/catalog.dart';
import 'package:talkpuppy/models/recording.dart';
import 'package:talkpuppy/services/history_store.dart';
import 'package:talkpuppy/services/model_manager.dart';
import 'package:talkpuppy/services/settings_service.dart';
import 'package:talkpuppy/state/app_controller.dart';

import '../fakes/fake_recorder_service.dart';
import '../fakes/fake_transcriber.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  late Directory tempDir;
  late FakeRecorderService recorder;
  late FakeTranscriber transcriber;
  late HistoryStore historyStore;
  late SettingsService settings;
  late ModelManager modelManager;
  late AppController controller;
  String? clipboardText;

  setUp(() async {
    tempDir = Directory.systemTemp.createTempSync('talkpuppy_controller_test_');
    TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger
        .setMockMethodCallHandler(SystemChannels.platform, (call) async {
          if (call.method == 'Clipboard.setData') {
            clipboardText = (call.arguments as Map)['text'] as String?;
          }
          return null;
        });

    SharedPreferences.setMockInitialValues({});
    settings = await SettingsService.create();

    historyStore = HistoryStore(Directory('${tempDir.path}/history'));
    modelManager = ModelManager(Directory('${tempDir.path}/models'));

    // Pretend whisper-tiny is already downloaded: isDownloaded() checks
    // existence and exact size, so create sparse files of the right length
    // (no real disk usage).
    final model = modelById('whisper-tiny-int8');
    final modelDir = Directory(modelManager.modelDir(model));
    await modelDir.create(recursive: true);
    for (final f in model.files) {
      File('${modelDir.path}/${f.localName}').openSync(mode: FileMode.write)
        ..truncateSync(f.sizeBytes)
        ..closeSync();
    }
    settings.selectedModelId = model.id;

    recorder = FakeRecorderService();
    transcriber = FakeTranscriber();

    controller = AppController(
      recorder: recorder,
      transcriber: transcriber,
      historyStore: historyStore,
      settings: settings,
      modelManager: modelManager,
      vadModelPath: 'unused-in-tests.onnx',
      useWakelock: false,
    );
    await controller.init();
  });

  tearDown(() {
    clipboardText = null;
    if (tempDir.existsSync()) tempDir.deleteSync(recursive: true);
  });

  test('init loads the selected model', () {
    expect(controller.modelReady, isTrue);
    expect(transcriber.ensureModelCalls, greaterThan(0));
  });

  test('recording a clip goes idle -> recording -> done and copies to clipboard', () async {
    expect(controller.phase, RecordingPhase.idle);

    await controller.startNewRecording();
    expect(controller.phase, RecordingPhase.recording);
    expect(recorder.recording, isTrue);

    transcriber.nextText = 'Hallo Welt';
    await controller.stopAndTranscribe();

    expect(controller.phase, RecordingPhase.done);
    expect(controller.activeRecording, isNotNull);
    expect(controller.activeRecording!.text, 'Hallo Welt');
    expect(historyStore.recordings, hasLength(1));
    expect(clipboardText, 'Hallo Welt');
  });

  test('auto-copy disabled means clipboard stays untouched', () async {
    settings.autoCopy = false;

    await controller.startNewRecording();
    await controller.stopAndTranscribe();

    expect(controller.phase, RecordingPhase.done);
    expect(clipboardText, isNull);
  });

  test('a clip shorter than the minimum duration is discarded', () async {
    recorder.nextDuration = const Duration(milliseconds: 200);

    await controller.startNewRecording();
    await controller.stopAndTranscribe();

    expect(controller.phase, RecordingPhase.idle);
    expect(controller.activeRecording, isNull);
    expect(historyStore.recordings, isEmpty);
    expect(transcriber.transcribeCalls, 0);
  });

  test('continue recording appends a clip to the same entry', () async {
    transcriber.nextText = 'Erster Teil';
    await controller.startNewRecording();
    await controller.stopAndTranscribe();
    final firstId = controller.activeRecording!.id;

    transcriber.nextText = 'Zweiter Teil';
    await controller.startContinueRecording();
    expect(controller.phase, RecordingPhase.recording);
    await controller.stopAndTranscribe();

    expect(controller.activeRecording!.id, firstId);
    expect(controller.activeRecording!.clips, hasLength(2));
    expect(controller.activeRecording!.text, 'Erster Teil\n\nZweiter Teil');
    expect(historyStore.recordings, hasLength(1));
  });

  test('new recording after done starts a separate history entry', () async {
    await controller.startNewRecording();
    await controller.stopAndTranscribe();
    final firstId = controller.activeRecording!.id;

    await controller.startNewRecording();
    await controller.stopAndTranscribe();

    expect(controller.activeRecording!.id, isNot(firstId));
    expect(historyStore.recordings, hasLength(2));
  });

  test('retranscribeRecording replaces every clip\'s text', () async {
    await controller.startNewRecording();
    await controller.stopAndTranscribe();
    final recording = controller.activeRecording!;

    transcriber.nextText = 'Corrected text';
    transcriber.nextLanguage = 'en';
    await controller.retranscribeRecording(
      recording,
      model: modelById('whisper-tiny-int8'),
      language: 'en',
    );

    expect(controller.phase, RecordingPhase.done);
    expect(recording.text, 'Corrected text');
    expect(recording.latestLanguage, 'en');
  });

  test('a transcription error surfaces, keeps the audio as an error clip, '
      'and can be dismissed', () async {
    transcriber.throwOnTranscribe = true;

    await controller.startNewRecording();
    final wavPath = recorder.lastStartedPath!;
    await controller.stopAndTranscribe();

    expect(controller.phase, RecordingPhase.error);
    expect(controller.error, isNotNull);
    // Audio isn't silently orphaned: it's tracked (so the purge covers it)
    // and can be retranscribed later.
    expect(historyStore.recordings, hasLength(1));
    expect(historyStore.recordings.single.clips.single.status, ClipStatus.error);
    expect(File(wavPath).existsSync(), isTrue);

    controller.dismissError();
    expect(controller.phase, RecordingPhase.done);
    expect(controller.error, isNull);
  });

  test('a failed model load is retried, not cached as loaded', () async {
    transcriber.ensureModelFailures = 1;
    settings.defaultLanguage = 'de'; // forces a different load key
    await controller.ensureCurrentModelLoaded();
    expect(controller.modelReady, isFalse);
    expect(controller.modelError, isNotNull);

    final callsBefore = transcriber.ensureModelCalls;
    await controller.ensureCurrentModelLoaded();
    expect(transcriber.ensureModelCalls, callsBefore + 1);
    expect(controller.modelReady, isTrue);
    expect(controller.modelError, isNull);
  });

  test('a fast double tap starts the recorder only once', () async {
    var starts = 0;
    recorder.onStart = () => starts++;

    await Future.wait([
      controller.startNewRecording(),
      controller.startNewRecording(),
    ]);

    expect(starts, 1);
    expect(controller.phase, RecordingPhase.recording);
  });

  test('history edits are refused while recording', () async {
    await controller.startNewRecording();
    await controller.stopAndTranscribe();
    final recording = controller.activeRecording!;

    await controller.startNewRecording();
    expect(controller.phase, RecordingPhase.recording);

    expect(await controller.deleteRecording(recording.id), isFalse);
    expect(await controller.deleteAllRecordings(), isFalse);
    await controller.retranscribeRecording(
      recording,
      model: modelById('whisper-tiny-int8'),
      language: 'en',
    );

    expect(controller.phase, RecordingPhase.recording);
    expect(recorder.recording, isTrue);
    expect(historyStore.recordings, hasLength(1));

    // And the live recording can still be stopped normally.
    await controller.stopAndTranscribe();
    expect(controller.phase, RecordingPhase.done);
  });

  test('model load and transcribe are never interleaved', () async {
    // Hold a live transcription in flight...
    await controller.startNewRecording();
    transcriber.transcribeGate = Completer<void>();
    final live = controller.stopAndTranscribe();
    while (!transcriber.log.contains('transcribe')) {
      await Future<void>.delayed(Duration.zero);
    }

    // ...while something else asks for a different model.
    settings.defaultLanguage = 'en';
    final switchModel = controller.ensureCurrentModelLoaded();
    // Give an (incorrectly) unserialized switch ample time to reach the
    // transcriber before the live transcription is released.
    await Future<void>.delayed(const Duration(milliseconds: 100));

    transcriber.transcribeGate!.complete();
    await Future.wait([live, switchModel]);

    // The live clip must finish with the model it was started with; the
    // switch only applies afterwards.
    expect(transcriber.finishedWithKey, ['whisper-tiny-int8|auto']);
    expect(transcriber.currentKey, 'whisper-tiny-int8|en');
  });

  test('deleteRecording removes it from history and clears activeRecording', () async {
    await controller.startNewRecording();
    await controller.stopAndTranscribe();
    final id = controller.activeRecording!.id;

    await controller.deleteRecording(id);

    expect(historyStore.recordings, isEmpty);
    expect(controller.activeRecording, isNull);
    expect(controller.phase, RecordingPhase.idle);
  });

  test('deleteAllRecordings clears history and active recording', () async {
    await controller.startNewRecording();
    await controller.stopAndTranscribe();
    await controller.startNewRecording();
    await controller.stopAndTranscribe();

    await controller.deleteAllRecordings();

    expect(historyStore.recordings, isEmpty);
    expect(controller.activeRecording, isNull);
  });

  test('copyToClipboard copies an arbitrary recording\'s text', () async {
    await controller.startNewRecording();
    transcriber.nextText = 'Kopiertext';
    await controller.stopAndTranscribe();

    clipboardText = null;
    await controller.copyToClipboard(controller.activeRecording!);

    expect(clipboardText, 'Kopiertext');
  });
}
