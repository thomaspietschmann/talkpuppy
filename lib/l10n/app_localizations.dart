import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_be.dart';
import 'app_localizations_bg.dart';
import 'app_localizations_bs.dart';
import 'app_localizations_ca.dart';
import 'app_localizations_cs.dart';
import 'app_localizations_cy.dart';
import 'app_localizations_da.dart';
import 'app_localizations_de.dart';
import 'app_localizations_el.dart';
import 'app_localizations_en.dart';
import 'app_localizations_es.dart';
import 'app_localizations_et.dart';
import 'app_localizations_eu.dart';
import 'app_localizations_fi.dart';
import 'app_localizations_fr.dart';
import 'app_localizations_ga.dart';
import 'app_localizations_gl.dart';
import 'app_localizations_hr.dart';
import 'app_localizations_hu.dart';
import 'app_localizations_is.dart';
import 'app_localizations_it.dart';
import 'app_localizations_lb.dart';
import 'app_localizations_lt.dart';
import 'app_localizations_lv.dart';
import 'app_localizations_mk.dart';
import 'app_localizations_mt.dart';
import 'app_localizations_nb.dart';
import 'app_localizations_nl.dart';
import 'app_localizations_pl.dart';
import 'app_localizations_pt.dart';
import 'app_localizations_ro.dart';
import 'app_localizations_ru.dart';
import 'app_localizations_sk.dart';
import 'app_localizations_sl.dart';
import 'app_localizations_sq.dart';
import 'app_localizations_sr.dart';
import 'app_localizations_sv.dart';
import 'app_localizations_tr.dart';
import 'app_localizations_uk.dart';

// ignore_for_file: type=lint

/// Callers can lookup localized strings with an instance of AppLocalizations
/// returned by `AppLocalizations.of(context)`.
///
/// Applications need to include `AppLocalizations.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'l10n/app_localizations.dart';
///
/// return MaterialApp(
///   localizationsDelegates: AppLocalizations.localizationsDelegates,
///   supportedLocales: AppLocalizations.supportedLocales,
///   home: MyApplicationHome(),
/// );
/// ```
///
/// ## Update pubspec.yaml
///
/// Please make sure to update your pubspec.yaml to include the following
/// packages:
///
/// ```yaml
/// dependencies:
///   # Internationalization support.
///   flutter_localizations:
///     sdk: flutter
///   intl: any # Use the pinned version from flutter_localizations
///
///   # Rest of dependencies
/// ```
///
/// ## iOS Applications
///
/// iOS applications define key application metadata, including supported
/// locales, in an Info.plist file that is built into the application bundle.
/// To configure the locales supported by your app, you’ll need to edit this
/// file.
///
/// First, open your project’s ios/Runner.xcworkspace Xcode workspace file.
/// Then, in the Project Navigator, open the Info.plist file under the Runner
/// project’s Runner folder.
///
/// Next, select the Information Property List item, select Add Item from the
/// Editor menu, then select Localizations from the pop-up menu.
///
/// Select and expand the newly-created Localizations item then, for each
/// locale your application supports, add a new item and select the locale
/// you wish to add from the pop-up menu in the Value field. This list should
/// be consistent with the languages listed in the AppLocalizations.supportedLocales
/// property.
abstract class AppLocalizations {
  AppLocalizations(String locale)
    : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static AppLocalizations of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations)!;
  }

  static const LocalizationsDelegate<AppLocalizations> delegate =
      _AppLocalizationsDelegate();

  /// A list of this localizations delegate along with the default localizations
  /// delegates.
  ///
  /// Returns a list of localizations delegates containing this delegate along with
  /// GlobalMaterialLocalizations.delegate, GlobalCupertinoLocalizations.delegate,
  /// and GlobalWidgetsLocalizations.delegate.
  ///
  /// Additional delegates can be added by appending to this list in
  /// MaterialApp. This list does not have to be used at all if a custom list
  /// of delegates is preferred or required.
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates =
      <LocalizationsDelegate<dynamic>>[
        delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[
    Locale('be'),
    Locale('bg'),
    Locale('bs'),
    Locale('ca'),
    Locale('cs'),
    Locale('cy'),
    Locale('da'),
    Locale('de'),
    Locale('el'),
    Locale('en'),
    Locale('es'),
    Locale('et'),
    Locale('eu'),
    Locale('fi'),
    Locale('fr'),
    Locale('ga'),
    Locale('gl'),
    Locale('hr'),
    Locale('hu'),
    Locale('is'),
    Locale('it'),
    Locale('lb'),
    Locale('lt'),
    Locale('lv'),
    Locale('mk'),
    Locale('mt'),
    Locale('nb'),
    Locale('nl'),
    Locale('pl'),
    Locale('pt'),
    Locale('ro'),
    Locale('ru'),
    Locale('sk'),
    Locale('sl'),
    Locale('sq'),
    Locale('sr'),
    Locale('sv'),
    Locale('tr'),
    Locale('uk'),
  ];

  /// No description provided for @logoSemantics.
  ///
  /// In en, this message translates to:
  /// **'Talkpuppy logo'**
  String get logoSemantics;

  /// No description provided for @startupFailed.
  ///
  /// In en, this message translates to:
  /// **'Talkpuppy couldn\'t start:\n{error}'**
  String startupFailed(String error);

  /// No description provided for @settingsTooltip.
  ///
  /// In en, this message translates to:
  /// **'Settings'**
  String get settingsTooltip;

  /// No description provided for @switchModelTooltip.
  ///
  /// In en, this message translates to:
  /// **'Switch model'**
  String get switchModelTooltip;

  /// No description provided for @manageModelsEllipsis.
  ///
  /// In en, this message translates to:
  /// **'Manage models…'**
  String get manageModelsEllipsis;

  /// No description provided for @manageModels.
  ///
  /// In en, this message translates to:
  /// **'Manage models'**
  String get manageModels;

  /// No description provided for @installModel.
  ///
  /// In en, this message translates to:
  /// **'Install model'**
  String get installModel;

  /// No description provided for @noModel.
  ///
  /// In en, this message translates to:
  /// **'No model'**
  String get noModel;

  /// No description provided for @ok.
  ///
  /// In en, this message translates to:
  /// **'OK'**
  String get ok;

  /// No description provided for @cancel.
  ///
  /// In en, this message translates to:
  /// **'Cancel'**
  String get cancel;

  /// No description provided for @delete.
  ///
  /// In en, this message translates to:
  /// **'Delete'**
  String get delete;

  /// No description provided for @copy.
  ///
  /// In en, this message translates to:
  /// **'Copy'**
  String get copy;

  /// Label under the big microphone button when idle.
  ///
  /// In en, this message translates to:
  /// **'Record'**
  String get record;

  /// Label under the button while recording; tapping it stops the recording.
  ///
  /// In en, this message translates to:
  /// **'Stop'**
  String get stopRecording;

  /// No description provided for @transcribing.
  ///
  /// In en, this message translates to:
  /// **'Transcribing…'**
  String get transcribing;

  /// Starts a fresh recording as a new entry.
  ///
  /// In en, this message translates to:
  /// **'New recording'**
  String get newRecording;

  /// Starts another recording whose text is appended to the current transcript.
  ///
  /// In en, this message translates to:
  /// **'Keep recording'**
  String get continueRecording;

  /// No description provided for @transcriptLabel.
  ///
  /// In en, this message translates to:
  /// **'Transcript'**
  String get transcriptLabel;

  /// No description provided for @emptyTranscript.
  ///
  /// In en, this message translates to:
  /// **'No recording yet.\nTap the microphone below.'**
  String get emptyTranscript;

  /// No description provided for @noTextRecognized.
  ///
  /// In en, this message translates to:
  /// **'(no text recognized)'**
  String get noTextRecognized;

  /// Run speech recognition again on an existing recording, e.g. with another language.
  ///
  /// In en, this message translates to:
  /// **'Re-transcribe'**
  String get retranscribe;

  /// No description provided for @today.
  ///
  /// In en, this message translates to:
  /// **'Today'**
  String get today;

  /// No description provided for @yesterday.
  ///
  /// In en, this message translates to:
  /// **'Yesterday'**
  String get yesterday;

  /// No description provided for @welcomeTitle.
  ///
  /// In en, this message translates to:
  /// **'Welcome to Talkpuppy'**
  String get welcomeTitle;

  /// No description provided for @welcomeBody.
  ///
  /// In en, this message translates to:
  /// **'Choose a speech model for transcription. It runs entirely on your device, no internet needed.'**
  String get welcomeBody;

  /// No description provided for @recommended.
  ///
  /// In en, this message translates to:
  /// **'Recommended'**
  String get recommended;

  /// No description provided for @preparing.
  ///
  /// In en, this message translates to:
  /// **'Preparing…'**
  String get preparing;

  /// No description provided for @sizeMb.
  ///
  /// In en, this message translates to:
  /// **'{size} MB'**
  String sizeMb(int size);

  /// No description provided for @downloadProgress.
  ///
  /// In en, this message translates to:
  /// **'{received} MB / {total} MB'**
  String downloadProgress(int received, int total);

  /// No description provided for @downloadAndStart.
  ///
  /// In en, this message translates to:
  /// **'Download and get started'**
  String get downloadAndStart;

  /// No description provided for @download.
  ///
  /// In en, this message translates to:
  /// **'Download'**
  String get download;

  /// No description provided for @downloadFailed.
  ///
  /// In en, this message translates to:
  /// **'Download failed: {error}'**
  String downloadFailed(String error);

  /// No description provided for @modelsTitle.
  ///
  /// In en, this message translates to:
  /// **'Models'**
  String get modelsTitle;

  /// No description provided for @deleteModelTitle.
  ///
  /// In en, this message translates to:
  /// **'Delete model?'**
  String get deleteModelTitle;

  /// No description provided for @deleteModelBody.
  ///
  /// In en, this message translates to:
  /// **'{model} will be deleted from this device ({size} MB).'**
  String deleteModelBody(String model, int size);

  /// Parakeet supports bg, hr, cs, da, nl, en, et, fi, fr, de, el, hu, it, lv, lt, mt, pl, pt, ro, sk, sl, es, sv, ru, uk. Don't claim support for other languages.
  ///
  /// In en, this message translates to:
  /// **'Very accurate and fast. The text appears once you stop recording. 25 European languages, detected automatically; the language can\'t be fixed. Large download, for phones with at least 6 GB of RAM.'**
  String get modelDescParakeet;

  /// No description provided for @modelDescWhisperSmall.
  ///
  /// In en, this message translates to:
  /// **'The most languages (99), detected automatically or fixed. Good accuracy, but slower than Parakeet, and on silence or noise it can occasionally make up words. For phones with at least 4 GB of RAM.'**
  String get modelDescWhisperSmall;

  /// No description provided for @modelDescWhisperBase.
  ///
  /// In en, this message translates to:
  /// **'Small download for older phones. 99 languages, detected automatically or fixed. Noticeably less accurate than Whisper Small. For phones with at least 3 GB of RAM.'**
  String get modelDescWhisperBase;

  /// No description provided for @modelDescWhisperTiny.
  ///
  /// In en, this message translates to:
  /// **'Smallest and fastest, runs on practically any phone. 99 languages, detected automatically or fixed. Least accurate, best for short, clearly spoken notes.'**
  String get modelDescWhisperTiny;

  /// Nemotron supports ar, bg, cs, da, de, en, es, et, fi, fr, hi, hr, hu, it, ja, ko, nb, nl, pl, pt, ro, ru, sk, sv, tr, uk, vi, zh. Don't claim support for other languages.
  ///
  /// In en, this message translates to:
  /// **'Live preview: the text appears while you speak and is ready as soon as you stop. 28 languages, detected automatically or fixed. Usually a little less accurate than Parakeet. Large download, for phones with at least 6 GB of RAM.'**
  String get modelDescNemotron;

  /// Heading of the card that shows the text recognized so far while still recording.
  ///
  /// In en, this message translates to:
  /// **'Live preview'**
  String get livePreviewLabel;

  /// Placeholder in the live preview card before any words are recognized.
  ///
  /// In en, this message translates to:
  /// **'Listening…'**
  String get livePreviewListening;

  /// No description provided for @languageLabel.
  ///
  /// In en, this message translates to:
  /// **'Language'**
  String get languageLabel;

  /// Automatic language detection option.
  ///
  /// In en, this message translates to:
  /// **'Auto'**
  String get auto;

  /// No description provided for @modelLabel.
  ///
  /// In en, this message translates to:
  /// **'Model'**
  String get modelLabel;

  /// No description provided for @whisperRequired.
  ///
  /// In en, this message translates to:
  /// **'A fixed language needs a Whisper or Nemotron model.'**
  String get whisperRequired;

  /// No description provided for @downloadWhisperSmall.
  ///
  /// In en, this message translates to:
  /// **'Download Whisper Small'**
  String get downloadWhisperSmall;

  /// No description provided for @settingsTitle.
  ///
  /// In en, this message translates to:
  /// **'Settings'**
  String get settingsTitle;

  /// No description provided for @appLanguageTitle.
  ///
  /// In en, this message translates to:
  /// **'App language'**
  String get appLanguageTitle;

  /// No description provided for @appLanguageSystem.
  ///
  /// In en, this message translates to:
  /// **'System default'**
  String get appLanguageSystem;

  /// No description provided for @autoCopyTitle.
  ///
  /// In en, this message translates to:
  /// **'Copy automatically'**
  String get autoCopyTitle;

  /// No description provided for @autoCopySubtitle.
  ///
  /// In en, this message translates to:
  /// **'Put the text on the clipboard right after transcription'**
  String get autoCopySubtitle;

  /// No description provided for @hapticsTitle.
  ///
  /// In en, this message translates to:
  /// **'Haptic feedback'**
  String get hapticsTitle;

  /// No description provided for @minimizeToOverlay.
  ///
  /// In en, this message translates to:
  /// **'Minimize and show overlay'**
  String get minimizeToOverlay;

  /// No description provided for @overlaySetupTitle.
  ///
  /// In en, this message translates to:
  /// **'Turn on the accessibility service'**
  String get overlaySetupTitle;

  /// No description provided for @overlaySetupBody.
  ///
  /// In en, this message translates to:
  /// **'To show the button over other apps and insert the text at the cursor, Talkpuppy needs its accessibility service. It only reads the text field you\'re typing in, and only to insert the text. It doesn\'t read anything else on the screen, stores nothing from other apps and sends nothing anywhere.\n\nIn the next screen, open “Talkpuppy” and turn it on.'**
  String get overlaySetupBody;

  /// No description provided for @overlaySetupShortcut.
  ///
  /// In en, this message translates to:
  /// **'Turn on only the Talkpuppy switch and leave “Shortcut” off: the button appears by itself.'**
  String get overlaySetupShortcut;

  /// No description provided for @shortcutHint.
  ///
  /// In en, this message translates to:
  /// **'The Talkpuppy “Shortcut” is on, so Android pins the app icon to the edge of the screen. You don\'t need it: the floating button appears by itself. Turn off “Shortcut” in the Talkpuppy accessibility settings.'**
  String get shortcutHint;

  /// No description provided for @shortcutHintAction.
  ///
  /// In en, this message translates to:
  /// **'Open Talkpuppy settings'**
  String get shortcutHintAction;

  /// No description provided for @overlayOpenAccessibility.
  ///
  /// In en, this message translates to:
  /// **'Open accessibility settings'**
  String get overlayOpenAccessibility;

  /// No description provided for @overlayRestrictedHint.
  ///
  /// In en, this message translates to:
  /// **'Switch greyed out? Open App info → ⋮ → “Allow restricted settings”, then try again.'**
  String get overlayRestrictedHint;

  /// No description provided for @defaultLanguageTitle.
  ///
  /// In en, this message translates to:
  /// **'Default language for new recordings'**
  String get defaultLanguageTitle;

  /// No description provided for @defaultLanguageHint.
  ///
  /// In en, this message translates to:
  /// **'Used by Whisper and Nemotron; Parakeet always detects the language automatically.'**
  String get defaultLanguageHint;

  /// No description provided for @licensesTitle.
  ///
  /// In en, this message translates to:
  /// **'Licenses'**
  String get licensesTitle;

  /// No description provided for @licensesSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Software and models used'**
  String get licensesSubtitle;

  /// No description provided for @licensesLegalese.
  ///
  /// In en, this message translates to:
  /// **'Speech recognition with sherpa-onnx, Parakeet (NVIDIA, CC BY 4.0), Nemotron (NVIDIA, OpenMDW 1.1) and Whisper (OpenAI, MIT).'**
  String get licensesLegalese;

  /// No description provided for @licensesIntro.
  ///
  /// In en, this message translates to:
  /// **'Talkpuppy is built on open-source software and openly licensed speech models.'**
  String get licensesIntro;

  /// No description provided for @licensesSpeechModels.
  ///
  /// In en, this message translates to:
  /// **'Speech models'**
  String get licensesSpeechModels;

  /// No description provided for @licensesSoftware.
  ///
  /// In en, this message translates to:
  /// **'Software'**
  String get licensesSoftware;

  /// No description provided for @licensesPackages.
  ///
  /// In en, this message translates to:
  /// **'Flutter and other open-source packages'**
  String get licensesPackages;

  /// No description provided for @licensesShowAll.
  ///
  /// In en, this message translates to:
  /// **'Show all license texts'**
  String get licensesShowAll;

  /// No description provided for @deleteAllTitle.
  ///
  /// In en, this message translates to:
  /// **'Delete all recordings'**
  String get deleteAllTitle;

  /// No description provided for @deleteAllConfirmTitle.
  ///
  /// In en, this message translates to:
  /// **'Delete all recordings?'**
  String get deleteAllConfirmTitle;

  /// No description provided for @deleteAllConfirmBody.
  ///
  /// In en, this message translates to:
  /// **'All transcripts and recordings will be permanently deleted.'**
  String get deleteAllConfirmBody;

  /// No description provided for @errorMicPermission.
  ///
  /// In en, this message translates to:
  /// **'No microphone access. Please allow it in your phone\'s settings.'**
  String get errorMicPermission;

  /// No description provided for @errorMicBusy.
  ///
  /// In en, this message translates to:
  /// **'The microphone is in use right now, for example by a phone call. Please try again after the call.'**
  String get errorMicBusy;

  /// No description provided for @errorRecorderStart.
  ///
  /// In en, this message translates to:
  /// **'Couldn\'t start recording ({detail}).'**
  String errorRecorderStart(String detail);

  /// No description provided for @errorRecorderStop.
  ///
  /// In en, this message translates to:
  /// **'Couldn\'t stop recording ({detail}).'**
  String errorRecorderStop(String detail);

  /// No description provided for @errorTranscription.
  ///
  /// In en, this message translates to:
  /// **'Transcription failed ({detail}). The recording is saved and can be re-transcribed.'**
  String errorTranscription(String detail);

  /// No description provided for @errorRetranscribe.
  ///
  /// In en, this message translates to:
  /// **'Re-transcription failed ({detail}).'**
  String errorRetranscribe(String detail);

  /// No description provided for @errorModelLoad.
  ///
  /// In en, this message translates to:
  /// **'{model} couldn\'t be loaded. If this keeps happening, delete the model and download it again. ({detail})'**
  String errorModelLoad(String model, String detail);

  /// No description provided for @errorNoModel.
  ///
  /// In en, this message translates to:
  /// **'No model loaded.'**
  String get errorNoModel;

  /// No description provided for @downloadAlreadyRunning.
  ///
  /// In en, this message translates to:
  /// **'{model} is already downloading.'**
  String downloadAlreadyRunning(String model);

  /// No description provided for @downloadCancelled.
  ///
  /// In en, this message translates to:
  /// **'Download cancelled.'**
  String get downloadCancelled;

  /// No description provided for @downloadNetworkError.
  ///
  /// In en, this message translates to:
  /// **'Download failed. Please check your internet connection and try again.'**
  String get downloadNetworkError;

  /// No description provided for @downloadNotModelFile.
  ///
  /// In en, this message translates to:
  /// **'The server didn\'t return a model file (maybe a Wi-Fi login page). Please check your network and try again.'**
  String get downloadNotModelFile;

  /// No description provided for @downloadCorrupt.
  ///
  /// In en, this message translates to:
  /// **'The downloaded file {file} is corrupted. Please try again.'**
  String downloadCorrupt(String file);

  /// No description provided for @downloadNoSpace.
  ///
  /// In en, this message translates to:
  /// **'Not enough storage for {model}.'**
  String downloadNoSpace(String model);
}

class _AppLocalizationsDelegate
    extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(lookupAppLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) => <String>[
    'be',
    'bg',
    'bs',
    'ca',
    'cs',
    'cy',
    'da',
    'de',
    'el',
    'en',
    'es',
    'et',
    'eu',
    'fi',
    'fr',
    'ga',
    'gl',
    'hr',
    'hu',
    'is',
    'it',
    'lb',
    'lt',
    'lv',
    'mk',
    'mt',
    'nb',
    'nl',
    'pl',
    'pt',
    'ro',
    'ru',
    'sk',
    'sl',
    'sq',
    'sr',
    'sv',
    'tr',
    'uk',
  ].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {
  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'be':
      return AppLocalizationsBe();
    case 'bg':
      return AppLocalizationsBg();
    case 'bs':
      return AppLocalizationsBs();
    case 'ca':
      return AppLocalizationsCa();
    case 'cs':
      return AppLocalizationsCs();
    case 'cy':
      return AppLocalizationsCy();
    case 'da':
      return AppLocalizationsDa();
    case 'de':
      return AppLocalizationsDe();
    case 'el':
      return AppLocalizationsEl();
    case 'en':
      return AppLocalizationsEn();
    case 'es':
      return AppLocalizationsEs();
    case 'et':
      return AppLocalizationsEt();
    case 'eu':
      return AppLocalizationsEu();
    case 'fi':
      return AppLocalizationsFi();
    case 'fr':
      return AppLocalizationsFr();
    case 'ga':
      return AppLocalizationsGa();
    case 'gl':
      return AppLocalizationsGl();
    case 'hr':
      return AppLocalizationsHr();
    case 'hu':
      return AppLocalizationsHu();
    case 'is':
      return AppLocalizationsIs();
    case 'it':
      return AppLocalizationsIt();
    case 'lb':
      return AppLocalizationsLb();
    case 'lt':
      return AppLocalizationsLt();
    case 'lv':
      return AppLocalizationsLv();
    case 'mk':
      return AppLocalizationsMk();
    case 'mt':
      return AppLocalizationsMt();
    case 'nb':
      return AppLocalizationsNb();
    case 'nl':
      return AppLocalizationsNl();
    case 'pl':
      return AppLocalizationsPl();
    case 'pt':
      return AppLocalizationsPt();
    case 'ro':
      return AppLocalizationsRo();
    case 'ru':
      return AppLocalizationsRu();
    case 'sk':
      return AppLocalizationsSk();
    case 'sl':
      return AppLocalizationsSl();
    case 'sq':
      return AppLocalizationsSq();
    case 'sr':
      return AppLocalizationsSr();
    case 'sv':
      return AppLocalizationsSv();
    case 'tr':
      return AppLocalizationsTr();
    case 'uk':
      return AppLocalizationsUk();
  }

  throw FlutterError(
    'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
    'an issue with the localizations generation tool. Please file an issue '
    'on GitHub with a reproducible sample app and the gen-l10n configuration '
    'that was used.',
  );
}
