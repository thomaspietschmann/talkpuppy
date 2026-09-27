import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:talkpuppy/l10n/app_localizations.dart';
import 'package:talkpuppy/l10n/locales.dart';
import 'package:talkpuppy/models/recording.dart';
import 'package:talkpuppy/ui/widgets/history_list.dart';
import 'package:talkpuppy/ui/widgets/transcript_card.dart';

void main() {
  test('every app language has generated translations', () {
    final generated = AppLocalizations.supportedLocales
        .map((l) => l.languageCode)
        .toSet();
    expect(generated, containsAll(kAppLanguages.keys));
  });

  test('device languages resolve to a shipped language', () {
    expect(resolveAppLocale(const [Locale('de', 'AT')]), const Locale('de'));
    expect(resolveAppLocale(const [Locale('no')]), const Locale('nb'));
    expect(
      resolveAppLocale(const [Locale('ja'), Locale('fr', 'CH')]),
      const Locale('fr'),
    );
    expect(resolveAppLocale(const [Locale('ja')]), const Locale('en'));
    expect(resolveAppLocale(null), const Locale('en'));
  });

  final now = DateTime.now();
  final recording = Recording(
    id: 'r',
    createdAt: now.subtract(const Duration(days: 2)),
    updatedAt: now.subtract(const Duration(days: 2)),
    clips: [
      Clip(
        id: 'c',
        wavFileName: 'c.wav',
        text: 'Hallo',
        language: 'de',
        modelId: 'm',
        durationMs: 1000,
        createdAt: now,
      ),
    ],
  );

  for (final code in kAppLanguages.keys) {
    testWidgets('UI renders in "$code"', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          locale: Locale(code),
          supportedLocales: [for (final c in kAppLanguages.keys) Locale(c)],
          localizationsDelegates: kLocalizationsDelegates,
          home: Scaffold(
            body: ListView(
              children: [
                TranscriptCard(
                  recording: null,
                  onCopy: () {},
                  onRetranscribe: null,
                ),
                // Uses MaterialLocalizations for dates/times.
                HistoryList(
                  recordings: [recording],
                  onTapCopy: (_) {},
                  onDelete: (_) {},
                  onRetranscribe: (_) {},
                ),
              ],
            ),
          ),
        ),
      );
      await tester.pumpAndSettle();

      expect(tester.takeException(), isNull);
      final l10n = await AppLocalizations.delegate.load(Locale(code));
      expect(find.text(l10n.emptyTranscript), findsOneWidget);
    });
  }
}
