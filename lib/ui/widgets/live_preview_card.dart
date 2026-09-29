import 'package:flutter/material.dart';

import '../../l10n/l10n_text.dart';

/// Shows what a streaming model recognizes while the recording is still
/// running. [previousText] is the recording's existing text when continuing
/// a recording, shown muted in front of the new words (separated like
/// clips are in [Recording.text]).
class LivePreviewCard extends StatefulWidget {
  const LivePreviewCard({
    super.key,
    required this.text,
    this.previousText = '',
  });

  final String text;
  final String previousText;

  @override
  State<LivePreviewCard> createState() => _LivePreviewCardState();
}

class _LivePreviewCardState extends State<LivePreviewCard> {
  final _scrollController = ScrollController();

  @override
  void didUpdateWidget(LivePreviewCard oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.text != widget.text) {
      // Keep the newest words in view.
      WidgetsBinding.instance.addPostFrameCallback((_) {
        if (_scrollController.hasClients) {
          _scrollController.jumpTo(_scrollController.position.maxScrollExtent);
        }
      });
    }
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final l10n = context.l10n;
    final muted = theme.colorScheme.onSurfaceVariant;
    final style = theme.textTheme.headlineSmall;

    return Card(
      child: Padding(
        padding: const EdgeInsets.fromLTRB(20, 20, 20, 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Row(
              children: [
                Icon(Icons.graphic_eq_rounded, size: 18, color: muted),
                const SizedBox(width: 8),
                Expanded(
                  child: Text(
                    l10n.livePreviewLabel,
                    style: theme.textTheme.labelLarge?.copyWith(color: muted),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),
            ConstrainedBox(
              constraints: const BoxConstraints(maxHeight: 260),
              child: SingleChildScrollView(
                controller: _scrollController,
                child: Semantics(
                  identifier: 'live_preview_text',
                  liveRegion: true,
                  child: widget.text.isEmpty && widget.previousText.isEmpty
                      ? Text(
                          l10n.livePreviewListening,
                          style: style?.copyWith(color: muted),
                        )
                      : Text.rich(
                          TextSpan(
                            style: style,
                            children: [
                              if (widget.previousText.isNotEmpty)
                                TextSpan(
                                  text: widget.text.isEmpty
                                      ? widget.previousText
                                      : '${widget.previousText}\n\n',
                                  style: TextStyle(color: muted),
                                ),
                              TextSpan(text: widget.text),
                            ],
                          ),
                        ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
