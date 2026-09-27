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
      'Svært rask og svært nøyaktig, 25 europeiske språk, gjenkjenner språket automatisk. Anbefalt for telefoner med minst 6 GB RAM.';

  @override
  String get modelDescWhisperSmall =>
      'En balanse mellom hastighet og nøyaktighet, 99 språk, språket kan låses. For telefoner med minst 4 GB RAM.';

  @override
  String get modelDescWhisperBase =>
      'Lettvekter for eldre telefoner, 99 språk, språket kan låses. For telefoner med minst 3 GB RAM.';

  @override
  String get modelDescWhisperTiny =>
      'Minimal og raskest å laste ned. 99 språk, språket kan låses. Kjører på nesten alle telefoner.';

  @override
  String get languageLabel => 'Språk';

  @override
  String get auto => 'Auto';

  @override
  String get modelLabel => 'Modell';

  @override
  String get whisperRequired => 'Et fast språk krever en Whisper-modell.';

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
  String get defaultLanguageTitle => 'Standardspråk for nye opptak';

  @override
  String get defaultLanguageHint =>
      'Brukes bare av Whisper-modeller; Parakeet gjenkjenner alltid språket automatisk.';

  @override
  String get licensesTitle => 'Lisenser';

  @override
  String get licensesSubtitle => 'Programvare og modeller som brukes';

  @override
  String get licensesLegalese =>
      'Talegjenkjenning med sherpa-onnx, Parakeet (NVIDIA, CC BY 4.0) og Whisper (OpenAI, MIT).';

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
