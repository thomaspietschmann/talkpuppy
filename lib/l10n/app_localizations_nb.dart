// ignore: unused_import
import 'package:intl/intl.dart' as intl;

import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Norwegian Bokmål (`nb`).
class AppLocalizationsNb extends AppLocalizations {
  AppLocalizationsNb([String locale = 'nb']) : super(locale);

  @override
  String get logoSemantics => 'Talkpuppy-logo';

  @override
  String startupFailed(String error) {
    return 'Talkpuppy kunne ikke starte:\n$error';
  }

  @override
  String get settingsTooltip => 'Innstillinger';

  @override
  String get switchModelTooltip => 'Bytt modell';

  @override
  String get manageModelsEllipsis => 'Administrer modeller…';

  @override
  String get manageModels => 'Administrer modeller';

  @override
  String get installModel => 'Installer modell';

  @override
  String get noModel => 'Ingen modell';

  @override
  String get ok => 'OK';

  @override
  String get cancel => 'Avbryt';

  @override
  String get delete => 'Slett';

  @override
  String get copy => 'Kopier';

  @override
  String get record => 'Ta opp';

  @override
  String get stopRecording => 'Stopp';

  @override
  String get transcribing => 'Transkriberer…';

  @override
  String get newRecording => 'Nytt opptak';

  @override
  String get continueRecording => 'Fortsett opptaket';

  @override
  String get transcriptLabel => 'Transkripsjon';

  @override
  String get emptyTranscript =>
      'Ingen opptak ennå.\nTrykk på mikrofonen nedenfor.';

  @override
  String get noTextRecognized => '(ingen tekst gjenkjent)';

  @override
  String get retranscribe => 'Transkriber på nytt';

  @override
  String get today => 'I dag';

  @override
  String get yesterday => 'I går';

  @override
  String get welcomeTitle => 'Velkommen til Talkpuppy';

  @override
  String get welcomeBody =>
      'Velg en talemodell for transkribering. Den kjører helt på enheten din, uten internett.';

  @override
  String get recommended => 'Anbefalt';

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
  String get downloadAndStart => 'Last ned og kom i gang';

  @override
  String get download => 'Last ned';

  @override
  String downloadFailed(String error) {
    return 'Nedlastingen mislyktes: $error';
  }

  @override
  String get modelsTitle => 'Modeller';

  @override
  String get deleteModelTitle => 'Slette modellen?';

  @override
  String deleteModelBody(String model, int size) {
    return '$model blir slettet fra denne enheten ($size MB).';
  }

  @override
  String get modelDescParakeet =>
      'Svært nøyaktig og rask. Teksten vises når du stopper opptaket. 25 europeiske språk, gjenkjennes automatisk; språket kan ikke låses. Stor nedlasting, for telefoner med minst 6 GB RAM.';

  @override
  String get modelDescWhisperSmall =>
      'Flest språk (99), gjenkjennes automatisk eller låses. God nøyaktighet, men tregere enn Parakeet, og ved stillhet eller støy kan den av og til finne på ord. For telefoner med minst 4 GB RAM.';

  @override
  String get modelDescWhisperBase =>
      'Liten nedlasting for eldre telefoner. 99 språk, gjenkjennes automatisk eller låses. Merkbart mindre nøyaktig enn Whisper Small. For telefoner med minst 3 GB RAM.';

  @override
  String get modelDescWhisperTiny =>
      'Minst og raskest, kjører på nesten alle telefoner. 99 språk, gjenkjennes automatisk eller låses. Minst nøyaktig, best for korte, tydelig uttalte notater.';

  @override
  String get modelDescNemotron =>
      'Direkte forhåndsvisning: teksten vises mens du snakker, og er klar så snart du stopper. 28 språk, gjenkjennes automatisk eller låses. Vanligvis litt mindre nøyaktig enn Parakeet. Stor nedlasting, for telefoner med minst 6 GB RAM.';

  @override
  String get livePreviewLabel => 'Direkte forhåndsvisning';

  @override
  String get livePreviewListening => 'Lytter…';

  @override
  String get languageLabel => 'Språk';

  @override
  String get auto => 'Auto';

  @override
  String get modelLabel => 'Modell';

  @override
  String get whisperRequired =>
      'Et fast språk krever en Whisper- eller Nemotron-modell.';

  @override
  String get downloadWhisperSmall => 'Last ned Whisper Small';

  @override
  String get settingsTitle => 'Innstillinger';

  @override
  String get appLanguageTitle => 'Appspråk';

  @override
  String get appLanguageSystem => 'Systemstandard';

  @override
  String get autoCopyTitle => 'Kopier automatisk';

  @override
  String get autoCopySubtitle =>
      'Legg teksten på utklippstavlen rett etter transkriberingen';

  @override
  String get hapticsTitle => 'Haptisk tilbakemelding';

  @override
  String get minimizeToOverlay => 'Minimer og vis overlegg';

  @override
  String get overlaySetupTitle => 'Slå på tilgjengelighetstjenesten';

  @override
  String get overlaySetupBody =>
      'For å vise knappen over andre apper og sette inn teksten ved markøren trenger Talkpuppy tilgjengelighetstjenesten sin. Den leser bare feltet du skriver i, og bare for å sette inn teksten. Den leser ikke noe annet på skjermen, lagrer ingenting fra andre apper og sender ingenting noe sted.\n\nÅpne «Talkpuppy» på neste skjerm, og slå den på.';

  @override
  String get overlaySetupShortcut =>
      'Slå bare på Talkpuppy-bryteren og la «Snarvei» være av: Knappen vises av seg selv.';

  @override
  String get shortcutHint =>
      '«Snarvei» for Talkpuppy er på, så Android fester appikonet til kanten av skjermen. Den trenger du ikke: Den flytende knappen vises av seg selv. Slå av «Snarvei» i tilgjengelighetsinnstillingene for Talkpuppy.';

  @override
  String get shortcutHintAction => 'Åpne Talkpuppy-innstillinger';

  @override
  String get overlayOpenAccessibility => 'Åpne tilgjengelighetsinnstillinger';

  @override
  String get overlayRestrictedHint =>
      'Er bryteren grå? Åpne Appinfo → ⋮ → «Tillat begrensede innstillinger», og prøv igjen.';

  @override
  String get defaultLanguageTitle => 'Standardspråk for nye opptak';

  @override
  String get defaultLanguageHint =>
      'Brukes av Whisper og Nemotron; Parakeet gjenkjenner alltid språket automatisk.';

  @override
  String get licensesTitle => 'Lisenser';

  @override
  String get licensesSubtitle => 'Programvare og modeller som brukes';

  @override
  String get licensesLegalese =>
      'Talegjenkjenning med sherpa-onnx, Parakeet (NVIDIA, CC BY 4.0), Nemotron (NVIDIA, OpenMDW 1.1) og Whisper (OpenAI, MIT).';

  @override
  String get licensesIntro =>
      'Talkpuppy er bygget på åpen kildekode og talemodeller med åpne lisenser.';

  @override
  String get licensesSpeechModels => 'Talemodeller';

  @override
  String get licensesSoftware => 'Programvare';

  @override
  String get licensesPackages => 'Flutter og andre pakker med åpen kildekode';

  @override
  String get licensesShowAll => 'Vis alle lisenstekster';

  @override
  String get deleteAllTitle => 'Slett alle opptak';

  @override
  String get deleteAllConfirmTitle => 'Slette alle opptak?';

  @override
  String get deleteAllConfirmBody =>
      'Alle transkripsjoner og opptak blir slettet permanent.';

  @override
  String get errorMicPermission =>
      'Ingen tilgang til mikrofonen. Gi tilgang i telefonens innstillinger.';

  @override
  String get errorMicBusy =>
      'Mikrofonen er i bruk akkurat nå, for eksempel av en telefonsamtale. Prøv igjen etter samtalen.';

  @override
  String errorRecorderStart(String detail) {
    return 'Kunne ikke starte opptaket ($detail).';
  }

  @override
  String errorRecorderStop(String detail) {
    return 'Kunne ikke stoppe opptaket ($detail).';
  }

  @override
  String errorTranscription(String detail) {
    return 'Transkriberingen mislyktes ($detail). Opptaket er lagret og kan transkriberes på nytt.';
  }

  @override
  String errorRetranscribe(String detail) {
    return 'Ny transkribering mislyktes ($detail).';
  }

  @override
  String errorModelLoad(String model, String detail) {
    return '$model kunne ikke lastes inn. Hvis dette fortsetter, sletter du modellen og laster den ned på nytt. ($detail)';
  }

  @override
  String get errorNoModel => 'Ingen modell lastet inn.';

  @override
  String downloadAlreadyRunning(String model) {
    return '$model lastes allerede ned.';
  }

  @override
  String get downloadCancelled => 'Nedlastingen ble avbrutt.';

  @override
  String get downloadNetworkError =>
      'Nedlastingen mislyktes. Sjekk internettilkoblingen og prøv igjen.';

  @override
  String get downloadNotModelFile =>
      'Serveren sendte ikke en modellfil (kanskje en innloggingsside for wifi). Sjekk nettverket og prøv igjen.';

  @override
  String downloadCorrupt(String file) {
    return 'Den nedlastede filen $file er skadet. Prøv igjen.';
  }

  @override
  String downloadNoSpace(String model) {
    return 'Ikke nok lagringsplass for $model.';
  }
}
