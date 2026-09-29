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
      'Meget præcis og hurtig. Teksten vises, når du stopper optagelsen. 25 europæiske sprog, genkendes automatisk; sproget kan ikke fastlåses. Stor download, til telefoner med mindst 6 GB RAM.';

  @override
  String get modelDescWhisperSmall =>
      'Flest sprog (99), genkendes automatisk eller fastlåses. God præcision, men langsommere end Parakeet, og ved stilhed eller støj kan den af og til finde på ord. Til telefoner med mindst 4 GB RAM.';

  @override
  String get modelDescWhisperBase =>
      'Lille download til ældre telefoner. 99 sprog, genkendes automatisk eller fastlåses. Mærkbart mindre præcis end Whisper Small. Til telefoner med mindst 3 GB RAM.';

  @override
  String get modelDescWhisperTiny =>
      'Mindst og hurtigst, kører på stort set alle telefoner. 99 sprog, genkendes automatisk eller fastlåses. Mindst præcis, bedst til korte, tydeligt indtalte noter.';

  @override
  String get modelDescNemotron =>
      'Live-visning: teksten vises, mens du taler, og er klar, så snart du stopper. 28 sprog, genkendes automatisk eller fastlåses. Normalt en smule mindre præcis end Parakeet. Stor download, til telefoner med mindst 6 GB RAM.';

  @override
  String get livePreviewLabel => 'Live-visning';

  @override
  String get livePreviewListening => 'Lytter…';

  @override
  String get languageLabel => 'Sprog';

  @override
  String get auto => 'Auto';

  @override
  String get modelLabel => 'Model';

  @override
  String get whisperRequired =>
      'Et fast sprog kræver en Whisper- eller Nemotron-model.';

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
  String get minimizeToOverlay => 'Minimer og vis overlejring';

  @override
  String get overlaySetupTitle => 'Slå hjælpefunktionen til';

  @override
  String get overlaySetupBody =>
      'For at vise knappen oven på andre apps og indsætte teksten ved markøren skal Talkpuppy bruge sin hjælpefunktion. Den læser kun det felt, du skriver i, og kun for at indsætte teksten. Den læser ikke andet på skærmen, gemmer intet fra andre apps og sender intet nogen steder hen.\n\nÅbn “Talkpuppy” på næste skærm, og slå den til.';

  @override
  String get overlayOpenAccessibility =>
      'Åbn indstillinger for hjælpefunktioner';

  @override
  String get overlayRestrictedHint =>
      'Er kontakten grå? Åbn Appinfo → ⋮ → “Tillad begrænsede indstillinger”, og prøv igen.';

  @override
  String get defaultLanguageTitle => 'Standardsprog for nye optagelser';

  @override
  String get defaultLanguageHint =>
      'Bruges af Whisper og Nemotron; Parakeet genkender altid sproget automatisk.';

  @override
  String get licensesTitle => 'Licenser';

  @override
  String get licensesSubtitle => 'Anvendt software og modeller';

  @override
  String get licensesLegalese =>
      'Talegenkendelse med sherpa-onnx, Parakeet (NVIDIA, CC BY 4.0), Nemotron (NVIDIA, OpenMDW 1.1) og Whisper (OpenAI, MIT).';

  @override
  String get licensesIntro =>
      'Talkpuppy er bygget på open source-software og talemodeller med åbne licenser.';

  @override
  String get licensesSpeechModels => 'Talemodeller';

  @override
  String get licensesSoftware => 'Software';

  @override
  String get licensesPackages => 'Flutter og andre open source-pakker';

  @override
  String get licensesShowAll => 'Vis alle licenstekster';

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
