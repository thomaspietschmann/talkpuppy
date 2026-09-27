// ignore: unused_import
import 'package:intl/intl.dart' as intl;

import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Danish (`da`).
class AppLocalizationsDa extends AppLocalizations {
  AppLocalizationsDa([String locale = 'da']) : super(locale);

  @override
  String get logoSemantics => 'Talkpuppy-logo';

  @override
  String startupFailed(String error) {
    return 'Talkpuppy kunne ikke starte:\n$error';
  }

  @override
  String get settingsTooltip => 'Indstillinger';

  @override
  String get switchModelTooltip => 'Skift model';

  @override
  String get manageModelsEllipsis => 'Administrer modeller…';

  @override
  String get manageModels => 'Administrer modeller';

  @override
  String get installModel => 'Installer model';

  @override
  String get noModel => 'Ingen model';

  @override
  String get ok => 'OK';

  @override
  String get cancel => 'Annuller';

  @override
  String get delete => 'Slet';

  @override
  String get copy => 'Kopiér';

  @override
  String get record => 'Optag';

  @override
  String get stopRecording => 'Stop';

  @override
  String get transcribing => 'Transskriberer…';

  @override
  String get newRecording => 'Ny optagelse';

  @override
  String get continueRecording => 'Optag videre';

  @override
  String get transcriptLabel => 'Transskription';

  @override
  String get emptyTranscript =>
      'Ingen optagelse endnu.\nTryk på mikrofonen nedenfor.';

  @override
  String get noTextRecognized => '(ingen tekst genkendt)';

  @override
  String get retranscribe => 'Transskriber igen';

  @override
  String get today => 'I dag';

  @override
  String get yesterday => 'I går';

  @override
  String get welcomeTitle => 'Velkommen til Talkpuppy';

  @override
  String get welcomeBody =>
      'Vælg en talemodel til transskription. Den kører helt på din enhed, uden internet.';

  @override
  String get recommended => 'Anbefalet';

  @override
  String get preparing => 'Forbereder…';

  @override
  String sizeMb(int size) {
    return '$size MB';
  }

  @override
  String downloadProgress(int received, int total) {
    return '$received MB / $total MB';
  }

  @override
  String get downloadAndStart => 'Download og kom i gang';

  @override
  String get download => 'Download';

  @override
  String downloadFailed(String error) {
    return 'Download mislykkedes: $error';
  }

  @override
  String get modelsTitle => 'Modeller';

  @override
  String get deleteModelTitle => 'Slet model?';

  @override
  String deleteModelBody(String model, int size) {
    return '$model slettes fra denne enhed ($size MB).';
  }

  @override
  String get modelDescParakeet =>
      'Meget hurtig og meget præcis, 25 europæiske sprog, genkender sproget automatisk. Anbefales til telefoner med mindst 6 GB RAM.';

  @override
  String get modelDescWhisperSmall =>
      'En balance mellem hastighed og præcision, 99 sprog, sproget kan fastlåses. Til telefoner med mindst 4 GB RAM.';

  @override
  String get modelDescWhisperBase =>
      'Letvægtsmodel til ældre telefoner, 99 sprog, sproget kan fastlåses. Til telefoner med mindst 3 GB RAM.';

  @override
  String get modelDescWhisperTiny =>
      'Minimal og hurtigst at downloade. 99 sprog, sproget kan fastlåses. Kører på stort set alle telefoner.';

  @override
  String get languageLabel => 'Sprog';

  @override
  String get auto => 'Auto';

  @override
  String get modelLabel => 'Model';

  @override
  String get whisperRequired => 'Et fast sprog kræver en Whisper-model.';

  @override
  String get downloadWhisperSmall => 'Download Whisper Small';

  @override
  String get settingsTitle => 'Indstillinger';

  @override
  String get appLanguageTitle => 'Appsprog';

  @override
  String get appLanguageSystem => 'Systemstandard';

  @override
  String get autoCopyTitle => 'Kopiér automatisk';

  @override
  String get autoCopySubtitle =>
      'Læg teksten i udklipsholderen lige efter transskriptionen';

  @override
  String get hapticsTitle => 'Haptisk feedback';

  @override
  String get defaultLanguageTitle => 'Standardsprog for nye optagelser';

  @override
  String get defaultLanguageHint =>
      'Bruges kun af Whisper-modeller; Parakeet genkender altid sproget automatisk.';

  @override
  String get licensesTitle => 'Licenser';

  @override
  String get licensesSubtitle => 'Anvendt software og modeller';

  @override
  String get licensesLegalese =>
      'Talegenkendelse med sherpa-onnx, Parakeet (NVIDIA, CC BY 4.0) og Whisper (OpenAI, MIT).';

  @override
  String get deleteAllTitle => 'Slet alle optagelser';

  @override
  String get deleteAllConfirmTitle => 'Slet alle optagelser?';

  @override
  String get deleteAllConfirmBody =>
      'Alle transskriptioner og optagelser slettes permanent.';

  @override
  String get errorMicPermission =>
      'Ingen adgang til mikrofonen. Giv adgang i telefonens indstillinger.';

  @override
  String errorRecorderStart(String detail) {
    return 'Kunne ikke starte optagelsen ($detail).';
  }

  @override
  String errorRecorderStop(String detail) {
    return 'Kunne ikke stoppe optagelsen ($detail).';
  }

  @override
  String errorTranscription(String detail) {
    return 'Transskriptionen mislykkedes ($detail). Optagelsen er gemt og kan transskriberes igen.';
  }

  @override
  String errorRetranscribe(String detail) {
    return 'Den nye transskription mislykkedes ($detail).';
  }

  @override
  String errorModelLoad(String model, String detail) {
    return '$model kunne ikke indlæses. Hvis det bliver ved, så slet modellen og download den igen. ($detail)';
  }

  @override
  String get errorNoModel => 'Ingen model indlæst.';

  @override
  String downloadAlreadyRunning(String model) {
    return '$model downloades allerede.';
  }

  @override
  String get downloadCancelled => 'Download annulleret.';

  @override
  String get downloadNetworkError =>
      'Download mislykkedes. Tjek din internetforbindelse, og prøv igen.';

  @override
  String get downloadNotModelFile =>
      'Serveren sendte ikke en modelfil (måske en login-side til wi-fi). Tjek dit netværk, og prøv igen.';

  @override
  String downloadCorrupt(String file) {
    return 'Den downloadede fil $file er beskadiget. Prøv igen.';
  }

  @override
  String downloadNoSpace(String model) {
    return 'Ikke nok lagerplads til $model.';
  }
}
