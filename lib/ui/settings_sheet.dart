import 'package:flutter/material.dart';

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
        title: const Text('Alle Aufnahmen löschen?'),
        content: const Text(
          'Alle Transkripte und Aufnahmen werden unwiderruflich gelöscht.',
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
    if (confirmed == true) {
      await scope.controller.deleteAllRecordings();
    }
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
                'Einstellungen',
                style: Theme.of(context).textTheme.titleLarge,
              ),
              const SizedBox(height: 8),
              Semantics(
                identifier: 'autocopy_switch',
                child: SwitchListTile(
                  contentPadding: EdgeInsets.zero,
                  title: const Text('Automatisch kopieren'),
                  subtitle: const Text(
                    'Text nach der Transkription direkt in die '
                    'Zwischenablage legen',
                  ),
                  value: settings.autoCopy,
                  onChanged: (v) => settings.autoCopy = v,
                ),
              ),
              SwitchListTile(
                contentPadding: EdgeInsets.zero,
                title: const Text('Haptisches Feedback'),
                value: settings.haptics,
                onChanged: (v) => settings.haptics = v,
              ),
              const SizedBox(height: 12),
              Text(
                'Standardsprache für neue Aufnahmen',
                style: Theme.of(context).textTheme.labelLarge,
              ),
              const SizedBox(height: 4),
              Text(
                'Wird nur von Whisper-Modellen berücksichtigt; Parakeet '
                'erkennt die Sprache immer automatisch.',
                style: Theme.of(context).textTheme.bodySmall,
              ),
              const SizedBox(height: 8),
              Wrap(
                spacing: 8,
                runSpacing: 8,
                children: [
                  ChoiceChip(
                    label: const Text('Auto'),
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
                title: const Text('Modelle verwalten'),
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
                enabled: !scope.controller.isBusy,
                leading: Icon(
                  Icons.delete_forever_outlined,
                  color: Theme.of(context).colorScheme.error,
                ),
                title: Text(
                  'Alle Aufnahmen löschen',
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
