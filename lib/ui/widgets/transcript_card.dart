import 'package:flutter/material.dart';

import '../../models/recording.dart';

class TranscriptCard extends StatelessWidget {
  const TranscriptCard({
    super.key,
    required this.recording,
    required this.onCopy,
    required this.onRetranscribe,
  });

  final Recording? recording;
  final VoidCallback onCopy;

  /// Null disables the button (e.g. while a recording is running).
  final VoidCallback? onRetranscribe;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final recording = this.recording;

    if (recording == null) {
      return Card(
        child: Padding(
          padding: const EdgeInsets.all(28),
          child: Text(
            'Noch keine Aufnahme.\nTippe unten auf das Mikrofon.',
            textAlign: TextAlign.center,
            style: theme.textTheme.bodyLarge?.copyWith(
              color: theme.colorScheme.onSurfaceVariant,
            ),
          ),
        ),
      );
    }

    final lang = recording.latestLanguage;

    return Card(
      child: Padding(
        padding: const EdgeInsets.fromLTRB(20, 20, 20, 12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Row(
              children: [
                Expanded(
                  child: Text(
                    'Transkript',
                    style: theme.textTheme.labelLarge?.copyWith(
                      color: theme.colorScheme.onSurfaceVariant,
                    ),
                  ),
                ),
                if (lang.isNotEmpty)
                  Chip(
                    label: Text(lang.toUpperCase()),
                    visualDensity: VisualDensity.compact,
                    padding: EdgeInsets.zero,
                  ),
              ],
            ),
            const SizedBox(height: 8),
            ConstrainedBox(
              constraints: const BoxConstraints(maxHeight: 260),
              child: SingleChildScrollView(
                child: Semantics(
                  identifier: 'transcript_text',
                  child: SelectableText(
                    recording.text.isEmpty
                        ? '(kein Text erkannt)'
                        : recording.text,
                    style: theme.textTheme.headlineSmall,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 12),
            Row(
              children: [
                Expanded(
                  child: Semantics(
                    identifier: 'copy_button',
                    child: FilledButton.icon(
                      onPressed: onCopy,
                      icon: const Icon(Icons.copy_rounded),
                      label: const Text('Kopieren'),
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                Semantics(
                  identifier: 'retranscribe_button',
                  child: IconButton.filledTonal(
                    onPressed: onRetranscribe,
                    icon: const Icon(Icons.translate_rounded),
                    tooltip: 'Neu transkribieren',
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
