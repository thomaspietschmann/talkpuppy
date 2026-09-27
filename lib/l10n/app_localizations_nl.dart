// ignore: unused_import
import 'package:intl/intl.dart' as intl;

import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Dutch Flemish (`nl`).
class AppLocalizationsNl extends AppLocalizations {
  AppLocalizationsNl([String locale = 'nl']) : super(locale);

  @override
  String get logoSemantics => 'Talkpuppy-logo';

  @override
  String startupFailed(String error) {
    return 'Talkpuppy kon niet starten:\n$error';
  }

  @override
  String get settingsTooltip => 'Instellingen';

  @override
  String get switchModelTooltip => 'Model wisselen';

  @override
  String get manageModelsEllipsis => 'Modellen beheren…';

  @override
  String get manageModels => 'Modellen beheren';

  @override
  String get installModel => 'Model installeren';

  @override
  String get noModel => 'Geen model';

  @override
  String get ok => 'OK';

  @override
  String get cancel => 'Annuleren';

  @override
  String get delete => 'Verwijderen';

  @override
  String get copy => 'Kopiëren';

  @override
  String get record => 'Opnemen';

  @override
  String get stopRecording => 'Stoppen';

  @override
  String get transcribing => 'Transcriberen…';

  @override
  String get newRecording => 'Nieuwe opname';

  @override
  String get continueRecording => 'Verder opnemen';

  @override
  String get transcriptLabel => 'Transcriptie';

  @override
  String get emptyTranscript =>
      'Nog geen opname.\nTik hieronder op de microfoon.';

  @override
  String get noTextRecognized => '(geen tekst herkend)';

  @override
  String get retranscribe => 'Opnieuw transcriberen';

  @override
  String get today => 'Vandaag';

  @override
  String get yesterday => 'Gisteren';

  @override
  String get welcomeTitle => 'Welkom bij Talkpuppy';

  @override
  String get welcomeBody =>
      'Kies een spraakmodel voor de transcriptie. Het draait volledig op je apparaat, zonder internet.';

  @override
  String get recommended => 'Aanbevolen';

  @override
  String get preparing => 'Voorbereiden…';

  @override
  String sizeMb(int size) {
    return '$size MB';
  }

  @override
  String downloadProgress(int received, int total) {
    return '$received MB / $total MB';
  }

  @override
  String get downloadAndStart => 'Downloaden en beginnen';

  @override
  String get download => 'Downloaden';

  @override
  String downloadFailed(String error) {
    return 'Downloaden mislukt: $error';
  }

  @override
  String get modelsTitle => 'Modellen';

  @override
  String get deleteModelTitle => 'Model verwijderen?';

  @override
  String deleteModelBody(String model, int size) {
    return '$model wordt van dit apparaat verwijderd ($size MB).';
  }

  @override
  String get modelDescParakeet =>
      'Zeer snel en zeer nauwkeurig, 25 Europese talen, herkent de taal automatisch. Aanbevolen voor telefoons met minstens 6 GB RAM.';

  @override
  String get modelDescWhisperSmall =>
      'Balans tussen snelheid en nauwkeurigheid, 99 talen, taal kan vast worden ingesteld. Voor telefoons met minstens 4 GB RAM.';

  @override
  String get modelDescWhisperBase =>
      'Lichtgewicht voor oudere telefoons, 99 talen, taal kan vast worden ingesteld. Voor telefoons met minstens 3 GB RAM.';

  @override
  String get modelDescWhisperTiny =>
      'Minimaal en het snelst gedownload. 99 talen, taal kan vast worden ingesteld. Werkt op vrijwel elke telefoon.';

  @override
  String get languageLabel => 'Taal';

  @override
  String get auto => 'Auto';

  @override
  String get modelLabel => 'Model';

  @override
  String get whisperRequired =>
      'Voor een vaste taal heb je een Whisper-model nodig.';

  @override
  String get downloadWhisperSmall => 'Whisper Small downloaden';

  @override
  String get settingsTitle => 'Instellingen';

  @override
  String get appLanguageTitle => 'App-taal';

  @override
  String get appLanguageSystem => 'Systeemstandaard';

  @override
  String get autoCopyTitle => 'Automatisch kopiëren';

  @override
  String get autoCopySubtitle =>
      'Zet de tekst direct na het transcriberen op het klembord';

  @override
  String get hapticsTitle => 'Haptische feedback';

  @override
  String get defaultLanguageTitle => 'Standaardtaal voor nieuwe opnames';

  @override
  String get defaultLanguageHint =>
      'Alleen Whisper-modellen gebruiken dit; Parakeet herkent de taal altijd automatisch.';

  @override
  String get licensesTitle => 'Licenties';

  @override
  String get licensesSubtitle => 'Gebruikte software en modellen';

  @override
  String get licensesLegalese =>
      'Spraakherkenning met sherpa-onnx, Parakeet (NVIDIA, CC BY 4.0) en Whisper (OpenAI, MIT).';

  @override
  String get deleteAllTitle => 'Alle opnames verwijderen';

  @override
  String get deleteAllConfirmTitle => 'Alle opnames verwijderen?';

  @override
  String get deleteAllConfirmBody =>
      'Alle transcripties en opnames worden definitief verwijderd.';

  @override
  String get errorMicPermission =>
      'Geen toegang tot de microfoon. Sta dit toe in de instellingen van je telefoon.';

  @override
  String errorRecorderStart(String detail) {
    return 'Kan opname niet starten ($detail).';
  }

  @override
  String errorRecorderStop(String detail) {
    return 'Kan opname niet stoppen ($detail).';
  }

  @override
  String errorTranscription(String detail) {
    return 'Transcriptie mislukt ($detail). De opname is opgeslagen en kan opnieuw worden getranscribeerd.';
  }

  @override
  String errorRetranscribe(String detail) {
    return 'Opnieuw transcriberen mislukt ($detail).';
  }

  @override
  String errorModelLoad(String model, String detail) {
    return '$model kon niet worden geladen. Blijft dit gebeuren, verwijder dan het model en download het opnieuw. ($detail)';
  }

  @override
  String get errorNoModel => 'Geen model geladen.';

  @override
  String downloadAlreadyRunning(String model) {
    return '$model wordt al gedownload.';
  }

  @override
  String get downloadCancelled => 'Downloaden geannuleerd.';

  @override
  String get downloadNetworkError =>
      'Downloaden mislukt. Controleer je internetverbinding en probeer het opnieuw.';

  @override
  String get downloadNotModelFile =>
      'De server gaf geen modelbestand terug (misschien een wifi-inlogpagina). Controleer je netwerk en probeer het opnieuw.';

  @override
  String downloadCorrupt(String file) {
    return 'Het gedownloade bestand $file is beschadigd. Probeer het opnieuw.';
  }

  @override
  String downloadNoSpace(String model) {
    return 'Niet genoeg opslagruimte voor $model.';
  }
}
