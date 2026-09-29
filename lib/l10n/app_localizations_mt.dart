// ignore: unused_import
import 'package:intl/intl.dart' as intl;

import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Maltese (`mt`).
class AppLocalizationsMt extends AppLocalizations {
  AppLocalizationsMt([String locale = 'mt']) : super(locale);

  @override
  String get logoSemantics => 'Logo ta\' Talkpuppy';

  @override
  String startupFailed(String error) {
    return 'Talkpuppy ma setax jibda:\n$error';
  }

  @override
  String get settingsTooltip => 'Settings';

  @override
  String get switchModelTooltip => 'Biddel il-mudell';

  @override
  String get manageModelsEllipsis => 'Immaniġġja l-mudelli…';

  @override
  String get manageModels => 'Immaniġġja l-mudelli';

  @override
  String get installModel => 'Installa mudell';

  @override
  String get noModel => 'L-ebda mudell';

  @override
  String get ok => 'OK';

  @override
  String get cancel => 'Ikkanċella';

  @override
  String get delete => 'Ħassar';

  @override
  String get copy => 'Ikkopja';

  @override
  String get record => 'Irrekordja';

  @override
  String get stopRecording => 'Waqqaf';

  @override
  String get transcribing => 'Qed jiġi traskritt…';

  @override
  String get newRecording => 'Reġistrazzjoni ġdida';

  @override
  String get continueRecording => 'Kompli rrekordja';

  @override
  String get transcriptLabel => 'Traskrizzjoni';

  @override
  String get emptyTranscript =>
      'Għad m\'hemm l-ebda reġistrazzjoni.\nMiss il-mikrofonu hawn taħt.';

  @override
  String get noTextRecognized => '(l-ebda test ma ġie rikonoxxut)';

  @override
  String get retranscribe => 'Erġa\' ittraskrivi';

  @override
  String get today => 'Illum';

  @override
  String get yesterday => 'Ilbieraħ';

  @override
  String get welcomeTitle => 'Merħba f\'Talkpuppy';

  @override
  String get welcomeBody =>
      'Agħżel mudell tad-diskors għat-traskrizzjoni. Jaħdem kompletament fuq l-apparat tiegħek, mingħajr ma teħtieġ l-internet.';

  @override
  String get recommended => 'Rakkomandat';

  @override
  String get preparing => 'Qed jitħejja…';

  @override
  String sizeMb(int size) {
    return '$size MB';
  }

  @override
  String downloadProgress(int received, int total) {
    return '$received MB / $total MB';
  }

  @override
  String get downloadAndStart => 'Niżżel u ibda';

  @override
  String get download => 'Niżżel';

  @override
  String downloadFailed(String error) {
    return 'It-tniżżil falla: $error';
  }

  @override
  String get modelsTitle => 'Mudelli';

  @override
  String get deleteModelTitle => 'Tħassar il-mudell?';

  @override
  String deleteModelBody(String model, int size) {
    return '$model se jitħassar minn dan l-apparat ($size MB).';
  }

  @override
  String get modelDescParakeet =>
      'Preċiż ħafna u mgħaġġel. It-test jidher malli twaqqaf ir-reġistrazzjoni. 25 lingwa Ewropea, magħrufa awtomatikament; il-lingwa ma tistax tiġi ffissata. Download kbir, għal telefowns b\'mill-inqas 6 GB ta\' RAM.';

  @override
  String get modelDescWhisperSmall =>
      'L-aktar lingwi (99), magħrufa awtomatikament jew iffissati. Preċiżjoni tajba, iżda aktar bil-mod minn Parakeet, u fis-skiet jew fil-ħoss xi drabi jista\' jivvinta kliem. Għal telefowns b\'mill-inqas 4 GB ta\' RAM.';

  @override
  String get modelDescWhisperBase =>
      'Download żgħir għal telefowns eqdem. 99 lingwa, magħrufa awtomatikament jew iffissati. Notevolment inqas preċiż minn Whisper Small. Għal telefowns b\'mill-inqas 3 GB ta\' RAM.';

  @override
  String get modelDescWhisperTiny =>
      'L-iżgħar u l-aktar mgħaġġel, jaħdem fuq prattikament kull telefown. 99 lingwa, magħrufa awtomatikament jew iffissati. L-inqas preċiż, l-aħjar għal noti qosra mitkellma b\'mod ċar.';

  @override
  String get modelDescNemotron =>
      'Previżjoni diretta: it-test jidher waqt li titkellem u jkun lest malli tieqaf. 28 lingwa, magħrufa awtomatikament jew iffissati. Normalment ftit inqas preċiż minn Parakeet. Download kbir, għal telefowns b\'mill-inqas 6 GB ta\' RAM.';

  @override
  String get livePreviewLabel => 'Previżjoni diretta';

  @override
  String get livePreviewListening => 'Qed jisma\'…';

  @override
  String get languageLabel => 'Lingwa';

  @override
  String get auto => 'Awto';

  @override
  String get modelLabel => 'Mudell';

  @override
  String get whisperRequired =>
      'Lingwa fissa teħtieġ mudell Whisper jew Nemotron.';

  @override
  String get downloadWhisperSmall => 'Niżżel Whisper Small';

  @override
  String get settingsTitle => 'Settings';

  @override
  String get appLanguageTitle => 'Lingwa tal-app';

  @override
  String get appLanguageSystem => 'Default tas-sistema';

  @override
  String get autoCopyTitle => 'Ikkopja awtomatikament';

  @override
  String get autoCopySubtitle =>
      'Poġġi t-test fil-clipboard eżatt wara t-traskrizzjoni';

  @override
  String get hapticsTitle => 'Feedback haptiku';

  @override
  String get minimizeToOverlay => 'Imminimizza u uri l-overlay';

  @override
  String get overlaySetupTitle => 'Ixgħel is-servizz tal-aċċessibbiltà';

  @override
  String get overlaySetupBody =>
      'Biex juri l-buttuna fuq apps oħra u jdaħħal it-test fejn hemm il-cursor, Talkpuppy jeħtieġ is-servizz tal-aċċessibbiltà tiegħu. Jaqra biss il-qasam fejn qed tikteb, u biss biex idaħħal it-test. Ma jaqra xejn iżjed fuq l-iskrin, ma jaħżen xejn minn apps oħra u ma jibgħat xejn imkien.\n\nFl-iskrin li jmiss, iftaħ “Talkpuppy” u ixgħlu.';

  @override
  String get overlaySetupShortcut =>
      'Ixgħel biss is-swiċċ ta\' Talkpuppy u ħalli “Shortcut” mitfi: il-buttuna tidher waħedha.';

  @override
  String get shortcutHint =>
      'Ix-“Shortcut” ta\' Talkpuppy huwa mixgħul, għalhekk Android iwaħħal l-ikona tal-app mat-tarf tal-iskrin. M\'għandekx bżonnu: il-buttuna li tgħum tidher waħedha. Itfi x-“Shortcut” fis-settings tal-aċċessibbiltà ta\' Talkpuppy.';

  @override
  String get shortcutHintAction => 'Iftaħ is-settings ta\' Talkpuppy';

  @override
  String get overlayOpenAccessibility => 'Iftaħ is-settings tal-aċċessibbiltà';

  @override
  String get overlayRestrictedHint =>
      'Is-swiċċ griż? Iftaħ Informazzjoni dwar l-app → ⋮ → “Ippermetti settings ristretti”, imbagħad erġa\' pprova.';

  @override
  String get defaultLanguageTitle =>
      'Lingwa default għal reġistrazzjonijiet ġodda';

  @override
  String get defaultLanguageHint =>
      'Jużawha Whisper u Nemotron; Parakeet dejjem jagħraf il-lingwa awtomatikament.';

  @override
  String get licensesTitle => 'Liċenzji';

  @override
  String get licensesSubtitle => 'Software u mudelli użati';

  @override
  String get licensesLegalese =>
      'Rikonoxximent tad-diskors b\'sherpa-onnx, Parakeet (NVIDIA, CC BY 4.0), Nemotron (NVIDIA, OpenMDW 1.1) u Whisper (OpenAI, MIT).';

  @override
  String get licensesIntro =>
      'Talkpuppy huwa mibni fuq software open source u mudelli tad-diskors b\'liċenzji miftuħa.';

  @override
  String get licensesSpeechModels => 'Mudelli tad-diskors';

  @override
  String get licensesSoftware => 'Software';

  @override
  String get licensesPackages => 'Flutter u pakketti open source oħra';

  @override
  String get licensesShowAll => 'Uri t-testi kollha tal-liċenzji';

  @override
  String get deleteAllTitle => 'Ħassar ir-reġistrazzjonijiet kollha';

  @override
  String get deleteAllConfirmTitle => 'Tħassar ir-reġistrazzjonijiet kollha?';

  @override
  String get deleteAllConfirmBody =>
      'It-traskrizzjonijiet u r-reġistrazzjonijiet kollha se jitħassru b\'mod permanenti.';

  @override
  String get errorMicPermission =>
      'M\'hemmx aċċess għall-mikrofonu. Jekk jogħġbok ippermettih fis-settings tat-telefown tiegħek.';

  @override
  String get errorMicBusy =>
      'Il-mikrofonu qed jintuża bħalissa, pereżempju minn telefonata. Erġa\' pprova wara t-telefonata.';

  @override
  String errorRecorderStart(String detail) {
    return 'Ir-reġistrazzjoni ma setgħetx tibda ($detail).';
  }

  @override
  String errorRecorderStop(String detail) {
    return 'Ir-reġistrazzjoni ma setgħetx titwaqqaf ($detail).';
  }

  @override
  String errorTranscription(String detail) {
    return 'It-traskrizzjoni falliet ($detail). Ir-reġistrazzjoni hija salvata u tista\' terġa\' tiġi traskritta.';
  }

  @override
  String errorRetranscribe(String detail) {
    return 'It-traskrizzjoni mill-ġdid falliet ($detail).';
  }

  @override
  String errorModelLoad(String model, String detail) {
    return '$model ma setax jitgħabba. Jekk dan jibqa\' jiġri, ħassar il-mudell u erġa\' niżżlu. ($detail)';
  }

  @override
  String get errorNoModel => 'L-ebda mudell mhu mgħobbi.';

  @override
  String downloadAlreadyRunning(String model) {
    return '$model diġà qed jitniżżel.';
  }

  @override
  String get downloadCancelled => 'It-tniżżil ġie kkanċellat.';

  @override
  String get downloadNetworkError =>
      'It-tniżżil falla. Jekk jogħġbok iċċekkja l-konnessjoni tal-internet u erġa\' pprova.';

  @override
  String get downloadNotModelFile =>
      'Is-server ma bagħatx fajl tal-mudell (forsi paġna tal-login tal-Wi-Fi). Jekk jogħġbok iċċekkja n-netwerk u erġa\' pprova.';

  @override
  String downloadCorrupt(String file) {
    return 'Il-fajl imniżżel $file huwa korrott. Jekk jogħġbok erġa\' pprova.';
  }

  @override
  String downloadNoSpace(String model) {
    return 'M\'hemmx biżżejjed spazju għal $model.';
  }
}
