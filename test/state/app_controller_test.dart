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
import 'package:talkpuppy/state/app_error.dart';

import '../fakes/fake_recorder_service.dart';
import '../fakes/fake_transcriber.dart';

/// Waits until [controller] has left the recording/transcribing phases
/// (an interruption finishes the recording asynchronously).
Future<void> _settled(AppController controller) async {
  for (var i = 0; i < 500 && controller.isBusy; i++) {
    await Future<void>.delayed(const Duration(milliseconds: 2));
  }
}

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
      stopTail: Duration.zero,
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

  group('streaming model', () {
    const streamingId = 'nemotron-3.5-streaming-0.6b-1120ms-int8';

    setUp(() async {
      final model = modelById(streamingId);
      final modelDir = Directory(modelManager.modelDir(model));
      await modelDir.create(recursive: true);
      for (final f in model.files) {
        File('${modelDir.path}/${f.localName}').openSync(mode: FileMode.write)
          ..truncateSync(f.sizeBytes)
          ..closeSync();
      }
      settings.selectedModelId = streamingId;
      await controller.ensureCurrentModelLoaded();
    });

    test('shows live text while recording and uses the live result', () async {
      await controller.startNewRecording();
      expect(transcriber.log, contains('liveStart'));
      expect(recorder.onSamples, isNotNull);
      expect(controller.liveText, '');

      transcriber.liveOnText!('Hallo');
      expect(controller.liveText, 'Hallo');

      transcriber.liveFinalText = 'Hallo Welt.';
      await controller.stopAndTranscribe();

      expect(controller.liveText, isNull);
      expect(controller.activeRecording!.text, 'Hallo Welt.');
      expect(transcriber.transcribeCalls, 0);
      expect(clipboardText, 'Hallo Welt.');
    });

    test('falls back to the file when the live session was lost', () async {
      await controller.startNewRecording();
      transcriber.liveLost = true;
      transcriber.nextText = 'Aus der Datei';
      await controller.stopAndTranscribe();

      expect(transcriber.log, containsAllInOrder(['liveFinish', 'transcribe']));
      expect(controller.activeRecording!.text, 'Aus der Datei');
      expect(controller.phase, RecordingPhase.done);
    });

    test('cancelling drops the live session', () async {
      await controller.startNewRecording();
      await controller.cancelRecording();

      expect(transcriber.log, contains('liveCancel'));
      expect(controller.liveText, isNull);
      expect(historyStore.recordings, isEmpty);
    });

    test('a too-short clip drops the live session', () async {
      recorder.nextDuration = const Duration(milliseconds: 200);
      await controller.startNewRecording();
      await controller.stopAndTranscribe();

      expect(transcriber.log, contains('liveCancel'));
      expect(transcriber.log, isNot(contains('liveFinish')));
      expect(controller.liveText, isNull);
    });

    test('continuing a recording previews on top of the existing text', () async {
      transcriber.liveFinalText = 'Erster Teil.';
      await controller.startNewRecording();
      await controller.stopAndTranscribe();

      await controller.startContinueRecording();
      expect(controller.isAppendingLive, isTrue);
      transcriber.liveFinalText = 'Zweiter Teil.';
      await controller.stopAndTranscribe();

      expect(controller.activeRecording!.text, 'Erster Teil.\n\nZweiter Teil.');
    });

    test('offline models record without a live session', () async {
      settings.selectedModelId = 'whisper-tiny-int8';
      await controller.ensureCurrentModelLoaded();
      await controller.startNewRecording();

      expect(recorder.onSamples, isNull);
      expect(controller.liveText, isNull);
      await controller.stopAndTranscribe();
      expect(transcriber.log, isNot(contains('liveStart')));
    });

    test('the default language is only forced where the model supports it',
        () async {
      settings.defaultLanguage = 'ja';
      await controller.ensureCurrentModelLoaded();
      expect(transcriber.currentKey, '$streamingId|ja');

      // Parakeet can't force a language, so it gets 'auto'.
      final parakeet = modelById('parakeet-tdt-0.6b-v3-int8');
      final dir = Directory(modelManager.modelDir(parakeet));
      await dir.create(recursive: true);
      for (final f in parakeet.files) {
        File('${dir.path}/${f.localName}').openSync(mode: FileMode.write)
          ..truncateSync(f.sizeBytes)
          ..closeSync();
      }
      settings.selectedModelId = parakeet.id;
      await controller.ensureCurrentModelLoaded();
      expect(transcriber.currentKey, '${parakeet.id}|auto');
    });

    test('keeps recording for the stop tail, offline models do not', () async {
      final tailed = AppController(
        recorder: recorder,
        transcriber: transcriber,
        historyStore: historyStore,
        settings: settings,
        modelManager: modelManager,
        vadModelPath: 'unused-in-tests.onnx',
        useWakelock: false,
        stopTail: const Duration(milliseconds: 100),
      );
      await tailed.init();

      await tailed.startNewRecording();
      final stopping = tailed.stopAndTranscribe();
      await Future<void>.delayed(const Duration(milliseconds: 30));
      expect(tailed.phase, RecordingPhase.transcribing);
      expect(recorder.recording, isTrue);
      expect(tailed.liveText, isNotNull);
      await stopping;
      expect(recorder.recording, isFalse);
      expect(tailed.phase, RecordingPhase.done);

      settings.selectedModelId = 'whisper-tiny-int8';
      await tailed.ensureCurrentModelLoaded();
      await tailed.startNewRecording();
      final offlineStop = tailed.stopAndTranscribe();
      await Future<void>.delayed(Duration.zero);
      expect(recorder.recording, isFalse);
      await offlineStop;
      tailed.dispose();
    });

    test('the tail does not rescue an accidental tap', () async {
      final tailed = AppController(
        recorder: recorder,
        transcriber: transcriber,
        historyStore: historyStore,
        settings: settings,
        modelManager: modelManager,
        vadModelPath: 'unused-in-tests.onnx',
        useWakelock: false,
        stopTail: const Duration(milliseconds: 400),
      );
      await tailed.init();
      // Fake reports 200 ms tap + 400 ms tail.
      recorder.nextDuration = const Duration(milliseconds: 600);
      await tailed.startNewRecording();
      await tailed.stopAndTranscribe();
      expect(historyStore.recordings, isEmpty);
      tailed.dispose();
    });

    test('an empty result leaves the clipboard alone', () async {
      clipboardText = 'something the user copied';
      transcriber.liveFinalText = '';
      await controller.startNewRecording();
      await controller.stopAndTranscribe();

      expect(controller.phase, RecordingPhase.done);
      expect(clipboardText, 'something the user copied');
    });

    test('switching models mid-recording clears the preview and uses the file',
        () async {
      await controller.startNewRecording();
      transcriber.liveOnText!('Hallo');
      expect(controller.liveText, 'Hallo');

      settings.selectedModelId = 'whisper-tiny-int8';
      await controller.ensureCurrentModelLoaded();
      expect(controller.liveText, isNull);

      transcriber.nextText = 'Aus der Datei';
      await controller.stopAndTranscribe();
      expect(transcriber.log, containsAllInOrder(['liveFinish', 'transcribe']));
      expect(controller.activeRecording!.text, 'Aus der Datei');
      expect(controller.activeRecording!.clips.single.modelId,
          'whisper-tiny-int8');
    });

    test('the live result survives the model being deleted mid-recording',
        () async {
      await controller.startNewRecording();
      await modelManager.delete(modelById(streamingId));
      transcriber.liveFinalText = 'Schon erkannt.';
      await controller.stopAndTranscribe();

      expect(controller.phase, RecordingPhase.done);
      expect(controller.activeRecording!.text, 'Schon erkannt.');
      expect(transcriber.transcribeCalls, 0);
    });

    test('live text arriving after stop is ignored', () async {
      await controller.startNewRecording();
      final onText = transcriber.liveOnText!;
      await controller.stopAndTranscribe();

      onText('zu spät');
      expect(controller.liveText, isNull);
    });

    test('backgrounding during the stop tail does not stop twice', () async {
      final tailed = AppController(
        recorder: recorder,
        transcriber: transcriber,
        historyStore: historyStore,
        settings: settings,
        modelManager: modelManager,
        vadModelPath: 'unused-in-tests.onnx',
        useWakelock: false,
        stopTail: const Duration(milliseconds: 50),
      );
      await tailed.init();
      await tailed.startNewRecording();
      final stopping = tailed.stopAndTranscribe();
      await tailed.handleAppBackgrounded();
      await stopping;

      expect(transcriber.log.where((e) => e == 'liveFinish'), hasLength(1));
      expect(historyStore.recordings, hasLength(1));
      tailed.dispose();
    });
  });

  test('cancelRecording claims the phase before the recorder is cancelled',
      () async {
    await controller.startNewRecording();
    final cancelling = controller.cancelRecording();
    expect(controller.phase, isNot(RecordingPhase.recording));
    await controller.stopAndTranscribe(); // must be a no-op now
    await cancelling;

    expect(historyStore.recordings, isEmpty);
    expect(transcriber.transcribeCalls, 0);
  });

  test('purgeExpired drops an expired active recording', () async {
    await controller.startNewRecording();
    await controller.stopAndTranscribe();
    expect(controller.activeRecording, isNotNull);

    await controller.purgeExpired(Duration.zero);
    expect(historyStore.recordings, isEmpty);
    expect(controller.activeRecording, isNull);
    expect(controller.phase, RecordingPhase.idle);
  });

  test('purgeExpired waits while a recording runs', () async {
    await controller.startNewRecording();
    await controller.purgeExpired(Duration.zero);
    await controller.stopAndTranscribe();
    expect(historyStore.recordings, hasLength(1));
  });

  test('an interruption (call, alarm) saves what was recorded so far',
      () async {
    await controller.startNewRecording();
    transcriber.nextText = 'Bis hierhin';
    recorder.interrupt();
    await _settled(controller);

    expect(recorder.recording, isFalse);
    expect(controller.phase, RecordingPhase.done);
    expect(controller.activeRecording!.text, 'Bis hierhin');
    expect(clipboardText, 'Bis hierhin');
  });

  test('an interruption with a streaming model skips the stop tail',
      () async {
    final model = modelById('nemotron-3.5-streaming-0.6b-1120ms-int8');
    final modelDir = Directory(modelManager.modelDir(model));
    await modelDir.create(recursive: true);
    for (final f in model.files) {
      File('${modelDir.path}/${f.localName}').openSync(mode: FileMode.write)
        ..truncateSync(f.sizeBytes)
        ..closeSync();
    }
    settings.selectedModelId = model.id;
    final tailed = AppController(
      recorder: recorder,
      transcriber: transcriber,
      historyStore: historyStore,
      settings: settings,
      modelManager: modelManager,
      vadModelPath: 'unused-in-tests.onnx',
      useWakelock: false,
      stopTail: const Duration(seconds: 5),
    );
    await tailed.init();
    await tailed.startNewRecording();
    transcriber.liveFinalText = 'Vor dem Anruf.';
    final watch = Stopwatch()..start();
    recorder.interrupt();
    await _settled(tailed);

    // No 5 s tail.
    expect(watch.elapsed, lessThan(const Duration(seconds: 1)));
    expect(tailed.phase, RecordingPhase.done);
    expect(tailed.activeRecording!.text, 'Vor dem Anruf.');
    tailed.dispose();
  });

  test('an interruption after stopping does nothing', () async {
    await controller.startNewRecording();
    await controller.stopAndTranscribe();
    recorder.interrupt();
    await pumpEventQueue();
    expect(historyStore.recordings, hasLength(1));
  });

  test('no recording while the floating button dictates', () async {
    controller.overlayBusy = true;
    expect(controller.canRecord, isFalse);
    expect(controller.isBusy, isTrue);
    await controller.startNewRecording();
    expect(recorder.recording, isFalse);
    controller.overlayBusy = false;
    expect(controller.canRecord, isTrue);
  });

  test('a phone call holding the microphone is reported as such', () {
    expect(
      isMicrophoneBusyError(
        'PlatformException(record, Failed to start recording, setActive: Session activation failed, null)',
      ),
      isTrue,
    );
    expect(isMicrophoneBusyError('PlatformException(record, other, null)'), isFalse);
  });

  test('a microphone that never starts gives up with an error', () async {
    final hanging = AppController(
      recorder: recorder,
      transcriber: transcriber,
      historyStore: historyStore,
      settings: settings,
      modelManager: modelManager,
      vadModelPath: 'unused-in-tests.onnx',
      useWakelock: false,
      stopTail: Duration.zero,
      recorderStartTimeout: const Duration(milliseconds: 50),
    );
    await hanging.init();
    recorder.startGate = Completer<void>();
    await hanging.startNewRecording();
    expect(hanging.phase, RecordingPhase.error);
    expect(hanging.error?.kind, AppErrorKind.micBusy);
    // Not stuck: the button can be used again.
    hanging.dismissError();
    expect(hanging.canRecord, isTrue);
    hanging.dispose();
  });
}
