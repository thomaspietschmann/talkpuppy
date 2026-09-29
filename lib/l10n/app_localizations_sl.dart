// ignore: unused_import
import 'package:intl/intl.dart' as intl;

import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Slovenian (`sl`).
class AppLocalizationsSl extends AppLocalizations {
  AppLocalizationsSl([String locale = 'sl']) : super(locale);

  @override
  String get logoSemantics => 'Logotip Talkpuppy';

  @override
  String startupFailed(String error) {
    return 'Talkpuppy se ni mogel zagnati:\n$error';
  }

  @override
  String get settingsTooltip => 'Nastavitve';

  @override
  String get switchModelTooltip => 'Zamenjaj model';

  @override
  String get manageModelsEllipsis => 'Upravljaj modele …';

  @override
  String get manageModels => 'Upravljaj modele';

  @override
  String get installModel => 'Namesti model';

  @override
  String get noModel => 'Ni modela';

  @override
  String get ok => 'V redu';

  @override
  String get cancel => 'Prekliči';

  @override
  String get delete => 'Izbriši';

  @override
  String get copy => 'Kopiraj';

  @override
  String get record => 'Snemaj';

  @override
  String get stopRecording => 'Ustavi';

  @override
  String get transcribing => 'Prepisujem …';

  @override
  String get newRecording => 'Nov posnetek';

  @override
  String get continueRecording => 'Snemaj naprej';

  @override
  String get transcriptLabel => 'Prepis';

  @override
  String get emptyTranscript => 'Še ni posnetka.\nTapni mikrofon spodaj.';

  @override
  String get noTextRecognized => '(ni prepoznanega besedila)';

  @override
  String get retranscribe => 'Ponovno prepiši';

  @override
  String get today => 'Danes';

  @override
  String get yesterday => 'Včeraj';

  @override
  String get welcomeTitle => 'Dobrodošli v Talkpuppy';

  @override
  String get welcomeBody =>
      'Izberi govorni model za prepisovanje. Deluje v celoti na tvoji napravi, brez interneta.';

  @override
  String get recommended => 'Priporočeno';

  @override
  String get preparing => 'Pripravljam …';

  @override
  String sizeMb(int size) {
    return '$size MB';
  }

  @override
  String downloadProgress(int received, int total) {
    return '$received MB / $total MB';
  }

  @override
  String get downloadAndStart => 'Prenesi in začni';

  @override
  String get download => 'Prenesi';

  @override
  String downloadFailed(String error) {
    return 'Prenos ni uspel: $error';
  }

  @override
  String get modelsTitle => 'Modeli';

  @override
  String get deleteModelTitle => 'Izbrišem model?';

  @override
  String deleteModelBody(String model, int size) {
    return '$model bo izbrisan s te naprave ($size MB).';
  }

  @override
  String get modelDescParakeet =>
      'Zelo natančen in hiter. Besedilo se prikaže, ko ustaviš snemanje. 25 evropskih jezikov, samodejno prepoznanih; jezika ni mogoče nastaviti. Velik prenos, za telefone z vsaj 6 GB RAM.';

  @override
  String get modelDescWhisperSmall =>
      'Največ jezikov (99), samodejno prepoznanih ali nastavljenih. Dobra natančnost, a počasnejši od modela Parakeet, pri tišini ali šumu pa si lahko občasno izmisli besede. Za telefone z vsaj 4 GB RAM.';

  @override
  String get modelDescWhisperBase =>
      'Majhen prenos za starejše telefone. 99 jezikov, samodejno prepoznanih ali nastavljenih. Opazno manj natančen od modela Whisper Small. Za telefone z vsaj 3 GB RAM.';

  @override
  String get modelDescWhisperTiny =>
      'Najmanjši in najhitrejši, deluje na skoraj vsakem telefonu. 99 jezikov, samodejno prepoznanih ali nastavljenih. Najmanj natančen, najboljši za kratke, razločno izgovorjene zapiske.';

  @override
  String get modelDescNemotron =>
      'Predogled v živo: besedilo se prikazuje že med govorjenjem in je pripravljeno, takoj ko nehaš. 28 jezikov, samodejno prepoznanih ali nastavljenih. Običajno nekoliko manj natančen od modela Parakeet. Velik prenos, za telefone z vsaj 6 GB RAM.';

  @override
  String get livePreviewLabel => 'Predogled v živo';

  @override
  String get livePreviewListening => 'Poslušam…';

  @override
  String get languageLabel => 'Jezik';

  @override
  String get auto => 'Samodejno';

  @override
  String get modelLabel => 'Model';

  @override
  String get whisperRequired =>
      'Za nastavljen jezik potrebuješ model Whisper ali Nemotron.';

  @override
  String get downloadWhisperSmall => 'Prenesi Whisper Small';

  @override
  String get settingsTitle => 'Nastavitve';

  @override
  String get appLanguageTitle => 'Jezik aplikacije';

  @override
  String get appLanguageSystem => 'Sistemsko privzeto';

  @override
  String get autoCopyTitle => 'Samodejno kopiraj';

  @override
  String get autoCopySubtitle =>
      'Besedilo takoj po prepisu kopiraj v odložišče';

  @override
  String get hapticsTitle => 'Haptični odziv';

  @override
  String get minimizeToOverlay => 'Pomanjšaj in prikaži prekrivanje';

  @override
  String get overlaySetupTitle => 'Vklopi storitev za dostopnost';

  @override
  String get overlaySetupBody =>
      'Da lahko Talkpuppy prikaže gumb nad drugimi aplikacijami in vstavi besedilo na mesto kazalca, potrebuje svojo storitev za dostopnost. Bere samo polje, v katero ravno tipkaš, in to samo zato, da vstavi besedilo. Ničesar drugega na zaslonu ne bere, ničesar iz drugih aplikacij ne shranjuje in ničesar nikamor ne pošilja.\n\nNa naslednjem zaslonu odpri »Talkpuppy« in ga vklopi.';

  @override
  String get overlaySetupShortcut =>
      'Vklopi samo stikalo Talkpuppy in pusti »Bližnjica« izklopljeno: gumb se prikaže sam.';

  @override
  String get shortcutHint =>
      '»Bližnjica« za Talkpuppy je vklopljena, zato Android pripne ikono aplikacije ob rob zaslona. Ne potrebuješ je: plavajoči gumb se prikaže sam. Izklopi »Bližnjica« v nastavitvah dostopnosti za Talkpuppy.';

  @override
  String get shortcutHintAction => 'Odpri nastavitve Talkpuppy';

  @override
  String get overlayOpenAccessibility => 'Odpri nastavitve dostopnosti';

  @override
  String get overlayRestrictedHint =>
      'Stikalo je sivo? Odpri Podatki o aplikaciji → ⋮ → »Dovoli omejene nastavitve« in poskusi znova.';

  @override
  String get defaultLanguageTitle => 'Privzeti jezik za nove posnetke';

  @override
  String get defaultLanguageHint =>
      'Uporabljata ga Whisper in Nemotron; Parakeet jezik vedno prepozna samodejno.';

  @override
  String get licensesTitle => 'Licence';

  @override
  String get licensesSubtitle => 'Uporabljena programska oprema in modeli';

  @override
  String get licensesLegalese =>
      'Prepoznavanje govora s sherpa-onnx, Parakeet (NVIDIA, CC BY 4.0), Nemotron (NVIDIA, OpenMDW 1.1) in Whisper (OpenAI, MIT).';

  @override
  String get licensesIntro =>
      'Talkpuppy temelji na odprtokodni programski opremi in govornih modelih z odprtimi licencami.';

  @override
  String get licensesSpeechModels => 'Govorni modeli';

  @override
  String get licensesSoftware => 'Programska oprema';

  @override
  String get licensesPackages => 'Flutter in drugi odprtokodni paketi';

  @override
  String get licensesShowAll => 'Prikaži vsa besedila licenc';

  @override
  String get deleteAllTitle => 'Izbriši vse posnetke';

  @override
  String get deleteAllConfirmTitle => 'Izbrišem vse posnetke?';

  @override
  String get deleteAllConfirmBody =>
      'Vsi prepisi in posnetki bodo trajno izbrisani.';

  @override
  String get errorMicPermission =>
      'Ni dostopa do mikrofona. Dovoli ga v nastavitvah telefona.';

  @override
  String get errorMicBusy =>
      'Mikrofon je trenutno zaseden, na primer zaradi klica. Poskusi znova po klicu.';

  @override
  String errorRecorderStart(String detail) {
    return 'Snemanja ni bilo mogoče začeti ($detail).';
  }

  @override
  String errorRecorderStop(String detail) {
    return 'Snemanja ni bilo mogoče ustaviti ($detail).';
  }

  @override
  String errorTranscription(String detail) {
    return 'Prepis ni uspel ($detail). Posnetek je shranjen in ga lahko ponovno prepišeš.';
  }

  @override
  String errorRetranscribe(String detail) {
    return 'Ponovni prepis ni uspel ($detail).';
  }

  @override
  String errorModelLoad(String model, String detail) {
    return 'Modela $model ni bilo mogoče naložiti. Če se to ponavlja, izbriši model in ga prenesi znova. ($detail)';
  }

  @override
  String get errorNoModel => 'Noben model ni naložen.';

  @override
  String downloadAlreadyRunning(String model) {
    return '$model se že prenaša.';
  }

  @override
  String get downloadCancelled => 'Prenos preklican.';

  @override
  String get downloadNetworkError =>
      'Prenos ni uspel. Preveri internetno povezavo in poskusi znova.';

  @override
  String get downloadNotModelFile =>
      'Strežnik ni vrnil datoteke modela (morda stran za prijavo v Wi-Fi). Preveri omrežje in poskusi znova.';

  @override
  String downloadCorrupt(String file) {
    return 'Prenesena datoteka $file je poškodovana. Poskusi znova.';
  }

  @override
  String downloadNoSpace(String model) {
    return 'Ni dovolj prostora za $model.';
  }
}
