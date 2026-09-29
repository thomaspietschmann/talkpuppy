// ignore: unused_import
import 'package:intl/intl.dart' as intl;

import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Swedish (`sv`).
class AppLocalizationsSv extends AppLocalizations {
  AppLocalizationsSv([String locale = 'sv']) : super(locale);

  @override
  String get logoSemantics => 'Talkpuppy-logotyp';

  @override
  String startupFailed(String error) {
    return 'Talkpuppy kunde inte starta:\n$error';
  }

  @override
  String get settingsTooltip => 'Inställningar';

  @override
  String get switchModelTooltip => 'Byt modell';

  @override
  String get manageModelsEllipsis => 'Hantera modeller…';

  @override
  String get manageModels => 'Hantera modeller';

  @override
  String get installModel => 'Installera modell';

  @override
  String get noModel => 'Ingen modell';

  @override
  String get ok => 'OK';

  @override
  String get cancel => 'Avbryt';

  @override
  String get delete => 'Radera';

  @override
  String get copy => 'Kopiera';

  @override
  String get record => 'Spela in';

  @override
  String get stopRecording => 'Stoppa';

  @override
  String get transcribing => 'Transkriberar…';

  @override
  String get newRecording => 'Ny inspelning';

  @override
  String get continueRecording => 'Fortsätt spela in';

  @override
  String get transcriptLabel => 'Transkription';

  @override
  String get emptyTranscript =>
      'Ingen inspelning än.\nTryck på mikrofonen nedan.';

  @override
  String get noTextRecognized => '(ingen text igenkänd)';

  @override
  String get retranscribe => 'Transkribera igen';

  @override
  String get today => 'Idag';

  @override
  String get yesterday => 'Igår';

  @override
  String get welcomeTitle => 'Välkommen till Talkpuppy';

  @override
  String get welcomeBody =>
      'Välj en talmodell för transkribering. Den körs helt på din enhet, inget internet behövs.';

  @override
  String get recommended => 'Rekommenderas';

  @override
  String get preparing => 'Förbereder…';

  @override
  String sizeMb(int size) {
    return '$size MB';
  }

  @override
  String downloadProgress(int received, int total) {
    return '$received MB / $total MB';
  }

  @override
  String get downloadAndStart => 'Ladda ner och kom igång';

  @override
  String get download => 'Ladda ner';

  @override
  String downloadFailed(String error) {
    return 'Nedladdningen misslyckades: $error';
  }

  @override
  String get modelsTitle => 'Modeller';

  @override
  String get deleteModelTitle => 'Radera modell?';

  @override
  String deleteModelBody(String model, int size) {
    return '$model raderas från den här enheten ($size MB).';
  }

  @override
  String get modelDescParakeet =>
      'Mycket exakt och snabb. Texten visas när du stoppar inspelningen. 25 europeiska språk, känns igen automatiskt; språket kan inte låsas. Stor nedladdning, för telefoner med minst 6 GB RAM.';

  @override
  String get modelDescWhisperSmall =>
      'Flest språk (99), känns igen automatiskt eller låses. God noggrannhet, men långsammare än Parakeet, och vid tystnad eller brus kan den ibland hitta på ord. För telefoner med minst 4 GB RAM.';

  @override
  String get modelDescWhisperBase =>
      'Liten nedladdning för äldre telefoner. 99 språk, känns igen automatiskt eller låses. Märkbart mindre exakt än Whisper Small. För telefoner med minst 3 GB RAM.';

  @override
  String get modelDescWhisperTiny =>
      'Minst och snabbast, fungerar på i stort sett alla telefoner. 99 språk, känns igen automatiskt eller låses. Minst exakt, bäst för korta, tydligt talade anteckningar.';

  @override
  String get modelDescNemotron =>
      'Liveförhandsvisning: texten visas medan du pratar och är klar så fort du slutar. 28 språk, känns igen automatiskt eller låses. Oftast lite mindre exakt än Parakeet. Stor nedladdning, för telefoner med minst 6 GB RAM.';

  @override
  String get livePreviewLabel => 'Liveförhandsvisning';

  @override
  String get livePreviewListening => 'Lyssnar…';

  @override
  String get languageLabel => 'Språk';

  @override
  String get auto => 'Auto';

  @override
  String get modelLabel => 'Modell';

  @override
  String get whisperRequired =>
      'Ett låst språk kräver en Whisper- eller Nemotron-modell.';

  @override
  String get downloadWhisperSmall => 'Ladda ner Whisper Small';

  @override
  String get settingsTitle => 'Inställningar';

  @override
  String get appLanguageTitle => 'Appspråk';

  @override
  String get appLanguageSystem => 'Systemstandard';

  @override
  String get autoCopyTitle => 'Kopiera automatiskt';

  @override
  String get autoCopySubtitle =>
      'Lägg texten i urklipp direkt efter transkriberingen';

  @override
  String get hapticsTitle => 'Haptisk feedback';

  @override
  String get defaultLanguageTitle => 'Standardspråk för nya inspelningar';

  @override
  String get defaultLanguageHint =>
      'Används av Whisper och Nemotron; Parakeet känner alltid igen språket automatiskt.';

  @override
  String get licensesTitle => 'Licenser';

  @override
  String get licensesSubtitle => 'Programvara och modeller som används';

  @override
  String get licensesLegalese =>
      'Taligenkänning med sherpa-onnx, Parakeet (NVIDIA, CC BY 4.0), Nemotron (NVIDIA, OpenMDW 1.1) och Whisper (OpenAI, MIT).';

  @override
  String get licensesIntro =>
      'Talkpuppy bygger på programvara med öppen källkod och talmodeller med öppna licenser.';

  @override
  String get licensesSpeechModels => 'Talmodeller';

  @override
  String get licensesSoftware => 'Programvara';

  @override
  String get licensesPackages => 'Flutter och andra paket med öppen källkod';

  @override
  String get licensesShowAll => 'Visa alla licenstexter';

  @override
  String get deleteAllTitle => 'Radera alla inspelningar';

  @override
  String get deleteAllConfirmTitle => 'Radera alla inspelningar?';

  @override
  String get deleteAllConfirmBody =>
      'Alla transkriptioner och inspelningar raderas permanent.';

  @override
  String get errorMicPermission =>
      'Ingen åtkomst till mikrofonen. Tillåt det i telefonens inställningar.';

  @override
  String errorRecorderStart(String detail) {
    return 'Kunde inte starta inspelningen ($detail).';
  }

  @override
  String errorRecorderStop(String detail) {
    return 'Kunde inte stoppa inspelningen ($detail).';
  }

  @override
  String errorTranscription(String detail) {
    return 'Transkriberingen misslyckades ($detail). Inspelningen är sparad och kan transkriberas igen.';
  }

  @override
  String errorRetranscribe(String detail) {
    return 'Den nya transkriberingen misslyckades ($detail).';
  }

  @override
  String errorModelLoad(String model, String detail) {
    return '$model kunde inte läsas in. Om det fortsätter, radera modellen och ladda ner den igen. ($detail)';
  }

  @override
  String get errorNoModel => 'Ingen modell inläst.';

  @override
  String downloadAlreadyRunning(String model) {
    return '$model laddas redan ner.';
  }

  @override
  String get downloadCancelled => 'Nedladdningen avbröts.';

  @override
  String get downloadNetworkError =>
      'Nedladdningen misslyckades. Kontrollera internetanslutningen och försök igen.';

  @override
  String get downloadNotModelFile =>
      'Servern skickade ingen modellfil (kanske en inloggningssida för wifi). Kontrollera nätverket och försök igen.';

  @override
  String downloadCorrupt(String file) {
    return 'Den nedladdade filen $file är skadad. Försök igen.';
  }

  @override
  String downloadNoSpace(String model) {
    return 'Inte tillräckligt med lagringsutrymme för $model.';
  }
}
