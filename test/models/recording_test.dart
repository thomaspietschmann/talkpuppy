import 'package:flutter_test/flutter_test.dart';
import 'package:talkpuppy/models/recording.dart';

void main() {
  group('Clip', () {
    test('round-trips through JSON', () {
      final clip = Clip(
        id: 'c1',
        wavFileName: '123.wav',
        text: 'Hallo Welt',
        language: 'de',
        modelId: 'whisper-small-int8',
        durationMs: 4200,
        createdAt: DateTime.utc(2026, 1, 2, 3, 4, 5),
        status: ClipStatus.done,
      );

      final restored = Clip.fromJson(clip.toJson());

      expect(restored.id, clip.id);
      expect(restored.wavFileName, clip.wavFileName);
      expect(restored.text, clip.text);
      expect(restored.language, clip.language);
      expect(restored.modelId, clip.modelId);
      expect(restored.durationMs, clip.durationMs);
      expect(restored.createdAt, clip.createdAt);
      expect(restored.status, clip.status);
    });

    test('rejects file names that leave the history directory', () {
      Map<String, dynamic> json(String name) => {
        'id': 'c1',
        'wavFileName': name,
        'createdAt': DateTime.utc(2026).toIso8601String(),
      };
      for (final bad in [
        '../secret.wav',
        '/etc/passwd.wav',
        r'..\\x.wav',
        '.wav',
        'notes.txt',
        '',
      ]) {
        expect(() => Clip.fromJson(json(bad)), throwsFormatException,
            reason: bad);
      }
      expect(Clip.fromJson(json('1790-1.wav')).wavFileName, '1790-1.wav');
    });

    test('copyWith only overrides given fields', () {
      final clip = Clip(
        id: 'c1',
        wavFileName: '123.wav',
        text: 'foo',
        language: 'en',
        modelId: 'm1',
        durationMs: 100,
        createdAt: DateTime.utc(2026),
      );

      final updated = clip.copyWith(text: 'bar', language: 'de');

      expect(updated.text, 'bar');
      expect(updated.language, 'de');
      expect(updated.wavFileName, clip.wavFileName);
      expect(updated.modelId, clip.modelId);
    });
  });

  group('Recording', () {
    Clip clip(String text) => Clip(
      id: text,
      wavFileName: '$text.wav',
      text: text,
      language: 'de',
      modelId: 'm1',
      durationMs: 1000,
      createdAt: DateTime.utc(2026),
    );

    test('text joins non-empty clip texts with a blank line', () {
      final recording = Recording(
        id: 'r1',
        createdAt: DateTime.utc(2026),
        updatedAt: DateTime.utc(2026),
        clips: [clip('Erster Satz'), clip('Zweiter Satz')],
      );

      expect(recording.text, 'Erster Satz\n\nZweiter Satz');
    });

    test('text skips clips with empty/whitespace-only text', () {
      final recording = Recording(
        id: 'r1',
        createdAt: DateTime.utc(2026),
        updatedAt: DateTime.utc(2026),
        clips: [clip('Erster Satz'), clip('   '), clip('Dritter Satz')],
      );

      expect(recording.text, 'Erster Satz\n\nDritter Satz');
    });

    test('round-trips through JSON including its clips', () {
      final recording = Recording(
        id: 'r1',
        createdAt: DateTime.utc(2026, 1, 1),
        updatedAt: DateTime.utc(2026, 1, 2),
        clips: [clip('a'), clip('b')],
      );

      final restored = Recording.fromJson(recording.toJson());

      expect(restored.id, recording.id);
      expect(restored.createdAt, recording.createdAt);
      expect(restored.updatedAt, recording.updatedAt);
      expect(restored.clips.map((c) => c.text), ['a', 'b']);
    });

    test('latestLanguage reflects the last clip', () {
      final recording = Recording(
        id: 'r1',
        createdAt: DateTime.utc(2026),
        updatedAt: DateTime.utc(2026),
        clips: [
          clip('a').copyWith(language: 'en'),
          clip('b').copyWith(language: 'fr'),
        ],
      );

      expect(recording.latestLanguage, 'fr');
    });
  });
}
