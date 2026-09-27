import 'package:flutter/material.dart';

import '../../l10n/l10n_text.dart';
import '../../models/recording.dart';

class TranscriptCard extends StatefulWidget {
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
  State<TranscriptCard> createState() => _TranscriptCardState();
}

class _TranscriptCardState extends State<TranscriptCard> {
  // Shared by the Scrollbar and the scroll view so the thumb is always
  // visible when the transcript is longer than the box.
  final _scrollController = ScrollController();

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final l10n = context.l10n;
    final recording = widget.recording;

    if (recording == null) {
      return Card(
        child: Padding(
          padding: const EdgeInsets.all(28),
          child: Text(
            l10n.emptyTranscript,
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
                    l10n.transcriptLabel,
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
              child: Scrollbar(
                controller: _scrollController,
                thumbVisibility: true,
                child: SingleChildScrollView(
                  controller: _scrollController,
                  // Keep text clear of the scrollbar thumb.
                  padding: const EdgeInsets.only(right: 12),
                  child: Semantics(
                    identifier: 'transcript_text',
                    child: SelectableText(
                      recording.text.isEmpty
                          ? l10n.noTextRecognized
                          : recording.text,
                      style: theme.textTheme.headlineSmall,
                    ),
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
                      onPressed: widget.onCopy,
                      icon: const Icon(Icons.copy_rounded),
                      label: Text(l10n.copy),
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                Semantics(
                  identifier: 'retranscribe_button',
                  child: IconButton.filledTonal(
                    onPressed: widget.onRetranscribe,
                    icon: const Icon(Icons.translate_rounded),
                    tooltip: l10n.retranscribe,
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
