import 'dart:async';

import 'package:flutter/material.dart';

import '../models/catalog.dart';
import '../models/recording.dart';
import '../state/app_controller.dart';
import '../state/controller_scope.dart';
import 'models_screen.dart';
import 'onboarding_screen.dart';
import 'retranscribe_sheet.dart';
import 'settings_sheet.dart';
import 'widgets/history_list.dart';
import 'widgets/brand_mark.dart';
import 'widgets/record_button.dart';
import 'widgets/transcript_card.dart';

/// Shows onboarding on first launch, then the home screen from then on —
/// reactive on [SettingsService.onboardingComplete] so finishing onboarding
/// switches over automatically.
class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final scope = ControllerScope.of(context);
    return ListenableBuilder(
      listenable: scope.settings,
      builder: (context, _) {
        return AnimatedSwitcher(
          duration: const Duration(milliseconds: 300),
          child: scope.settings.onboardingComplete
              ? const _HomeContent(key: ValueKey('home'))
              : const OnboardingScreen(key: ValueKey('onboarding')),
        );
      },
    );
  }
}

class _HomeContent extends StatefulWidget {
  const _HomeContent({super.key});

  @override
  State<_HomeContent> createState() => _HomeContentState();
}

class _HomeContentState extends State<_HomeContent> {
  Timer? _tickTimer;

  @override
  void dispose() {
    _tickTimer?.cancel();
    super.dispose();
  }

  void _ensureTicking(AppController controller) {
    final shouldTick = controller.phase == RecordingPhase.recording;
    if (shouldTick && _tickTimer == null) {
      _tickTimer = Timer.periodic(const Duration(milliseconds: 300), (_) {
        if (mounted) setState(() {});
      });
    } else if (!shouldTick && _tickTimer != null) {
      _tickTimer?.cancel();
      _tickTimer = null;
    }
  }

  @override
  Widget build(BuildContext context) {
    final scope = ControllerScope.of(context);
    return ListenableBuilder(
      listenable: Listenable.merge([
        scope.controller,
        scope.historyStore,
        scope.settings,
        scope.modelManager,
      ]),
      builder: (context, _) {
        final controller = scope.controller;
        _ensureTicking(controller);

        return Scaffold(
          appBar: AppBar(
            toolbarHeight: 72,
            title: const Row(
              children: [
                BrandMark(size: 48),
                SizedBox(width: 10),
                Flexible(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Talkpuppy'),
                      Text(
                        'Offline Transkription',
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            actions: [
              _ModelChip(),
              Semantics(
                identifier: 'settings_button',
                child: IconButton(
                  icon: const Icon(Icons.settings_outlined),
                  tooltip: 'Einstellungen',
                  onPressed: () => showModalBottomSheet<void>(
                    context: context,
                    isScrollControlled: true,
                    showDragHandle: true,
                    builder: (_) => const SettingsSheet(),
                  ),
                ),
              ),
              const SizedBox(width: 4),
            ],
          ),
          body: SafeArea(
            child: Column(
              children: [
                Expanded(
                  child: ListView(
                    padding: const EdgeInsets.fromLTRB(16, 12, 16, 8),
                    children: [
                      if (controller.errorMessage != null)
                        _ErrorBanner(
                          message: controller.errorMessage!,
                          onDismiss: controller.dismissError,
                        ),
                      TranscriptCard(
                        recording: controller.activeRecording,
                        onCopy: controller.activeRecording == null
                            ? () {}
                            : () => controller.copyToClipboard(
                                controller.activeRecording!,
                              ),
                        onRetranscribe:
                            controller.activeRecording == null ||
                                controller.isBusy
                            ? null
                            : () => _openRetranscribe(
                                context,
                                controller.activeRecording!,
                              ),
                      ),
                      const SizedBox(height: 16),
                      HistoryList(
                        recordings: scope.historyStore.recordings,
                        editable: !controller.isBusy,
                        onTapCopy: controller.copyToClipboard,
                        onDelete: (r) => controller.deleteRecording(r.id),
                        onRetranscribe: (r) => _openRetranscribe(context, r),
                      ),
                    ],
                  ),
                ),
                _BottomControls(controller: controller),
              ],
            ),
          ),
        );
      },
    );
  }

  void _openRetranscribe(BuildContext context, Recording recording) {
    showModalBottomSheet<void>(
      context: context,
      isScrollControlled: true,
      showDragHandle: true,
      builder: (_) => RetranscribeSheet(recording: recording),
    );
  }
}

class _ModelChip extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final scope = ControllerScope.of(context);
    final settings = scope.settings;
    final installed = kModelCatalog
        .where((m) => scope.modelManager.downloadedIds.contains(m.id))
        .toList();
    final current = settings.selectedModelId != null
        ? modelById(settings.selectedModelId!)
        : null;

    return PopupMenuButton<String>(
      tooltip: 'Modell wechseln',
      initialValue: settings.selectedModelId,
      onSelected: (value) {
        if (value == '__manage__') {
          Navigator.of(context)
              .push(MaterialPageRoute(builder: (_) => const ModelsScreen()));
        } else {
          settings.selectedModelId = value;
          scope.controller.ensureCurrentModelLoaded();
        }
      },
      itemBuilder: (context) => [
        for (final m in installed)
          PopupMenuItem(value: m.id, child: Text(m.displayName)),
        const PopupMenuDivider(),
        const PopupMenuItem(
          value: '__manage__',
          child: Text('Modelle verwalten…'),
        ),
      ],
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8),
        child: Chip(
          label: Text(
            current?.displayName ?? 'Kein Modell',
            overflow: TextOverflow.ellipsis,
          ),
          avatar: const Icon(Icons.model_training, size: 18),
        ),
      ),
    );
  }
}

class _ErrorBanner extends StatelessWidget {
  const _ErrorBanner({required this.message, required this.onDismiss});

  final String message;
  final VoidCallback onDismiss;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    return Card(
      color: scheme.errorContainer,
      margin: const EdgeInsets.only(bottom: 12),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Row(
          children: [
            Icon(Icons.error_outline, color: scheme.onErrorContainer),
            const SizedBox(width: 12),
            Expanded(
              child: Text(
                message,
                style: TextStyle(color: scheme.onErrorContainer),
              ),
            ),
            TextButton(onPressed: onDismiss, child: const Text('OK')),
          ],
        ),
      ),
    );
  }
}

class _BottomControls extends StatelessWidget {
  const _BottomControls({required this.controller});

  final AppController controller;

  String _elapsedLabel() {
    final started = controller.recordingStartedAt;
    if (started == null) return '';
    final d = DateTime.now().difference(started);
    final m = d.inMinutes.toString().padLeft(2, '0');
    final s = (d.inSeconds % 60).toString().padLeft(2, '0');
    return '$m:$s';
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 8, 16, 20),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (!controller.modelReady) ...[
            if (controller.modelError != null) ...[
              Text(
                controller.modelError!,
                textAlign: TextAlign.center,
                style: TextStyle(color: Theme.of(context).colorScheme.error),
              ),
              const SizedBox(height: 12),
            ],
            FilledButton.tonalIcon(
              onPressed: () => Navigator.of(
                context,
              ).push(MaterialPageRoute(builder: (_) => const ModelsScreen())),
              icon: const Icon(Icons.download_outlined),
              label: Text(
                controller.modelError != null
                    ? 'Modelle verwalten'
                    : 'Modell installieren',
              ),
            ),
          ] else ...[
            switch (controller.phase) {
              RecordingPhase.recording => Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    _elapsedLabel(),
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                  const SizedBox(height: 8),
                  Semantics(
                    identifier: 'record_button',
                    child: RecordButton(
                      isActive: true,
                      enabled: true,
                      amplitude: controller.amplitude,
                      onStart: () {},
                      onStop: controller.stopAndTranscribe,
                      icon: Icons.stop_rounded,
                      label: 'Beenden',
                    ),
                  ),
                ],
              ),
              RecordingPhase.transcribing => const Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  SizedBox(
                    width: 56,
                    height: 56,
                    child: CircularProgressIndicator(),
                  ),
                  SizedBox(height: 8),
                  Text('Transkribiere…'),
                ],
              ),
              RecordingPhase.done => Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Semantics(
                    identifier: 'new_recording_button',
                    child: RecordButton(
                      isActive: false,
                      enabled: true,
                      onStart: controller.startNewRecording,
                      onStop: controller.stopAndTranscribe,
                      icon: Icons.mic_rounded,
                      label: 'Neue Aufnahme',
                    ),
                  ),
                  Semantics(
                    identifier: 'continue_recording_button',
                    child: RecordButton(
                      isActive: false,
                      enabled: true,
                      onStart: controller.startContinueRecording,
                      onStop: controller.stopAndTranscribe,
                      icon: Icons.add_circle_outline,
                      label: 'Weiter aufnehmen',
                    ),
                  ),
                ],
              ),
              RecordingPhase.idle || RecordingPhase.error => Semantics(
                identifier: 'record_button',
                child: RecordButton(
                  isActive: false,
                  enabled: controller.canRecord,
                  onStart: controller.startNewRecording,
                  onStop: controller.stopAndTranscribe,
                  icon: Icons.mic_rounded,
                  label: 'Aufnehmen',
                ),
              ),
            },
          ],
        ],
      ),
    );
  }
}
