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
      'Mgħaġġel ħafna u preċiż ħafna, 25 lingwa Ewropea, jagħraf il-lingwa awtomatikament. Rakkomandat għal telefowns b\'mill-inqas 6 GB ta\' RAM.';

  @override
  String get modelDescWhisperSmall =>
      'Bilanċ bejn il-veloċità u l-preċiżjoni, 99 lingwa, il-lingwa tista\' tiġi ffissata. Għal telefowns b\'mill-inqas 4 GB ta\' RAM.';

  @override
  String get modelDescWhisperBase =>
      'Ħafif għal telefowns eqdem, 99 lingwa, il-lingwa tista\' tiġi ffissata. Għal telefowns b\'mill-inqas 3 GB ta\' RAM.';

  @override
  String get modelDescWhisperTiny =>
      'Minimu u l-aktar mgħaġġel biex jitniżżel. 99 lingwa, il-lingwa tista\' tiġi ffissata. Jaħdem fuq prattikament kull telefown.';

  @override
  String get languageLabel => 'Lingwa';

  @override
  String get auto => 'Awto';

  @override
  String get modelLabel => 'Mudell';

  @override
  String get whisperRequired => 'Lingwa fissa teħtieġ mudell Whisper.';

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
  String get defaultLanguageTitle =>
      'Lingwa default għal reġistrazzjonijiet ġodda';

  @override
  String get defaultLanguageHint =>
      'Jużawha biss il-mudelli Whisper; Parakeet dejjem jagħraf il-lingwa awtomatikament.';

  @override
  String get licensesTitle => 'Liċenzji';

  @override
  String get licensesSubtitle => 'Software u mudelli użati';

  @override
  String get licensesLegalese =>
      'Rikonoxximent tad-diskors b\'sherpa-onnx, Parakeet (NVIDIA, CC BY 4.0) u Whisper (OpenAI, MIT).';

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
