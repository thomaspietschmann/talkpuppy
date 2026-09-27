import 'package:flutter/material.dart';

import '../../l10n/l10n_text.dart';
import '../../models/recording.dart';

class HistoryList extends StatelessWidget {
  const HistoryList({
    super.key,
    required this.recordings,
    required this.onTapCopy,
    required this.onDelete,
    required this.onRetranscribe,
    this.editable = true,
  });

  final List<Recording> recordings;

  /// When false (recording/transcribing in progress), swipe-to-delete and
  /// the long-press actions are disabled; copying still works.
  final bool editable;
  final void Function(Recording) onTapCopy;
  final void Function(Recording) onDelete;
  final void Function(Recording) onRetranscribe;

  String _dayLabel(BuildContext context, DateTime date) {
    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);
    final that = DateTime(date.year, date.month, date.day);
    final diff = today.difference(that).inDays;
    if (diff == 0) return context.l10n.today;
    if (diff == 1) return context.l10n.yesterday;
    return MaterialLocalizations.of(context).formatShortDate(date);
  }

  String _timeLabel(BuildContext context, DateTime date) {
    return MaterialLocalizations.of(context).formatTimeOfDay(
      TimeOfDay.fromDateTime(date),
      alwaysUse24HourFormat: MediaQuery.alwaysUse24HourFormatOf(context),
    );
  }

  @override
  Widget build(BuildContext context) {
    if (recordings.isEmpty) {
      return const SizedBox.shrink();
    }

    final theme = Theme.of(context);
    final children = <Widget>[];
    String? lastGroup;

    for (final recording in recordings) {
      final group = _dayLabel(context, recording.updatedAt);
      if (group != lastGroup) {
        if (lastGroup != null) children.add(const SizedBox(height: 8));
        children.add(
          Padding(
            padding: const EdgeInsets.fromLTRB(4, 8, 4, 4),
            child: Text(
              group,
              style: theme.textTheme.labelLarge?.copyWith(
                color: theme.colorScheme.onSurfaceVariant,
              ),
            ),
          ),
        );
        lastGroup = group;
      }

      final preview = recording.text.replaceAll('\n', ' ').trim();

      children.add(
        Semantics(
          identifier: 'history_item_${recording.id}',
          child: Dismissible(
            key: ValueKey(recording.id),
            direction: editable
                ? DismissDirection.endToStart
                : DismissDirection.none,
            background: Container(
              alignment: Alignment.centerRight,
              padding: const EdgeInsets.symmetric(horizontal: 20),
              decoration: BoxDecoration(
                color: theme.colorScheme.errorContainer,
                borderRadius: BorderRadius.circular(16),
              ),
              child: Icon(
                Icons.delete_outline,
                color: theme.colorScheme.onErrorContainer,
              ),
            ),
            onDismissed: (_) => onDelete(recording),
            child: Card(
              margin: const EdgeInsets.symmetric(vertical: 4),
              child: ListTile(
                onTap: () => onTapCopy(recording),
                onLongPress: editable
                    ? () => _showActions(context, recording)
                    : null,
                title: Text(
                  preview.isEmpty ? context.l10n.noTextRecognized : preview,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                subtitle: Text(_timeLabel(context, recording.updatedAt)),
                trailing: IconButton(
                  icon: const Icon(Icons.copy_rounded),
                  tooltip: context.l10n.copy,
                  onPressed: () => onTapCopy(recording),
                ),
              ),
            ),
          ),
        ),
      );
    }

    return Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: children);
  }

  void _showActions(BuildContext context, Recording recording) {
    showModalBottomSheet<void>(
      context: context,
      showDragHandle: true,
      builder: (sheetContext) => SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ListTile(
              leading: const Icon(Icons.translate_rounded),
              title: Text(context.l10n.retranscribe),
              onTap: () {
                Navigator.pop(sheetContext);
                onRetranscribe(recording);
              },
            ),
            ListTile(
              leading: const Icon(Icons.delete_outline),
              title: Text(context.l10n.delete),
              onTap: () {
                Navigator.pop(sheetContext);
                onDelete(recording);
              },
            ),
          ],
        ),
      ),
    );
  }
}
