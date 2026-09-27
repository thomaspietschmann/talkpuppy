import 'package:flutter/material.dart';

import '../l10n/l10n_text.dart';
import '../models/catalog.dart';
import '../models/model_spec.dart';
import '../services/device_ram_service.dart';
import '../services/model_manager.dart';
import '../state/controller_scope.dart';
import 'widgets/brand_mark.dart';

/// First-launch screen: pick and download a model, grant the microphone
/// permission, done. No further setup is ever required after this.
class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  String? _recommendedId;
  String? _downloadingId;
  DownloadProgress? _progress;
  String? _error;

  @override
  void initState() {
    super.initState();
    _pickRecommendation();
  }

  Future<void> _pickRecommendation() async {
    final ramGb = await DeviceRamService.totalRamGb();
    final ModelSpec recommended;
    if (ramGb >= 6) {
      recommended = kModelCatalog.first; // Parakeet
    } else if (ramGb >= 4) {
      recommended = modelById('whisper-small-int8');
    } else if (ramGb >= 3) {
      recommended = modelById('whisper-base-int8');
    } else {
      recommended = modelById('whisper-tiny-int8');
    }
    if (mounted) setState(() => _recommendedId = recommended.id);
  }

  Future<void> _select(ModelSpec model) async {
    final scope = ControllerScope.of(context);
    setState(() {
      _downloadingId = model.id;
      _progress = null;
      _error = null;
    });
    try {
      if (!await scope.modelManager.isDownloaded(model)) {
        await scope.modelManager.download(
          model,
          onProgress: (p) {
            if (mounted) setState(() => _progress = p);
          },
        );
      }
      scope.settings.selectedModelId = model.id;
      await scope.controller.ensureCurrentModelLoaded();
      // Ask for the microphone permission now, once, so the first recording
      // never hits a surprise prompt.
      await scope.controller.recorder.hasPermission();
      scope.settings.onboardingComplete = true;
    } catch (e) {
      if (mounted) {
        setState(() => _error = downloadErrorText(context.l10n, e));
      }
    } finally {
      if (mounted) setState(() => _downloadingId = null);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.fromLTRB(20, 32, 20, 20),
          children: [
            Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    Theme.of(context).colorScheme.primaryContainer,
                    Theme.of(context).colorScheme.secondaryContainer,
                  ],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.circular(28),
              ),
              child: Row(
                children: [
                  const BrandMark(size: 104, showBackdrop: true),
                  const SizedBox(width: 16),
                  Expanded(
                    child: Text(
                      context.l10n.welcomeTitle,
                      style: Theme.of(context).textTheme.headlineSmall
                          ?.copyWith(fontWeight: FontWeight.w800),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 8),
            Text(
              context.l10n.welcomeBody,
              style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                color: Theme.of(context).colorScheme.onSurfaceVariant,
              ),
            ),
            const SizedBox(height: 24),
            if (_error != null)
              Card(
                color: Theme.of(context).colorScheme.errorContainer,
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Text(_error!),
                ),
              ),
            for (final model in kModelCatalog)
              _ModelOnboardingCard(
                model: model,
                recommended: model.id == _recommendedId,
                downloading: _downloadingId == model.id,
                progress: _downloadingId == model.id ? _progress : null,
                onSelect: () => _select(model),
              ),
          ],
        ),
      ),
    );
  }
}

class _ModelOnboardingCard extends StatelessWidget {
  const _ModelOnboardingCard({
    required this.model,
    required this.recommended,
    required this.downloading,
    required this.progress,
    required this.onSelect,
  });

  final ModelSpec model;
  final bool recommended;
  final bool downloading;
  final DownloadProgress? progress;
  final VoidCallback onSelect;

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
                Expanded(
                  child: Text(
                    model.displayName,
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                ),
                if (recommended)
                  Chip(
                    label: Text(context.l10n.recommended),
                    visualDensity: VisualDensity.compact,
                  ),
              ],
            ),
            const SizedBox(height: 6),
            Text(modelDescription(context.l10n, model)),
            const SizedBox(height: 4),
            Text(
              context.l10n.sizeMb(megabytes(model.totalSizeBytes)),
              style: Theme.of(context).textTheme.bodySmall,
            ),
            const SizedBox(height: 12),
            if (downloading) ...[
              LinearProgressIndicator(value: progress?.fraction),
              const SizedBox(height: 8),
              Text(
                progress == null
                    ? context.l10n.preparing
                    : context.l10n.downloadProgress(
                        megabytes(progress!.receivedBytes),
                        megabytes(progress!.totalBytes),
                      ),
                style: Theme.of(context).textTheme.bodySmall,
              ),
            ] else
              Semantics(
                identifier: 'model_download_${model.id}',
                child: FilledButton(
                  onPressed: onSelect,
                  child: Text(context.l10n.downloadAndStart),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
