import 'package:flutter/material.dart';

import '../models/catalog.dart';
import '../models/model_spec.dart';
import '../services/model_manager.dart';
import '../state/controller_scope.dart';

/// Full model management screen: download, delete, and pick the active
/// model. Reached from the home screen's model chip or the "install a
/// model" prompt when none is ready yet.
class ModelsScreen extends StatefulWidget {
  const ModelsScreen({super.key});

  @override
  State<ModelsScreen> createState() => _ModelsScreenState();
}

class _ModelsScreenState extends State<ModelsScreen> {
  String? _busyId;
  DownloadProgress? _progress;

  String _sizeLabel(int bytes) => '${(bytes / (1024 * 1024)).round()} MB';

  Future<void> _download(ModelSpec model) async {
    final scope = ControllerScope.of(context);
    setState(() {
      _busyId = model.id;
      _progress = null;
    });
    try {
      await scope.modelManager.download(
        model,
        onProgress: (p) {
          if (mounted) setState(() => _progress = p);
        },
      );
      final selected = scope.settings.selectedModelId;
      if (selected == null || selected == model.id) {
        scope.settings.selectedModelId = model.id;
        await scope.controller.ensureCurrentModelLoaded();
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              e is ModelDownloadException ? e.message : 'Download fehlgeschlagen: $e',
            ),
          ),
        );
      }
    } finally {
      if (mounted) setState(() => _busyId = null);
    }
  }

  Future<void> _select(ModelSpec model) async {
    final scope = ControllerScope.of(context);
    scope.settings.selectedModelId = model.id;
    await scope.controller.ensureCurrentModelLoaded();
  }

  Future<void> _delete(ModelSpec model) async {
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Modell löschen?'),
        content: Text(
          '${model.displayName} wird vom Gerät gelöscht '
          '(${_sizeLabel(model.totalSizeBytes)}).',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: const Text('Abbrechen'),
          ),
          FilledButton(
            onPressed: () => Navigator.pop(context, true),
            child: const Text('Löschen'),
          ),
        ],
      ),
    );
    if (confirmed != true || !mounted) return;

    final scope = ControllerScope.of(context);
    await scope.modelManager.delete(model);
    if (scope.settings.selectedModelId == model.id) {
      scope.settings.selectedModelId = null;
      await scope.controller.ensureCurrentModelLoaded();
    }
  }

  @override
  Widget build(BuildContext context) {
    final scope = ControllerScope.of(context);
    return Scaffold(
      appBar: AppBar(title: const Text('Modelle')),
      body: ListenableBuilder(
        listenable: Listenable.merge([scope.modelManager, scope.settings]),
        builder: (context, _) {
          return RadioGroup<String>(
            groupValue: scope.settings.selectedModelId,
            onChanged: (id) {
              if (id != null) _select(modelById(id));
            },
            child: ListView(
              padding: const EdgeInsets.all(16),
              children: [
                for (final model in kModelCatalog)
                  _ModelRow(
                    model: model,
                    installed: scope.modelManager.downloadedIds.contains(
                      model.id,
                    ),
                    busy: _busyId == model.id,
                    progress: _busyId == model.id ? _progress : null,
                    onDownload: () => _download(model),
                    onCancel: () => scope.modelManager.cancelDownload(model),
                    onDelete: () => _delete(model),
                  ),
              ],
            ),
          );
        },
      ),
    );
  }
}

class _ModelRow extends StatelessWidget {
  const _ModelRow({
    required this.model,
    required this.installed,
    required this.busy,
    required this.progress,
    required this.onDownload,
    required this.onCancel,
    required this.onDelete,
  });

  final ModelSpec model;
  final bool installed;
  final bool busy;
  final DownloadProgress? progress;
  final VoidCallback onDownload;
  final VoidCallback onCancel;
  final VoidCallback onDelete;

  String _sizeLabel(int bytes) => '${(bytes / (1024 * 1024)).round()} MB';

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                if (installed) Radio<String>(value: model.id),
                Expanded(
                  child: Text(
                    model.displayName,
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                ),
                if (installed && !busy)
                  IconButton(
                    icon: const Icon(Icons.delete_outline),
                    tooltip: 'Löschen',
                    onPressed: onDelete,
                  ),
              ],
            ),
            const SizedBox(height: 4),
            Text(model.description),
            const SizedBox(height: 4),
            Text(
              _sizeLabel(model.totalSizeBytes),
              style: Theme.of(context).textTheme.bodySmall,
            ),
            const SizedBox(height: 12),
            if (busy) ...[
              LinearProgressIndicator(value: progress?.fraction),
              const SizedBox(height: 8),
              Row(
                children: [
                  Expanded(
                    child: Text(
                      progress == null
                          ? 'Wird vorbereitet…'
                          : '${_sizeLabel(progress!.receivedBytes)} / '
                                '${_sizeLabel(progress!.totalBytes)}',
                      style: Theme.of(context).textTheme.bodySmall,
                    ),
                  ),
                  TextButton(onPressed: onCancel, child: const Text('Abbrechen')),
                ],
              ),
            ] else if (!installed)
              Semantics(
                identifier: 'model_download_${model.id}',
                child: FilledButton(
                  onPressed: onDownload,
                  child: const Text('Herunterladen'),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
