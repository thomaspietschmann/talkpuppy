// ignore: unused_import
import 'package:intl/intl.dart' as intl;

import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Bosnian (`bs`).
class AppLocalizationsBs extends AppLocalizations {
  AppLocalizationsBs([String locale = 'bs']) : super(locale);

  @override
  String get logoSemantics => 'Logo Talkpuppy';

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
  String get cancel => 'Otkaži';

  @override
  String get delete => 'Izbriši';

  @override
  String get copy => 'Kopiraj';

  @override
  String get record => 'Snimi';

  @override
  String get stopRecording => 'Zaustavi';

  @override
  String get transcribing => 'Transkribujem…';

  @override
  String get newRecording => 'Novi snimak';

  @override
  String get continueRecording => 'Nastavi snimati';

  @override
  String get transcriptLabel => 'Transkript';

  @override
  String get emptyTranscript => 'Još nema snimka.\nDodirni mikrofon ispod.';

  @override
  String get noTextRecognized => '(tekst nije prepoznat)';

  @override
  String get retranscribe => 'Ponovo transkribuj';

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
  String get downloadAndStart => 'Preuzmi i počni';

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
    return '$model će biti izbrisan s ovog uređaja ($size MB).';
  }

  @override
  String get modelDescParakeet =>
      'Vrlo tačan i brz. Tekst se pojavljuje kada zaustaviš snimanje. 25 evropskih jezika, automatski prepoznatih; jezik se ne može fiksirati. Veliko preuzimanje, za telefone s najmanje 6 GB RAM-a.';

  @override
  String get modelDescWhisperSmall =>
      'Najviše jezika (99), automatski prepoznatih ili fiksiranih. Dobra tačnost, ali sporiji od modela Parakeet, a pri tišini ili šumu ponekad može izmisliti riječi. Za telefone s najmanje 4 GB RAM-a.';

  @override
  String get modelDescWhisperBase =>
      'Malo preuzimanje za starije telefone. 99 jezika, automatski prepoznatih ili fiksiranih. Primjetno manje tačan od modela Whisper Small. Za telefone s najmanje 3 GB RAM-a.';

  @override
  String get modelDescWhisperTiny =>
      'Najmanji i najbrži, radi na praktično svakom telefonu. 99 jezika, automatski prepoznatih ili fiksiranih. Najmanje tačan, najbolji za kratke, jasno izgovorene bilješke.';

  @override
  String get modelDescNemotron =>
      'Pregled uživo: tekst se pojavljuje dok govoriš i spreman je čim prestaneš. 28 jezika, automatski prepoznatih ili fiksiranih. Obično malo manje tačan od modela Parakeet. Veliko preuzimanje, za telefone s najmanje 6 GB RAM-a.';

  @override
  String get livePreviewLabel => 'Pregled uživo';

  @override
  String get livePreviewListening => 'Slušam…';

  @override
  String get languageLabel => 'Jezik';

  @override
  String get auto => 'Automatski';

  @override
  String get modelLabel => 'Model';

  @override
  String get whisperRequired =>
      'Za fiksni jezik potreban je model Whisper ili Nemotron.';

  @override
  String get downloadWhisperSmall => 'Preuzmi Whisper Small';

  @override
  String get settingsTitle => 'Postavke';

  @override
  String get appLanguageTitle => 'Jezik aplikacije';

  @override
  String get appLanguageSystem => 'Zadano sistemom';

  @override
  String get autoCopyTitle => 'Kopiraj automatski';

  @override
  String get autoCopySubtitle =>
      'Stavi tekst u međuspremnik odmah nakon transkripcije';

  @override
  String get hapticsTitle => 'Haptičke povratne informacije';

  @override
  String get minimizeToOverlay => 'Minimiziraj i prikaži preklop';

  @override
  String get overlaySetupTitle => 'Uključi uslugu pristupačnosti';

  @override
  String get overlaySetupBody =>
      'Da bi prikazao dugme iznad drugih aplikacija i umetnuo tekst na mjesto kursora, Talkpuppy treba svoju uslugu pristupačnosti. Čita samo polje u kojem upravo pišeš, i to samo da umetne tekst. Ne čita ništa drugo na ekranu, ne sprema ništa iz drugih aplikacija i ništa nikome ne šalje.\n\nNa sljedećem ekranu otvori „Talkpuppy“ i uključi ga.';

  @override
  String get overlayOpenAccessibility => 'Otvori postavke pristupačnosti';

  @override
  String get overlayRestrictedHint =>
      'Prekidač je siv? Otvori Informacije o aplikaciji → ⋮ → „Dozvoli ograničene postavke“ i pokušaj ponovo.';

  @override
  String get defaultLanguageTitle => 'Zadani jezik za nove snimke';

  @override
  String get defaultLanguageHint =>
      'Koriste ga modeli Whisper i Nemotron; Parakeet uvijek automatski prepoznaje jezik.';

  @override
  String get licensesTitle => 'Licence';

  @override
  String get licensesSubtitle => 'Korišteni softver i modeli';

  @override
  String get licensesLegalese =>
      'Prepoznavanje govora pomoću sherpa-onnx, Parakeet (NVIDIA, CC BY 4.0), Nemotron (NVIDIA, OpenMDW 1.1) i Whisper (OpenAI, MIT).';

  @override
  String get licensesIntro =>
      'Talkpuppy je izgrađen na softveru otvorenog koda i govornim modelima s otvorenim licencama.';

  @override
  String get licensesSpeechModels => 'Govorni modeli';

  @override
  String get licensesSoftware => 'Softver';

  @override
  String get licensesPackages => 'Flutter i drugi paketi otvorenog koda';

  @override
  String get licensesShowAll => 'Prikaži sve tekstove licenci';

  @override
  String get deleteAllTitle => 'Izbriši sve snimke';

  @override
  String get deleteAllConfirmTitle => 'Izbrisati sve snimke?';

  @override
  String get deleteAllConfirmBody =>
      'Svi transkripti i snimci bit će trajno izbrisani.';

  @override
  String get errorMicPermission =>
      'Nema pristupa mikrofonu. Dozvoli ga u postavkama telefona.';

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
    return 'Transkripcija nije uspjela ($detail). Snimak je sačuvan i može se ponovo transkribovati.';
  }

  @override
  String errorRetranscribe(String detail) {
    return 'Ponovna transkripcija nije uspjela ($detail).';
  }

  @override
  String errorModelLoad(String model, String detail) {
    return 'Model $model se nije mogao učitati. Ako se to ponavlja, izbriši model i ponovo ga preuzmi. ($detail)';
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
      'Preuzimanje nije uspjelo. Provjeri internet vezu i pokušaj ponovo.';

  @override
  String get downloadNotModelFile =>
      'Server nije vratio datoteku modela (možda stranica za prijavu na Wi-Fi). Provjeri mrežu i pokušaj ponovo.';

  @override
  String downloadCorrupt(String file) {
    return 'Preuzeta datoteka $file je oštećena. Pokušaj ponovo.';
  }

  @override
  String downloadNoSpace(String model) {
    return 'Nema dovoljno prostora za $model.';
  }
}
