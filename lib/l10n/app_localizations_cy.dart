// ignore: unused_import
import 'package:intl/intl.dart' as intl;

import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Welsh (`cy`).
class AppLocalizationsCy extends AppLocalizations {
  AppLocalizationsCy([String locale = 'cy']) : super(locale);

  @override
  String get logoSemantics => 'Logo Talkpuppy';

  @override
  String startupFailed(String error) {
    return 'Methodd Talkpuppy â chychwyn:\n$error';
  }

  @override
  String get settingsTooltip => 'Gosodiadau';

  @override
  String get switchModelTooltip => 'Newid model';

  @override
  String get manageModelsEllipsis => 'Rheoli modelau…';

  @override
  String get manageModels => 'Rheoli modelau';

  @override
  String get installModel => 'Gosod model';

  @override
  String get noModel => 'Dim model';

  @override
  String get ok => 'Iawn';

  @override
  String get cancel => 'Canslo';

  @override
  String get delete => 'Dileu';

  @override
  String get copy => 'Copïo';

  @override
  String get record => 'Recordio';

  @override
  String get stopRecording => 'Stopio';

  @override
  String get transcribing => 'Yn trawsgrifio…';

  @override
  String get newRecording => 'Recordiad newydd';

  @override
  String get continueRecording => 'Dal i recordio';

  @override
  String get transcriptLabel => 'Trawsgrifiad';

  @override
  String get emptyTranscript => 'Dim recordiad eto.\nTapia\'r meicroffon isod.';

  @override
  String get noTextRecognized => '(dim testun wedi\'i adnabod)';

  @override
  String get retranscribe => 'Ail-drawsgrifio';

  @override
  String get today => 'Heddiw';

  @override
  String get yesterday => 'Ddoe';

  @override
  String get welcomeTitle => 'Croeso i Talkpuppy';

  @override
  String get welcomeBody =>
      'Dewisa fodel lleferydd ar gyfer trawsgrifio. Mae\'n rhedeg yn llwyr ar dy ddyfais, heb angen y rhyngrwyd.';

  @override
  String get recommended => 'Argymhellir';

  @override
  String get preparing => 'Yn paratoi…';

  @override
  String sizeMb(int size) {
    return '$size MB';
  }

  @override
  String downloadProgress(int received, int total) {
    return '$received MB / $total MB';
  }

  @override
  String get downloadAndStart => 'Lawrlwytho a dechrau';

  @override
  String get download => 'Lawrlwytho';

  @override
  String downloadFailed(String error) {
    return 'Methodd y lawrlwytho: $error';
  }

  @override
  String get modelsTitle => 'Modelau';

  @override
  String get deleteModelTitle => 'Dileu\'r model?';

  @override
  String deleteModelBody(String model, int size) {
    return 'Bydd $model yn cael ei ddileu o\'r ddyfais hon ($size MB).';
  }

  @override
  String get modelDescParakeet =>
      'Cywir iawn a chyflym. Mae\'r testun yn ymddangos pan fyddi di\'n stopio recordio. 25 o ieithoedd Ewropeaidd, yn cael eu hadnabod yn awtomatig; does dim modd gosod yr iaith. Lawrlwythiad mawr, ar gyfer ffonau ag o leiaf 6 GB o RAM.';

  @override
  String get modelDescWhisperSmall =>
      'Y nifer fwyaf o ieithoedd (99), yn cael eu hadnabod yn awtomatig neu wedi\'u gosod. Cywirdeb da, ond yn arafach na Parakeet, ac mewn tawelwch neu sŵn gall weithiau ddyfeisio geiriau. Ar gyfer ffonau ag o leiaf 4 GB o RAM.';

  @override
  String get modelDescWhisperBase =>
      'Lawrlwythiad bach ar gyfer ffonau hŷn. 99 o ieithoedd, yn cael eu hadnabod yn awtomatig neu wedi\'u gosod. Yn amlwg yn llai cywir na Whisper Small. Ar gyfer ffonau ag o leiaf 3 GB o RAM.';

  @override
  String get modelDescWhisperTiny =>
      'Y lleiaf a\'r cyflymaf, yn rhedeg ar bron unrhyw ffôn. 99 o ieithoedd, yn cael eu hadnabod yn awtomatig neu wedi\'u gosod. Y lleiaf cywir, gorau ar gyfer nodiadau byr wedi\'u llefaru\'n glir.';

  @override
  String get modelDescNemotron =>
      'Rhagolwg byw: mae\'r testun yn ymddangos wrth i ti siarad ac mae\'n barod cyn gynted ag y byddi di\'n stopio. 28 o ieithoedd, yn cael eu hadnabod yn awtomatig neu wedi\'u gosod. Fel arfer ychydig yn llai cywir na Parakeet. Lawrlwythiad mawr, ar gyfer ffonau ag o leiaf 6 GB o RAM.';

  @override
  String get livePreviewLabel => 'Rhagolwg byw';

  @override
  String get livePreviewListening => 'Yn gwrando…';

  @override
  String get languageLabel => 'Iaith';

  @override
  String get auto => 'Awto';

  @override
  String get modelLabel => 'Model';

  @override
  String get whisperRequired =>
      'Mae angen model Whisper neu Nemotron ar gyfer iaith benodol.';

  @override
  String get downloadWhisperSmall => 'Lawrlwytho Whisper Small';

  @override
  String get settingsTitle => 'Gosodiadau';

  @override
  String get appLanguageTitle => 'Iaith yr ap';

  @override
  String get appLanguageSystem => 'Rhagosodiad y system';

  @override
  String get autoCopyTitle => 'Copïo\'n awtomatig';

  @override
  String get autoCopySubtitle =>
      'Rhoi\'r testun ar y clipfwrdd yn syth ar ôl trawsgrifio';

  @override
  String get hapticsTitle => 'Adborth haptig';

  @override
  String get minimizeToOverlay => 'Lleihau a dangos y troshaen';

  @override
  String get overlaySetupTitle => 'Tro\'r gwasanaeth hygyrchedd ymlaen';

  @override
  String get overlaySetupBody =>
      'I ddangos y botwm dros apiau eraill a rhoi\'r testun wrth y cyrchwr, mae Talkpuppy angen ei wasanaeth hygyrchedd. Dim ond y maes rwyt ti\'n teipio ynddo y mae\'n ei ddarllen, a dim ond i roi\'r testun ynddo. Nid yw\'n darllen dim byd arall ar y sgrin, nid yw\'n cadw dim o apiau eraill ac nid yw\'n anfon dim i unman.\n\nAr y sgrin nesaf, agora “Talkpuppy” a\'i droi ymlaen.';

  @override
  String get overlaySetupShortcut =>
      'Tro switsh Talkpuppy ymlaen yn unig a gad “Llwybr byr” i ffwrdd: mae\'r botwm yn ymddangos ar ei ben ei hun.';

  @override
  String get shortcutHint =>
      'Mae “Llwybr byr” Talkpuppy ymlaen, felly mae Android yn pinio eicon yr ap i ymyl y sgrin. Does dim ei angen arnat ti: mae\'r botwm arnofiol yn ymddangos ar ei ben ei hun. Tro “Llwybr byr” i ffwrdd yng ngosodiadau hygyrchedd Talkpuppy.';

  @override
  String get shortcutHintAction => 'Agor gosodiadau Talkpuppy';

  @override
  String get overlayOpenAccessibility => 'Agor gosodiadau hygyrchedd';

  @override
  String get overlayRestrictedHint =>
      'Switsh yn llwyd? Agora Gwybodaeth ap → ⋮ → “Caniatáu gosodiadau cyfyngedig”, yna rho gynnig arall arni.';

  @override
  String get defaultLanguageTitle =>
      'Iaith ragosodedig ar gyfer recordiadau newydd';

  @override
  String get defaultLanguageHint =>
      'Mae Whisper a Nemotron yn defnyddio hyn; mae Parakeet bob amser yn adnabod yr iaith yn awtomatig.';

  @override
  String get licensesTitle => 'Trwyddedau';

  @override
  String get licensesSubtitle => 'Meddalwedd a modelau a ddefnyddir';

  @override
  String get licensesLegalese =>
      'Adnabod lleferydd gyda sherpa-onnx, Parakeet (NVIDIA, CC BY 4.0), Nemotron (NVIDIA, OpenMDW 1.1) a Whisper (OpenAI, MIT).';

  @override
  String get licensesIntro =>
      'Mae Talkpuppy wedi\'i adeiladu ar feddalwedd cod agored a modelau lleferydd â thrwyddedau agored.';

  @override
  String get licensesSpeechModels => 'Modelau lleferydd';

  @override
  String get licensesSoftware => 'Meddalwedd';

  @override
  String get licensesPackages => 'Flutter a phecynnau cod agored eraill';

  @override
  String get licensesShowAll => 'Dangos holl destunau\'r trwyddedau';

  @override
  String get deleteAllTitle => 'Dileu pob recordiad';

  @override
  String get deleteAllConfirmTitle => 'Dileu pob recordiad?';

  @override
  String get deleteAllConfirmBody =>
      'Bydd pob trawsgrifiad a recordiad yn cael eu dileu\'n barhaol.';

  @override
  String get errorMicPermission =>
      'Dim mynediad i\'r meicroffon. Rho ganiatâd yng ngosodiadau dy ffôn.';

  @override
  String get errorMicBusy =>
      'Mae\'r meicroffon yn cael ei ddefnyddio ar hyn o bryd, er enghraifft gan alwad ffôn. Rho gynnig arall arni ar ôl yr alwad.';

  @override
  String errorRecorderStart(String detail) {
    return 'Methu dechrau recordio ($detail).';
  }

  @override
  String errorRecorderStop(String detail) {
    return 'Methu stopio recordio ($detail).';
  }

  @override
  String errorTranscription(String detail) {
    return 'Methodd y trawsgrifio ($detail). Mae\'r recordiad wedi\'i gadw a gellir ei ail-drawsgrifio.';
  }

  @override
  String errorRetranscribe(String detail) {
    return 'Methodd yr ail-drawsgrifio ($detail).';
  }

  @override
  String errorModelLoad(String model, String detail) {
    return 'Methu llwytho $model. Os yw hyn yn dal i ddigwydd, dilea\'r model a\'i lawrlwytho eto. ($detail)';
  }

  @override
  String get errorNoModel => 'Dim model wedi\'i lwytho.';

  @override
  String downloadAlreadyRunning(String model) {
    return 'Mae $model eisoes yn lawrlwytho.';
  }

  @override
  String get downloadCancelled => 'Lawrlwytho wedi\'i ganslo.';

  @override
  String get downloadNetworkError =>
      'Methodd y lawrlwytho. Gwiria dy gysylltiad rhyngrwyd a rho gynnig arall arni.';

  @override
  String get downloadNotModelFile =>
      'Ni anfonodd y gweinydd ffeil model (tudalen mewngofnodi Wi-Fi efallai). Gwiria dy rwydwaith a rho gynnig arall arni.';

  @override
  String downloadCorrupt(String file) {
    return 'Mae\'r ffeil $file a lawrlwythwyd wedi\'i llygru. Rho gynnig arall arni.';
  }

  @override
  String downloadNoSpace(String model) {
    return 'Dim digon o le storio ar gyfer $model.';
  }
}
