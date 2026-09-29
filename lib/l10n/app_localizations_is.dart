// ignore: unused_import
import 'package:intl/intl.dart' as intl;

import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Icelandic (`is`).
class AppLocalizationsIs extends AppLocalizations {
  AppLocalizationsIs([String locale = 'is']) : super(locale);

  @override
  String get logoSemantics => 'Merki Talkpuppy';

  @override
  String startupFailed(String error) {
    return 'Ekki tókst að ræsa Talkpuppy:\n$error';
  }

  @override
  String get settingsTooltip => 'Stillingar';

  @override
  String get switchModelTooltip => 'Skipta um líkan';

  @override
  String get manageModelsEllipsis => 'Stjórna líkönum…';

  @override
  String get manageModels => 'Stjórna líkönum';

  @override
  String get installModel => 'Setja upp líkan';

  @override
  String get noModel => 'Ekkert líkan';

  @override
  String get ok => 'Í lagi';

  @override
  String get cancel => 'Hætta við';

  @override
  String get delete => 'Eyða';

  @override
  String get copy => 'Afrita';

  @override
  String get record => 'Taka upp';

  @override
  String get stopRecording => 'Stöðva';

  @override
  String get transcribing => 'Umritar…';

  @override
  String get newRecording => 'Ný upptaka';

  @override
  String get continueRecording => 'Halda upptöku áfram';

  @override
  String get transcriptLabel => 'Umritun';

  @override
  String get emptyTranscript =>
      'Engin upptaka enn.\nÝttu á hljóðnemann hér fyrir neðan.';

  @override
  String get noTextRecognized => '(enginn texti greindist)';

  @override
  String get retranscribe => 'Umrita aftur';

  @override
  String get today => 'Í dag';

  @override
  String get yesterday => 'Í gær';

  @override
  String get welcomeTitle => 'Velkomin í Talkpuppy';

  @override
  String get welcomeBody =>
      'Veldu talmálslíkan fyrir umritun. Það keyrir alfarið á tækinu þínu, engin nettenging nauðsynleg.';

  @override
  String get recommended => 'Mælt með';

  @override
  String get preparing => 'Undirbý…';

  @override
  String sizeMb(int size) {
    return '$size MB';
  }

  @override
  String downloadProgress(int received, int total) {
    return '$received MB / $total MB';
  }

  @override
  String get downloadAndStart => 'Sækja og byrja';

  @override
  String get download => 'Sækja';

  @override
  String downloadFailed(String error) {
    return 'Niðurhal mistókst: $error';
  }

  @override
  String get modelsTitle => 'Líkön';

  @override
  String get deleteModelTitle => 'Eyða líkani?';

  @override
  String deleteModelBody(String model, int size) {
    return '$model verður eytt af þessu tæki ($size MB).';
  }

  @override
  String get modelDescParakeet =>
      'Mjög nákvæmt og hratt. Textinn birtist þegar þú stöðvar upptökuna. 25 evrópsk tungumál, greind sjálfkrafa; ekki er hægt að festa tungumálið. Stórt niðurhal, fyrir síma með minnst 6 GB RAM.';

  @override
  String get modelDescWhisperSmall =>
      'Flest tungumál (99), greind sjálfkrafa eða fest. Góð nákvæmni, en hægara en Parakeet, og í þögn eða hávaða getur það stöku sinnum búið til orð. Fyrir síma með minnst 4 GB RAM.';

  @override
  String get modelDescWhisperBase =>
      'Lítið niðurhal fyrir eldri síma. 99 tungumál, greind sjálfkrafa eða fest. Greinilega ónákvæmara en Whisper Small. Fyrir síma með minnst 3 GB RAM.';

  @override
  String get modelDescWhisperTiny =>
      'Minnst og hraðast, keyrir á nánast hvaða síma sem er. 99 tungumál, greind sjálfkrafa eða fest. Ónákvæmast, best fyrir stuttar, skýrt talaðar glósur.';

  @override
  String get modelDescNemotron =>
      'Bein forskoðun: textinn birtist á meðan þú talar og er tilbúinn um leið og þú hættir. 28 tungumál, greind sjálfkrafa eða fest. Yfirleitt aðeins ónákvæmara en Parakeet. Stórt niðurhal, fyrir síma með minnst 6 GB RAM.';

  @override
  String get livePreviewLabel => 'Bein forskoðun';

  @override
  String get livePreviewListening => 'Hlustar…';

  @override
  String get languageLabel => 'Tungumál';

  @override
  String get auto => 'Sjálfvirkt';

  @override
  String get modelLabel => 'Líkan';

  @override
  String get whisperRequired =>
      'Fast tungumál krefst Whisper- eða Nemotron-líkans.';

  @override
  String get downloadWhisperSmall => 'Sækja Whisper Small';

  @override
  String get settingsTitle => 'Stillingar';

  @override
  String get appLanguageTitle => 'Tungumál forrits';

  @override
  String get appLanguageSystem => 'Sjálfgildi kerfis';

  @override
  String get autoCopyTitle => 'Afrita sjálfkrafa';

  @override
  String get autoCopySubtitle =>
      'Setja textann á klippiborðið strax eftir umritun';

  @override
  String get hapticsTitle => 'Snertisvörun';

  @override
  String get defaultLanguageTitle => 'Sjálfgefið tungumál fyrir nýjar upptökur';

  @override
  String get defaultLanguageHint =>
      'Whisper og Nemotron nota þetta; Parakeet greinir tungumálið alltaf sjálfkrafa.';

  @override
  String get licensesTitle => 'Leyfi';

  @override
  String get licensesSubtitle => 'Hugbúnaður og líkön sem eru notuð';

  @override
  String get licensesLegalese =>
      'Talgreining með sherpa-onnx, Parakeet (NVIDIA, CC BY 4.0), Nemotron (NVIDIA, OpenMDW 1.1) og Whisper (OpenAI, MIT).';

  @override
  String get licensesIntro =>
      'Talkpuppy byggir á opnum hugbúnaði og talmálslíkönum með opnum leyfum.';

  @override
  String get licensesSpeechModels => 'Talmálslíkön';

  @override
  String get licensesSoftware => 'Hugbúnaður';

  @override
  String get licensesPackages => 'Flutter og aðrir opnir hugbúnaðarpakkar';

  @override
  String get licensesShowAll => 'Sýna alla leyfistexta';

  @override
  String get deleteAllTitle => 'Eyða öllum upptökum';

  @override
  String get deleteAllConfirmTitle => 'Eyða öllum upptökum?';

  @override
  String get deleteAllConfirmBody =>
      'Öllum umritunum og upptökum verður eytt varanlega.';

  @override
  String get errorMicPermission =>
      'Enginn aðgangur að hljóðnema. Leyfðu hann í stillingum símans.';

  @override
  String errorRecorderStart(String detail) {
    return 'Ekki tókst að hefja upptöku ($detail).';
  }

  @override
  String errorRecorderStop(String detail) {
    return 'Ekki tókst að stöðva upptöku ($detail).';
  }

  @override
  String errorTranscription(String detail) {
    return 'Umritun mistókst ($detail). Upptakan er vistuð og hægt er að umrita hana aftur.';
  }

  @override
  String errorRetranscribe(String detail) {
    return 'Endurumritun mistókst ($detail).';
  }

  @override
  String errorModelLoad(String model, String detail) {
    return 'Ekki tókst að hlaða $model. Ef þetta gerist aftur skaltu eyða líkaninu og sækja það aftur. ($detail)';
  }

  @override
  String get errorNoModel => 'Ekkert líkan hlaðið.';

  @override
  String downloadAlreadyRunning(String model) {
    return 'Nú þegar er verið að sækja $model.';
  }

  @override
  String get downloadCancelled => 'Hætt var við niðurhal.';

  @override
  String get downloadNetworkError =>
      'Niðurhal mistókst. Athugaðu nettenginguna og reyndu aftur.';

  @override
  String get downloadNotModelFile =>
      'Þjónninn skilaði ekki líkanaskrá (kannski innskráningarsíðu fyrir Wi-Fi). Athugaðu netið og reyndu aftur.';

  @override
  String downloadCorrupt(String file) {
    return 'Skráin $file sem var sótt er skemmd. Reyndu aftur.';
  }

  @override
  String downloadNoSpace(String model) {
    return 'Ekki nægt geymslupláss fyrir $model.';
  }
}
