import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';

/// User-facing preferences, persisted via [SharedPreferences] and exposed as
/// a [ChangeNotifier] so widgets can rebuild when they change.
class SettingsService extends ChangeNotifier {
  SettingsService(this._prefs);

  static const _kSelectedModelId = 'selectedModelId';
  static const _kAutoCopy = 'autoCopy';
  static const _kDefaultLanguage = 'defaultLanguage';
  static const _kHaptics = 'haptics';
  static const _kOnboardingComplete = 'onboardingComplete';

  final SharedPreferences _prefs;

  static Future<SettingsService> create() async {
    final prefs = await SharedPreferences.getInstance();
    return SettingsService(prefs);
  }

  String? get selectedModelId => _prefs.getString(_kSelectedModelId);

  set selectedModelId(String? value) {
    if (value == null) {
      _prefs.remove(_kSelectedModelId);
    } else {
      _prefs.setString(_kSelectedModelId, value);
    }
    notifyListeners();
  }

  bool get autoCopy => _prefs.getBool(_kAutoCopy) ?? true;

  set autoCopy(bool value) {
    _prefs.setBool(_kAutoCopy, value);
    notifyListeners();
  }

  /// 'auto' or an ISO-639-1 code.
  String get defaultLanguage => _prefs.getString(_kDefaultLanguage) ?? 'auto';

  set defaultLanguage(String value) {
    _prefs.setString(_kDefaultLanguage, value);
    notifyListeners();
  }

  bool get haptics => _prefs.getBool(_kHaptics) ?? true;

  set haptics(bool value) {
    _prefs.setBool(_kHaptics, value);
    notifyListeners();
  }

  bool get onboardingComplete =>
      _prefs.getBool(_kOnboardingComplete) ?? false;

  set onboardingComplete(bool value) {
    _prefs.setBool(_kOnboardingComplete, value);
    notifyListeners();
  }
}
