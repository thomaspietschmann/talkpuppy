import 'package:flutter/material.dart';

import '../l10n/l10n_text.dart';
import '../models/catalog.dart';
import '../models/model_spec.dart';
import '../models/recording.dart';
import '../services/model_manager.dart';
import '../state/controller_scope.dart';

/// Bottom sheet to re-run recognition on a recording with a forced
/// language (for when auto-detection picked the wrong one) and/or a
/// different model.
class RetranscribeSheet extends StatefulWidget {
  const RetranscribeSheet({super.key, required this.recording});

  final Recording recording;

  @override
  State<RetranscribeSheet> createState() => _RetranscribeSheetState();
}

class _RetranscribeSheetState extends State<RetranscribeSheet> {
  String _language = 'auto';
  ModelSpec? _selectedModel;
  bool _busy = false;
  DownloadProgress? _downloadProgress;

  /// Installed models that can be forced to [language].
  List<ModelSpec> _installedModelsFor(BuildContext context, String language) {
    final ids = ControllerScope.of(context).modelManager.downloadedIds;
    return kModelCatalog
        .where((m) => m.canForceLanguage(language) && ids.contains(m.id))
        .toList();
  }

  ModelSpec? _autoModel(BuildContext context) {
    final scope = ControllerScope.of(context);
    final defaultId = scope.settings.selectedModelId;
    if (defaultId != null && scope.modelManager.downloadedIds.contains(defaultId)) {
      return modelById(defaultId);
    }
    final anyInstalled = kModelCatalog
        .where((m) => scope.modelManager.downloadedIds.contains(m.id))
        .toList();
    return anyInstalled.isEmpty ? null : anyInstalled.first;
  }

  Future<void> _downloadWhisperSmall() async {
    final scope = ControllerScope.of(context);
    final model = modelById('whisper-small-int8');
    setState(() {
      _busy = true;
      _downloadProgress = null;
    });
    try {
      await scope.modelManager.download(
        model,
        onProgress: (p) {
          if (mounted) setState(() => _downloadProgress = p);
        },
      );
      if (mounted) setState(() => _selectedModel = model);
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(downloadErrorText(context.l10n, e))),
        );
      }
    } finally {
      if (mounted) setState(() => _busy = false);
    }
  }

  Future<void> _confirm(ModelSpec model) async {
    final scope = ControllerScope.of(context);
    Navigator.of(context).pop();
    await scope.controller.retranscribeRecording(
      widget.recording,
      model: model,
      language: _language,
    );
  }

  @override
  Widget build(BuildContext context) {
    final forcedLanguage = _language != 'auto';
    final forceableModels = forcedLanguage
        ? _installedModelsFor(context, _language)
        : const <ModelSpec>[];
    final selected = _selectedModel;
    final resolvedModel = forcedLanguage
        ? (selected != null && forceableModels.contains(selected)
              ? selected
              : (forceableModels.isEmpty ? null : forceableModels.first))
        : _autoModel(context);

    return Padding(
      padding: EdgeInsets.only(
        left: 20,
        right: 20,
        top: 8,
        bottom: MediaQuery.of(context).viewInsets.bottom + 24,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            context.l10n.retranscribe,
            style: Theme.of(context).textTheme.titleLarge,
          ),
          const SizedBox(height: 16),
          Text(
            context.l10n.languageLabel,
            style: Theme.of(context).textTheme.labelLarge,
          ),
          const SizedBox(height: 8),
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: [
              ChoiceChip(
                label: Text(context.l10n.auto),
                selected: _language == 'auto',
                onSelected: (_) => setState(() => _language = 'auto'),
              ),
              for (final code in kCommonLanguages)
                ChoiceChip(
                  label: Text(code.toUpperCase()),
                  selected: _language == code,
                  onSelected: (_) => setState(() => _language = code),
                ),
            ],
          ),
          if (forcedLanguage) ...[
            const SizedBox(height: 20),
            Text(
              context.l10n.modelLabel,
              style: Theme.of(context).textTheme.labelLarge,
            ),
            const SizedBox(height: 8),
            if (forceableModels.isEmpty) ...[
              Text(
                context.l10n.whisperRequired,
                style: Theme.of(context).textTheme.bodyMedium,
              ),
              const SizedBox(height: 8),
              if (_busy) ...[
                LinearProgressIndicator(value: _downloadProgress?.fraction),
              ] else
                OutlinedButton.icon(
                  onPressed: _downloadWhisperSmall,
                  icon: const Icon(Icons.download_outlined),
                  label: Text(context.l10n.downloadWhisperSmall),
                ),
            ] else
              Wrap(
                spacing: 8,
                runSpacing: 8,
                children: [
                  for (final m in forceableModels)
                    ChoiceChip(
                      label: Text(m.displayName),
                      selected: (resolvedModel?.id) == m.id,
                      onSelected: (_) => setState(() => _selectedModel = m),
                    ),
                ],
              ),
          ],
          const SizedBox(height: 24),
          FilledButton(
            onPressed: (_busy || resolvedModel == null)
                ? null
                : () => _confirm(resolvedModel),
            child: Text(context.l10n.retranscribe),
          ),
        ],
      ),
    );
  }
}
