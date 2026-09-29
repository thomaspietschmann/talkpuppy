import 'package:flutter/material.dart';

import '../l10n/l10n_text.dart';

/// Short overview of what Talkpuppy is built on. The full license texts
/// (which the licenses require the app to ship) are one tap further, on
/// Flutter's standard license page.
class LicensesScreen extends StatelessWidget {
  const LicensesScreen({super.key});

  static const _models = [
    ('Parakeet TDT 0.6B v3', 'NVIDIA · CC BY 4.0'),
    ('Nemotron 3.5 ASR Streaming', 'NVIDIA · OpenMDW 1.1'),
    ('Whisper', 'OpenAI · MIT'),
  ];

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final theme = Theme.of(context);
    final software = [
      ('sherpa-onnx', 'Apache 2.0'),
      ('ONNX Runtime', 'MIT'),
      ('Silero VAD', 'MIT'),
      (l10n.licensesPackages, 'BSD · MIT · Apache 2.0'),
    ];

    Widget section(String title, List<(String, String)> rows) => Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(0, 16, 0, 4),
          child: Text(title, style: theme.textTheme.labelLarge),
        ),
        for (final (name, license) in rows)
          ListTile(
            contentPadding: EdgeInsets.zero,
            dense: true,
            title: Text(name),
            subtitle: Text(license),
          ),
      ],
    );

    return Scaffold(
      appBar: AppBar(title: Text(l10n.licensesTitle)),
      body: ListView(
        padding: const EdgeInsets.fromLTRB(20, 8, 20, 24),
        children: [
          Text(l10n.licensesIntro, style: theme.textTheme.bodyLarge),
          section(l10n.licensesSpeechModels, _models),
          section(l10n.licensesSoftware, software),
          const SizedBox(height: 16),
          OutlinedButton(
            onPressed: () => showLicensePage(
              context: context,
              applicationName: 'Talkpuppy',
              applicationLegalese: l10n.licensesLegalese,
            ),
            child: Text(l10n.licensesShowAll),
          ),
        ],
      ),
    );
  }
}
