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
      'Zelo hiter in zelo natančen, 25 evropskih jezikov, jezik prepozna samodejno. Priporočeno za telefone z vsaj 6 GB RAM.';

  @override
  String get modelDescWhisperSmall =>
      'Uravnotežen med hitrostjo in natančnostjo, 99 jezikov, jezik je mogoče nastaviti. Za telefone z vsaj 4 GB RAM.';

  @override
  String get modelDescWhisperBase =>
      'Lahek model za starejše telefone, 99 jezikov, jezik je mogoče nastaviti. Za telefone z vsaj 3 GB RAM.';

  @override
  String get modelDescWhisperTiny =>
      'Najmanjši in najhitreje prenesen. 99 jezikov, jezik je mogoče nastaviti. Deluje na skoraj vsakem telefonu.';

  @override
  String get languageLabel => 'Jezik';

  @override
  String get auto => 'Samodejno';

  @override
  String get modelLabel => 'Model';

  @override
  String get whisperRequired => 'Za nastavljen jezik potrebuješ model Whisper.';

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
  String get defaultLanguageTitle => 'Privzeti jezik za nove posnetke';

  @override
  String get defaultLanguageHint =>
      'Uporabljajo ga samo modeli Whisper; Parakeet jezik vedno prepozna samodejno.';

  @override
  String get licensesTitle => 'Licence';

  @override
  String get licensesSubtitle => 'Uporabljena programska oprema in modeli';

  @override
  String get licensesLegalese =>
      'Prepoznavanje govora s sherpa-onnx, Parakeet (NVIDIA, CC BY 4.0) in Whisper (OpenAI, MIT).';

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
