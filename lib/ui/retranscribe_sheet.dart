import 'package:flutter/material.dart';

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

  List<ModelSpec> _installedWhisperModels(BuildContext context) {
    final ids = ControllerScope.of(context).modelManager.downloadedIds;
    return kModelCatalog
        .where((m) => m.engine == ModelEngine.whisper && ids.contains(m.id))
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
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text('Download fehlgeschlagen: $e')));
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
    final whisperModels = _installedWhisperModels(context);
    final forcedLanguage = _language != 'auto';
    final resolvedModel = forcedLanguage
        ? (_selectedModel ?? (whisperModels.isEmpty ? null : whisperModels.first))
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
          Text('Neu transkribieren', style: Theme.of(context).textTheme.titleLarge),
          const SizedBox(height: 16),
          Text('Sprache', style: Theme.of(context).textTheme.labelLarge),
          const SizedBox(height: 8),
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: [
              ChoiceChip(
                label: const Text('Auto'),
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
            Text('Modell', style: Theme.of(context).textTheme.labelLarge),
            const SizedBox(height: 8),
            if (whisperModels.isEmpty) ...[
              Text(
                'Für eine feste Sprache wird ein Whisper-Modell benötigt.',
                style: Theme.of(context).textTheme.bodyMedium,
              ),
              const SizedBox(height: 8),
              if (_busy) ...[
                LinearProgressIndicator(value: _downloadProgress?.fraction),
              ] else
                OutlinedButton.icon(
                  onPressed: _downloadWhisperSmall,
                  icon: const Icon(Icons.download_outlined),
                  label: const Text('Whisper Small herunterladen'),
                ),
            ] else
              Wrap(
                spacing: 8,
                runSpacing: 8,
                children: [
                  for (final m in whisperModels)
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
            child: const Text('Neu transkribieren'),
          ),
        ],
      ),
    );
  }
}
