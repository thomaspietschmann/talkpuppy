// ignore: unused_import
import 'package:intl/intl.dart' as intl;

import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Croatian (`hr`).
class AppLocalizationsHr extends AppLocalizations {
  AppLocalizationsHr([String locale = 'hr']) : super(locale);

  @override
  String get logoSemantics => 'Logotip Talkpuppy';

  @override
  String startupFailed(String error) {
    return 'Talkpuppy se nije mogao pokrenuti:\n$error';
  }

  @override
  String get settingsTooltip => 'Postavke';

  @override
  String get switchModelTooltip => 'Promijeni model';

  @override
  String get manageModelsEllipsis => 'Upravljaj modelima…';

  @override
  String get manageModels => 'Upravljaj modelima';

  @override
  String get installModel => 'Instaliraj model';

  @override
  String get noModel => 'Nema modela';

  @override
  String get ok => 'U redu';

  @override
  String get cancel => 'Odustani';

  @override
  String get delete => 'Izbriši';

  @override
  String get copy => 'Kopiraj';

  @override
  String get record => 'Snimi';

  @override
  String get stopRecording => 'Zaustavi';

  @override
  String get transcribing => 'Transkribiram…';

  @override
  String get newRecording => 'Nova snimka';

  @override
  String get continueRecording => 'Nastavi snimati';

  @override
  String get transcriptLabel => 'Transkript';

  @override
  String get emptyTranscript => 'Još nema snimke.\nDodirni mikrofon ispod.';

  @override
  String get noTextRecognized => '(tekst nije prepoznat)';

  @override
  String get retranscribe => 'Ponovno transkribiraj';

  @override
  String get today => 'Danas';

  @override
  String get yesterday => 'Jučer';

  @override
  String get welcomeTitle => 'Dobro došli u Talkpuppy';

  @override
  String get welcomeBody =>
      'Odaberi govorni model za transkripciju. Radi u potpunosti na tvom uređaju, bez interneta.';

  @override
  String get recommended => 'Preporučeno';

  @override
  String get preparing => 'Pripremam…';

  @override
  String sizeMb(int size) {
    return '$size MB';
  }

  @override
  String downloadProgress(int received, int total) {
    return '$received MB / $total MB';
  }

  @override
  String get downloadAndStart => 'Preuzmi i započni';

  @override
  String get download => 'Preuzmi';

  @override
  String downloadFailed(String error) {
    return 'Preuzimanje nije uspjelo: $error';
  }

  @override
  String get modelsTitle => 'Modeli';

  @override
  String get deleteModelTitle => 'Izbrisati model?';

  @override
  String deleteModelBody(String model, int size) {
    return '$model bit će izbrisan s ovog uređaja ($size MB).';
  }

  @override
  String get modelDescParakeet =>
      'Vrlo brz i vrlo točan, 25 europskih jezika, automatski prepoznaje jezik. Preporučeno za telefone s najmanje 6 GB RAM-a.';

  @override
  String get modelDescWhisperSmall =>
      'Uravnotežen između brzine i točnosti, 99 jezika, jezik se može fiksirati. Za telefone s najmanje 4 GB RAM-a.';

  @override
  String get modelDescWhisperBase =>
      'Lagan, za starije telefone, 99 jezika, jezik se može fiksirati. Za telefone s najmanje 3 GB RAM-a.';

  @override
  String get modelDescWhisperTiny =>
      'Najmanji i najbrži za preuzimanje. 99 jezika, jezik se može fiksirati. Radi na praktički svakom telefonu.';

  @override
  String get languageLabel => 'Jezik';

  @override
  String get auto => 'Automatski';

  @override
  String get modelLabel => 'Model';

  @override
  String get whisperRequired => 'Za fiksni jezik potreban je model Whisper.';

  @override
  String get downloadWhisperSmall => 'Preuzmi Whisper Small';

  @override
  String get settingsTitle => 'Postavke';

  @override
  String get appLanguageTitle => 'Jezik aplikacije';

  @override
  String get appLanguageSystem => 'Zadano sustavom';

  @override
  String get autoCopyTitle => 'Kopiraj automatski';

  @override
  String get autoCopySubtitle =>
      'Stavi tekst u međuspremnik odmah nakon transkripcije';

  @override
  String get hapticsTitle => 'Haptičke povratne informacije';

  @override
  String get defaultLanguageTitle => 'Zadani jezik za nove snimke';

  @override
  String get defaultLanguageHint =>
      'Koriste ga samo modeli Whisper; Parakeet uvijek automatski prepoznaje jezik.';

  @override
  String get licensesTitle => 'Licence';

  @override
  String get licensesSubtitle => 'Korišteni softver i modeli';

  @override
  String get licensesLegalese =>
      'Prepoznavanje govora pomoću sherpa-onnx, Parakeet (NVIDIA, CC BY 4.0) i Whisper (OpenAI, MIT).';

  @override
  String get deleteAllTitle => 'Izbriši sve snimke';

  @override
  String get deleteAllConfirmTitle => 'Izbrisati sve snimke?';

  @override
  String get deleteAllConfirmBody =>
      'Svi transkripti i snimke bit će trajno izbrisani.';

  @override
  String get errorMicPermission =>
      'Nema pristupa mikrofonu. Dopusti ga u postavkama telefona.';

  @override
  String errorRecorderStart(String detail) {
    return 'Snimanje se nije moglo pokrenuti ($detail).';
  }

  @override
  String errorRecorderStop(String detail) {
    return 'Snimanje se nije moglo zaustaviti ($detail).';
  }

  @override
  String errorTranscription(String detail) {
    return 'Transkripcija nije uspjela ($detail). Snimka je spremljena i može se ponovno transkribirati.';
  }

  @override
  String errorRetranscribe(String detail) {
    return 'Ponovna transkripcija nije uspjela ($detail).';
  }

  @override
  String errorModelLoad(String model, String detail) {
    return 'Model $model nije se mogao učitati. Ako se to ponavlja, izbriši model i ponovno ga preuzmi. ($detail)';
  }

  @override
  String get errorNoModel => 'Nijedan model nije učitan.';

  @override
  String downloadAlreadyRunning(String model) {
    return '$model se već preuzima.';
  }

  @override
  String get downloadCancelled => 'Preuzimanje otkazano.';

  @override
  String get downloadNetworkError =>
      'Preuzimanje nije uspjelo. Provjeri internetsku vezu i pokušaj ponovno.';

  @override
  String get downloadNotModelFile =>
      'Poslužitelj nije vratio datoteku modela (možda stranica za prijavu na Wi-Fi). Provjeri mrežu i pokušaj ponovno.';

  @override
  String downloadCorrupt(String file) {
    return 'Preuzeta datoteka $file je oštećena. Pokušaj ponovno.';
  }

  @override
  String downloadNoSpace(String model) {
    return 'Nema dovoljno prostora za $model.';
  }
}
