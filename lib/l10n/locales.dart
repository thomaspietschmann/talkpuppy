import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

import 'app_localizations.dart';

/// Every UI language the app ships, with its name in that language (shown
/// as-is in the language picker, the usual convention).
const Map<String, String> kAppLanguages = {
  'en': 'English',
  'de': 'Deutsch',
  'fr': 'Français',
  'es': 'Español',
  'it': 'Italiano',
  'pt': 'Português',
  'nl': 'Nederlands',
  'ca': 'Català',
  'gl': 'Galego',
  'eu': 'Euskara',
  'mt': 'Malti',
  'pl': 'Polski',
  'cs': 'Čeština',
  'sk': 'Slovenčina',
  'sl': 'Slovenščina',
  'hr': 'Hrvatski',
  'bs': 'Bosanski',
  'sr': 'Српски',
  'mk': 'Македонски',
  'bg': 'Български',
  'sq': 'Shqip',
  'ro': 'Română',
  'hu': 'Magyar',
  'el': 'Ελληνικά',
  'tr': 'Türkçe',
  'uk': 'Українська',
  'ru': 'Русский',
  'be': 'Беларуская',
  'lt': 'Lietuvių',
  'lv': 'Latviešu',
  'et': 'Eesti',
  'sv': 'Svenska',
  'da': 'Dansk',
  'nb': 'Norsk bokmål',
  'fi': 'Suomi',
  'is': 'Íslenska',
  'ga': 'Gaeilge',
  'cy': 'Cymraeg',
  'lb': 'Lëtzebuergesch',
};

/// All localization delegates the app needs. The fallback delegates cover
/// app languages Flutter has no built-in widget strings for (Maltese,
/// Luxembourgish) by serving the English Material/Cupertino strings there.
const List<LocalizationsDelegate<dynamic>> kLocalizationsDelegates = [
  AppLocalizations.delegate,
  GlobalMaterialLocalizations.delegate,
  GlobalWidgetsLocalizations.delegate,
  GlobalCupertinoLocalizations.delegate,
  _FallbackMaterialLocalizationsDelegate(),
  _FallbackCupertinoLocalizationsDelegate(),
];

/// Picks the app language for [deviceLocales]: the first device language the
/// app supports, else English. Maps legacy Norwegian `no` to `nb`.
Locale resolveAppLocale(List<Locale>? deviceLocales) {
  for (final locale in deviceLocales ?? const <Locale>[]) {
    final code = locale.languageCode == 'no' ? 'nb' : locale.languageCode;
    if (kAppLanguages.containsKey(code)) return Locale(code);
  }
  return const Locale('en');
}

bool _needsFallback(Locale locale) =>
    kAppLanguages.containsKey(locale.languageCode) &&
    !GlobalMaterialLocalizations.delegate.isSupported(locale);

class _FallbackMaterialLocalizationsDelegate
    extends LocalizationsDelegate<MaterialLocalizations> {
  const _FallbackMaterialLocalizationsDelegate();

  @override
  bool isSupported(Locale locale) => _needsFallback(locale);

  @override
  Future<MaterialLocalizations> load(Locale locale) =>
      GlobalMaterialLocalizations.delegate.load(const Locale('en'));

  @override
  bool shouldReload(covariant LocalizationsDelegate<MaterialLocalizations> old) =>
      false;
}

class _FallbackCupertinoLocalizationsDelegate
    extends LocalizationsDelegate<CupertinoLocalizations> {
  const _FallbackCupertinoLocalizationsDelegate();

  @override
  bool isSupported(Locale locale) => _needsFallback(locale);

  @override
  Future<CupertinoLocalizations> load(Locale locale) =>
      GlobalCupertinoLocalizations.delegate.load(const Locale('en'));

  @override
  bool shouldReload(
    covariant LocalizationsDelegate<CupertinoLocalizations> old,
  ) => false;
}
