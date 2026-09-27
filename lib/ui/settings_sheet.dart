import 'package:flutter/material.dart';

import '../l10n/l10n_text.dart';
import '../l10n/locales.dart';
import '../models/catalog.dart';
import '../state/controller_scope.dart';
import 'models_screen.dart';

class SettingsSheet extends StatelessWidget {
  const SettingsSheet({super.key});

  Future<void> _confirmDeleteAll(BuildContext context) async {
    final scope = ControllerScope.of(context);
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(context.l10n.deleteAllConfirmTitle),
        content: Text(context.l10n.deleteAllConfirmBody),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: Text(context.l10n.cancel),
          ),
          FilledButton(
            onPressed: () => Navigator.pop(context, true),
            child: Text(context.l10n.delete),
          ),
        ],
      ),
    );
    if (confirmed == true) {
      await scope.controller.deleteAllRecordings();
    }
  }

  Future<void> _pickAppLanguage(BuildContext context) async {
    final settings = ControllerScope.of(context).settings;
    // '' stands for "follow the system" inside the radio group.
    final picked = await showModalBottomSheet<String>(
      context: context,
      isScrollControlled: true,
      showDragHandle: true,
      builder: (sheetContext) => DraggableScrollableSheet(
        expand: false,
        initialChildSize: 0.7,
        maxChildSize: 0.95,
        builder: (_, scrollController) => RadioGroup<String>(
          groupValue: settings.appLanguage ?? '',
          onChanged: (code) => Navigator.pop(sheetContext, code),
          child: ListView(
            controller: scrollController,
            children: [
              RadioListTile<String>(
                value: '',
                title: Text(context.l10n.appLanguageSystem),
              ),
              const Divider(),
              for (final entry in kAppLanguages.entries)
                RadioListTile<String>(
                  value: entry.key,
                  title: Text(entry.value),
                ),
            ],
          ),
        ),
      ),
    );
    if (picked == null) return;
    settings.appLanguage = picked.isEmpty ? null : picked;
  }

  @override
  Widget build(BuildContext context) {
    final scope = ControllerScope.of(context);
    final settings = scope.settings;

    return Padding(
      padding: EdgeInsets.only(
        left: 20,
        right: 20,
        top: 8,
        bottom: MediaQuery.of(context).viewInsets.bottom + 24,
      ),
      child: ListenableBuilder(
        listenable: settings,
        builder: (context, _) {
          return Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                context.l10n.settingsTitle,
                style: Theme.of(context).textTheme.titleLarge,
              ),
              const SizedBox(height: 8),
              ListTile(
                contentPadding: EdgeInsets.zero,
                leading: const Icon(Icons.language),
                title: Text(context.l10n.appLanguageTitle),
                subtitle: Text(
                  settings.appLanguage == null
                      ? context.l10n.appLanguageSystem
                      : kAppLanguages[settings.appLanguage] ?? '',
                ),
                trailing: const Icon(Icons.chevron_right),
                onTap: () => _pickAppLanguage(context),
              ),
              Semantics(
                identifier: 'autocopy_switch',
                child: SwitchListTile(
                  contentPadding: EdgeInsets.zero,
                  title: Text(context.l10n.autoCopyTitle),
                  subtitle: Text(context.l10n.autoCopySubtitle),
                  value: settings.autoCopy,
                  onChanged: (v) => settings.autoCopy = v,
                ),
              ),
              SwitchListTile(
                contentPadding: EdgeInsets.zero,
                title: Text(context.l10n.hapticsTitle),
                value: settings.haptics,
                onChanged: (v) => settings.haptics = v,
              ),
              const SizedBox(height: 12),
              Text(
                context.l10n.defaultLanguageTitle,
                style: Theme.of(context).textTheme.labelLarge,
              ),
              const SizedBox(height: 4),
              Text(
                context.l10n.defaultLanguageHint,
                style: Theme.of(context).textTheme.bodySmall,
              ),
              const SizedBox(height: 8),
              Wrap(
                spacing: 8,
                runSpacing: 8,
                children: [
                  ChoiceChip(
                    label: Text(context.l10n.auto),
                    selected: settings.defaultLanguage == 'auto',
                    onSelected: (_) {
                      settings.defaultLanguage = 'auto';
                      scope.controller.ensureCurrentModelLoaded();
                    },
                  ),
                  for (final code in kCommonLanguages)
                    ChoiceChip(
                      label: Text(code.toUpperCase()),
                      selected: settings.defaultLanguage == code,
                      onSelected: (_) {
                        settings.defaultLanguage = code;
                        scope.controller.ensureCurrentModelLoaded();
                      },
                    ),
                ],
              ),
              const SizedBox(height: 20),
              ListTile(
                contentPadding: EdgeInsets.zero,
                leading: const Icon(Icons.model_training),
                title: Text(context.l10n.manageModels),
                trailing: const Icon(Icons.chevron_right),
                onTap: () {
                  final navigator = Navigator.of(context);
                  navigator.pop();
                  navigator.push(
                    MaterialPageRoute(builder: (_) => const ModelsScreen()),
                  );
                },
              ),
              ListTile(
                contentPadding: EdgeInsets.zero,
                leading: const Icon(Icons.gavel_outlined),
                title: Text(context.l10n.licensesTitle),
                subtitle: Text(context.l10n.licensesSubtitle),
                trailing: const Icon(Icons.chevron_right),
                onTap: () => showLicensePage(
                  context: context,
                  applicationName: 'Talkpuppy',
                  applicationLegalese: context.l10n.licensesLegalese,
                ),
              ),
              ListTile(
                contentPadding: EdgeInsets.zero,
                enabled: !scope.controller.isBusy,
                leading: Icon(
                  Icons.delete_forever_outlined,
                  color: Theme.of(context).colorScheme.error,
                ),
                title: Text(
                  context.l10n.deleteAllTitle,
                  style: TextStyle(color: Theme.of(context).colorScheme.error),
                ),
                onTap: () => _confirmDeleteAll(context),
              ),
            ],
          );
        },
      ),
    );
  }
}
