// ignore: unused_import
import 'package:intl/intl.dart' as intl;

import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Estonian (`et`).
class AppLocalizationsEt extends AppLocalizations {
  AppLocalizationsEt([String locale = 'et']) : super(locale);

  @override
  String get logoSemantics => 'Talkpuppy logo';

  @override
  String startupFailed(String error) {
    return 'Talkpuppy käivitamine ebaõnnestus:\n$error';
  }

  @override
  String get settingsTooltip => 'Seaded';

  @override
  String get switchModelTooltip => 'Vaheta mudelit';

  @override
  String get manageModelsEllipsis => 'Halda mudeleid…';

  @override
  String get manageModels => 'Halda mudeleid';

  @override
  String get installModel => 'Paigalda mudel';

  @override
  String get noModel => 'Mudel puudub';

  @override
  String get ok => 'OK';

  @override
  String get cancel => 'Tühista';

  @override
  String get delete => 'Kustuta';

  @override
  String get copy => 'Kopeeri';

  @override
  String get record => 'Salvesta';

  @override
  String get stopRecording => 'Peata';

  @override
  String get transcribing => 'Transkribeerin…';

  @override
  String get newRecording => 'Uus salvestus';

  @override
  String get continueRecording => 'Jätka salvestamist';

  @override
  String get transcriptLabel => 'Tekst';

  @override
  String get emptyTranscript =>
      'Salvestusi veel pole.\nPuuduta allolevat mikrofoni.';

  @override
  String get noTextRecognized => '(teksti ei tuvastatud)';

  @override
  String get retranscribe => 'Tuvasta uuesti';

  @override
  String get today => 'Täna';

  @override
  String get yesterday => 'Eile';

  @override
  String get welcomeTitle => 'Tere tulemast Talkpuppysse';

  @override
  String get welcomeBody =>
      'Vali transkribeerimiseks kõnemudel. See töötab täielikult sinu seadmes, internetti pole vaja.';

  @override
  String get recommended => 'Soovitatud';

  @override
  String get preparing => 'Ettevalmistamine…';

  @override
  String sizeMb(int size) {
    return '$size MB';
  }

  @override
  String downloadProgress(int received, int total) {
    return '$received MB / $total MB';
  }

  @override
  String get downloadAndStart => 'Laadi alla ja alusta';

  @override
  String get download => 'Laadi alla';

  @override
  String downloadFailed(String error) {
    return 'Allalaadimine ebaõnnestus: $error';
  }

  @override
  String get modelsTitle => 'Mudelid';

  @override
  String get deleteModelTitle => 'Kas kustutada mudel?';

  @override
  String deleteModelBody(String model, int size) {
    return '$model kustutatakse sellest seadmest ($size MB).';
  }

  @override
  String get modelDescParakeet =>
      'Väga kiire ja väga täpne, 25 Euroopa keelt, tuvastab keele automaatselt. Soovitatav telefonidele, millel on vähemalt 6 GB RAM-i.';

  @override
  String get modelDescWhisperSmall =>
      'Tasakaal kiiruse ja täpsuse vahel, 99 keelt, keele saab fikseerida. Telefonidele, millel on vähemalt 4 GB RAM-i.';

  @override
  String get modelDescWhisperBase =>
      'Kerge mudel vanematele telefonidele, 99 keelt, keele saab fikseerida. Telefonidele, millel on vähemalt 3 GB RAM-i.';

  @override
  String get modelDescWhisperTiny =>
      'Minimaalne ja kõige kiiremini allalaaditav. 99 keelt, keele saab fikseerida. Töötab praktiliselt igas telefonis.';

  @override
  String get languageLabel => 'Keel';

  @override
  String get auto => 'Automaatne';

  @override
  String get modelLabel => 'Mudel';

  @override
  String get whisperRequired =>
      'Fikseeritud keele jaoks on vaja Whisper mudelit.';

  @override
  String get downloadWhisperSmall => 'Laadi alla Whisper Small';

  @override
  String get settingsTitle => 'Seaded';

  @override
  String get appLanguageTitle => 'Rakenduse keel';

  @override
  String get appLanguageSystem => 'Süsteemi vaikeseade';

  @override
  String get autoCopyTitle => 'Kopeeri automaatselt';

  @override
  String get autoCopySubtitle =>
      'Pane tekst lõikelauale kohe pärast transkribeerimist';

  @override
  String get hapticsTitle => 'Haptiline tagasiside';

  @override
  String get defaultLanguageTitle => 'Uute salvestuste vaikekeel';

  @override
  String get defaultLanguageHint =>
      'Kehtib ainult Whisper mudelitele; Parakeet tuvastab keele alati automaatselt.';

  @override
  String get licensesTitle => 'Litsentsid';

  @override
  String get licensesSubtitle => 'Kasutatud tarkvara ja mudelid';

  @override
  String get licensesLegalese =>
      'Kõnetuvastus: sherpa-onnx, Parakeet (NVIDIA, CC BY 4.0) ja Whisper (OpenAI, MIT).';

  @override
  String get deleteAllTitle => 'Kustuta kõik salvestused';

  @override
  String get deleteAllConfirmTitle => 'Kas kustutada kõik salvestused?';

  @override
  String get deleteAllConfirmBody =>
      'Kõik tekstid ja salvestused kustutatakse jäädavalt.';

  @override
  String get errorMicPermission =>
      'Mikrofonile puudub juurdepääs. Luba see telefoni seadetes.';

  @override
  String errorRecorderStart(String detail) {
    return 'Salvestamist ei õnnestunud alustada ($detail).';
  }

  @override
  String errorRecorderStop(String detail) {
    return 'Salvestamist ei õnnestunud peatada ($detail).';
  }

  @override
  String errorTranscription(String detail) {
    return 'Transkribeerimine ebaõnnestus ($detail). Salvestus on alles ja selle saab uuesti tuvastada.';
  }

  @override
  String errorRetranscribe(String detail) {
    return 'Uuesti tuvastamine ebaõnnestus ($detail).';
  }

  @override
  String errorModelLoad(String model, String detail) {
    return 'Mudelit $model ei õnnestunud laadida. Kui see kordub, kustuta mudel ja laadi see uuesti alla. ($detail)';
  }

  @override
  String get errorNoModel => 'Ühtegi mudelit pole laaditud.';

  @override
  String downloadAlreadyRunning(String model) {
    return '$model laaditakse juba alla.';
  }

  @override
  String get downloadCancelled => 'Allalaadimine tühistati.';

  @override
  String get downloadNetworkError =>
      'Allalaadimine ebaõnnestus. Kontrolli internetiühendust ja proovi uuesti.';

  @override
  String get downloadNotModelFile =>
      'Server ei tagastanud mudelifaili (võib-olla Wi-Fi sisselogimislehe). Kontrolli võrku ja proovi uuesti.';

  @override
  String downloadCorrupt(String file) {
    return 'Allalaaditud fail $file on rikutud. Proovi uuesti.';
  }

  @override
  String downloadNoSpace(String model) {
    return 'Mudeli $model jaoks pole piisavalt salvestusruumi.';
  }
}
