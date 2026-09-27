import 'dart:io';

import 'package:flutter_test/flutter_test.dart';
import 'package:talkpuppy/models/recording.dart';
import 'package:talkpuppy/services/history_store.dart';

Recording _recording(String id, DateTime updatedAt, {String wavFileName = ''}) {
  return Recording(
    id: id,
    createdAt: updatedAt,
    updatedAt: updatedAt,
    clips: [
      Clip(
        id: '$id-clip',
        wavFileName: wavFileName.isEmpty ? '$id.wav' : wavFileName,
        text: 'text $id',
        language: 'de',
        modelId: 'm1',
        durationMs: 1000,
        createdAt: updatedAt,
      ),
    ],
  );
}

void main() {
  late Directory tempDir;

  setUp(() {
    tempDir = Directory.systemTemp.createTempSync('talkpuppy_history_test_');
  });

  tearDown(() {
    if (tempDir.existsSync()) tempDir.deleteSync(recursive: true);
  });

  test('addRecording persists and reloads newest-first', () async {
    final store = HistoryStore(tempDir);
    final now = DateTime.now();
    await store.addRecording(_recording('a', now.subtract(const Duration(minutes: 1))));
    await store.addRecording(_recording('b', now));

    expect(store.recordings.map((r) => r.id).toList(), ['b', 'a']);

    final reloaded = HistoryStore(tempDir);
    await reloaded.load();
    expect(reloaded.recordings.map((r) => r.id).toList(), ['b', 'a']);
  });

  test('a missing index file means an empty history, not a crash', () async {
    final store = HistoryStore(tempDir);
    await store.load();
    expect(store.recordings, isEmpty);
  });

  test('a corrupt index file is treated as empty history', () async {
    await tempDir.create(recursive: true);
    await File('${tempDir.path}/recordings.json').writeAsString('not json');

    final store = HistoryStore(tempDir);
    await store.load();
    expect(store.recordings, isEmpty);
  });

  test('deleteRecording removes the entry and its WAV file', () async {
    final store = HistoryStore(tempDir);
    final recording = _recording('a', DateTime.now());
    await store.addRecording(recording);

    final wavFile = File(store.wavPathFor(recording.clips.first.wavFileName));
    await wavFile.create(recursive: true);
    expect(wavFile.existsSync(), isTrue);

    await store.deleteRecording('a');

    expect(store.recordings, isEmpty);
    expect(wavFile.existsSync(), isFalse);
  });

  test('deleteAll clears every recording and its WAV files', () async {
    final store = HistoryStore(tempDir);
    await store.addRecording(_recording('a', DateTime.now()));
    await store.addRecording(_recording('b', DateTime.now()));
    await File(
      store.wavPathFor('a.wav'),
    ).create(recursive: true);
    await File(
      store.wavPathFor('b.wav'),
    ).create(recursive: true);

    await store.deleteAll();

    expect(store.recordings, isEmpty);
    expect(File(store.wavPathFor('a.wav')).existsSync(), isFalse);
    expect(File(store.wavPathFor('b.wav')).existsSync(), isFalse);
  });

  test('purgeOlderThan removes only entries past the retention window', () async {
    final store = HistoryStore(tempDir);
    final now = DateTime(2026, 1, 10);
    await store.addRecording(_recording('old', now.subtract(const Duration(days: 4))));
    await store.addRecording(_recording('recent', now.subtract(const Duration(hours: 1))));

    final removedCount = await store.purgeOlderThan(
      const Duration(days: 3),
      now: now,
    );

    expect(removedCount, 1);
    expect(store.recordings.map((r) => r.id).toList(), ['recent']);
  });

  test('purgeOlderThan keeps an entry exactly at the boundary', () async {
    final store = HistoryStore(tempDir);
    final now = DateTime(2026, 1, 10);
    // Exactly 3 days old: isBefore(cutoff) is false, so it must survive.
    await store.addRecording(_recording('boundary', now.subtract(const Duration(days: 3))));

    final removedCount = await store.purgeOlderThan(
      const Duration(days: 3),
      now: now,
    );

    expect(removedCount, 0);
    expect(store.recordings, hasLength(1));
  });

  test('purge also deletes old WAVs no recording references', () async {
    final store = HistoryStore(tempDir);
    final now = DateTime.now();
    await store.addRecording(_recording('kept', now, wavFileName: 'kept.wav'));

    final keptWav = File(store.wavPathFor('kept.wav'))..createSync();
    final oldOrphan = File(store.wavPathFor('orphan-old.wav'))..createSync();
    oldOrphan.setLastModifiedSync(now.subtract(const Duration(days: 5)));
    // e.g. a recording that's in progress right now: fresh, unreferenced.
    final freshOrphan = File(store.wavPathFor('orphan-fresh.wav'))
      ..createSync();

    await store.purgeOlderThan(const Duration(days: 3), now: now);

    expect(keptWav.existsSync(), isTrue);
    expect(oldOrphan.existsSync(), isFalse);
    expect(freshOrphan.existsSync(), isTrue);
  });

  test('newWavFileName produces distinct names', () {
    final store = HistoryStore(tempDir);
    final a = store.newWavFileName();
    final b = store.newWavFileName();
    expect(a, isNot(equals(b)));
    expect(a, endsWith('.wav'));
  });
}
