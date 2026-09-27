import 'package:flutter/widgets.dart';

import '../services/history_store.dart';
import '../services/model_manager.dart';
import '../services/settings_service.dart';
import 'app_controller.dart';

/// Makes the app's long-lived services available anywhere below it in the
/// widget tree. The services themselves are singletons for the app's
/// lifetime (this widget never rebuilds them), so widgets that need to
/// react to changes listen to the individual [ChangeNotifier]s directly
/// (e.g. via `ListenableBuilder`) rather than through this widget.
class ControllerScope extends InheritedWidget {
  const ControllerScope({
    super.key,
    required this.controller,
    required this.settings,
    required this.historyStore,
    required this.modelManager,
    required super.child,
  });

  final AppController controller;
  final SettingsService settings;
  final HistoryStore historyStore;
  final ModelManager modelManager;

  static ControllerScope of(BuildContext context) {
    final scope = context
        .dependOnInheritedWidgetOfExactType<ControllerScope>();
    assert(scope != null, 'No ControllerScope found in context');
    return scope!;
  }

  @override
  bool updateShouldNotify(ControllerScope oldWidget) => false;
}
