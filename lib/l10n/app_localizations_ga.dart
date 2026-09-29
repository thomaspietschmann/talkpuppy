// ignore: unused_import
import 'package:intl/intl.dart' as intl;

import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Irish (`ga`).
class AppLocalizationsGa extends AppLocalizations {
  AppLocalizationsGa([String locale = 'ga']) : super(locale);

  @override
  String get logoSemantics => 'Lógó Talkpuppy';

  @override
  String startupFailed(String error) {
    return 'Níorbh fhéidir Talkpuppy a thosú:\n$error';
  }

  @override
  String get settingsTooltip => 'Socruithe';

  @override
  String get switchModelTooltip => 'Athraigh samhail';

  @override
  String get manageModelsEllipsis => 'Bainistigh samhlacha…';

  @override
  String get manageModels => 'Bainistigh samhlacha';

  @override
  String get installModel => 'Suiteáil samhail';

  @override
  String get noModel => 'Gan samhail';

  @override
  String get ok => 'OK';

  @override
  String get cancel => 'Cealaigh';

  @override
  String get delete => 'Scrios';

  @override
  String get copy => 'Cóipeáil';

  @override
  String get record => 'Taifead';

  @override
  String get stopRecording => 'Stop';

  @override
  String get transcribing => 'Á thras-scríobh…';

  @override
  String get newRecording => 'Taifead nua';

  @override
  String get continueRecording => 'Lean den taifeadadh';

  @override
  String get transcriptLabel => 'Tras-scríbhinn';

  @override
  String get emptyTranscript =>
      'Níl aon taifead fós.\nTapáil an micreafón thíos.';

  @override
  String get noTextRecognized => '(níor aithníodh aon téacs)';

  @override
  String get retranscribe => 'Tras-scríobh arís';

  @override
  String get today => 'Inniu';

  @override
  String get yesterday => 'Inné';

  @override
  String get welcomeTitle => 'Fáilte go Talkpuppy';

  @override
  String get welcomeBody =>
      'Roghnaigh samhail cainte don tras-scríobh. Ritheann sí go hiomlán ar do ghléas, níl gá leis an idirlíon.';

  @override
  String get recommended => 'Molta';

  @override
  String get preparing => 'Á ullmhú…';

  @override
  String sizeMb(int size) {
    return '$size MB';
  }

  @override
  String downloadProgress(int received, int total) {
    return '$received MB / $total MB';
  }

  @override
  String get downloadAndStart => 'Íoslódáil agus tosaigh';

  @override
  String get download => 'Íoslódáil';

  @override
  String downloadFailed(String error) {
    return 'Theip ar an íoslódáil: $error';
  }

  @override
  String get modelsTitle => 'Samhlacha';

  @override
  String get deleteModelTitle => 'Scrios an tsamhail?';

  @override
  String deleteModelBody(String model, int size) {
    return 'Scriosfar $model ón ngléas seo ($size MB).';
  }

  @override
  String get modelDescParakeet =>
      'An-chruinn agus tapa. Taispeántar an téacs nuair a stopann tú an taifeadadh. 25 teanga Eorpach, aithnítear go huathoibríoch iad; ní féidir an teanga a shocrú. Íoslódáil mhór, d\'fhóin a bhfuil 6 GB RAM ar a laghad acu.';

  @override
  String get modelDescWhisperSmall =>
      'An líon is mó teangacha (99), aithnítear go huathoibríoch iad nó socraítear iad. Cruinneas maith, ach níos moille ná Parakeet, agus le ciúnas nó torann d\'fhéadfadh sí focail a chumadh ó am go chéile. D\'fhóin a bhfuil 4 GB RAM ar a laghad acu.';

  @override
  String get modelDescWhisperBase =>
      'Íoslódáil bheag d\'fhóin níos sine. 99 teanga, aithnítear go huathoibríoch iad nó socraítear iad. Níos lú cruinnis go suntasach ná Whisper Small. D\'fhóin a bhfuil 3 GB RAM ar a laghad acu.';

  @override
  String get modelDescWhisperTiny =>
      'An ceann is lú agus is tapúla, ritheann sí ar bheagnach aon fhón. 99 teanga, aithnítear go huathoibríoch iad nó socraítear iad. An ceann is lú cruinnis, is fearr do nótaí gearra a labhraítear go soiléir.';

  @override
  String get modelDescNemotron =>
      'Réamhamharc beo: taispeántar an téacs fad is atá tú ag caint agus bíonn sé réidh a luaithe a stopann tú. 28 teanga, aithnítear go huathoibríoch iad nó socraítear iad. De ghnáth beagán níos lú cruinnis ná Parakeet. Íoslódáil mhór, d\'fhóin a bhfuil 6 GB RAM ar a laghad acu.';

  @override
  String get livePreviewLabel => 'Réamhamharc beo';

  @override
  String get livePreviewListening => 'Ag éisteacht…';

  @override
  String get languageLabel => 'Teanga';

  @override
  String get auto => 'Uathoibríoch';

  @override
  String get modelLabel => 'Samhail';

  @override
  String get whisperRequired =>
      'Tá samhail Whisper nó Nemotron ag teastáil le haghaidh teanga shocraithe.';

  @override
  String get downloadWhisperSmall => 'Íoslódáil Whisper Small';

  @override
  String get settingsTitle => 'Socruithe';

  @override
  String get appLanguageTitle => 'Teanga na haipe';

  @override
  String get appLanguageSystem => 'Réamhshocrú an chórais';

  @override
  String get autoCopyTitle => 'Cóipeáil go huathoibríoch';

  @override
  String get autoCopySubtitle =>
      'Cuir an téacs ar an ngearrthaisce díreach tar éis an tras-scríofa';

  @override
  String get hapticsTitle => 'Aiseolas haptach';

  @override
  String get defaultLanguageTitle => 'Teanga réamhshocraithe do thaifid nua';

  @override
  String get defaultLanguageHint =>
      'Úsáideann Whisper agus Nemotron é seo; aithníonn Parakeet an teanga go huathoibríoch i gcónaí.';

  @override
  String get licensesTitle => 'Ceadúnais';

  @override
  String get licensesSubtitle => 'Bogearraí agus samhlacha a úsáidtear';

  @override
  String get licensesLegalese =>
      'Aithint cainte le sherpa-onnx, Parakeet (NVIDIA, CC BY 4.0), Nemotron (NVIDIA, OpenMDW 1.1) agus Whisper (OpenAI, MIT).';

  @override
  String get licensesIntro =>
      'Tá Talkpuppy tógtha ar bhogearraí foinse oscailte agus ar shamhlacha cainte faoi cheadúnais oscailte.';

  @override
  String get licensesSpeechModels => 'Samhlacha cainte';

  @override
  String get licensesSoftware => 'Bogearraí';

  @override
  String get licensesPackages => 'Flutter agus pacáistí foinse oscailte eile';

  @override
  String get licensesShowAll => 'Taispeáin téacsanna uile na gceadúnas';

  @override
  String get deleteAllTitle => 'Scrios gach taifead';

  @override
  String get deleteAllConfirmTitle => 'Scrios gach taifead?';

  @override
  String get deleteAllConfirmBody =>
      'Scriosfar gach tras-scríbhinn agus taifead go buan.';

  @override
  String get errorMicPermission =>
      'Níl rochtain ar an micreafón. Ceadaigh é i socruithe an fhóin.';

  @override
  String errorRecorderStart(String detail) {
    return 'Níorbh fhéidir an taifeadadh a thosú ($detail).';
  }

  @override
  String errorRecorderStop(String detail) {
    return 'Níorbh fhéidir an taifeadadh a stopadh ($detail).';
  }

  @override
  String errorTranscription(String detail) {
    return 'Theip ar an tras-scríobh ($detail). Tá an taifead sábháilte agus is féidir é a thras-scríobh arís.';
  }

  @override
  String errorRetranscribe(String detail) {
    return 'Theip ar an tras-scríobh arís ($detail).';
  }

  @override
  String errorModelLoad(String model, String detail) {
    return 'Níorbh fhéidir $model a lódáil. Má tharlaíonn sé seo arís, scrios an tsamhail agus íoslódáil arís í. ($detail)';
  }

  @override
  String get errorNoModel => 'Níl aon samhail lódáilte.';

  @override
  String downloadAlreadyRunning(String model) {
    return 'Tá $model á íoslódáil cheana féin.';
  }

  @override
  String get downloadCancelled => 'Cealaíodh an íoslódáil.';

  @override
  String get downloadNetworkError =>
      'Theip ar an íoslódáil. Seiceáil do cheangal idirlín agus bain triail eile as.';

  @override
  String get downloadNotModelFile =>
      'Níor sheol an freastalaí comhad samhla (leathanach logála isteach Wi-Fi, b\'fhéidir). Seiceáil do líonra agus bain triail eile as.';

  @override
  String downloadCorrupt(String file) {
    return 'Tá an comhad íoslódáilte $file truaillithe. Bain triail eile as.';
  }

  @override
  String downloadNoSpace(String model) {
    return 'Níl dóthain stórais ann do $model.';
  }
}
