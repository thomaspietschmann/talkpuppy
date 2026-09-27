// ignore: unused_import
import 'package:intl/intl.dart' as intl;

import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Romanian Moldavian Moldovan (`ro`).
class AppLocalizationsRo extends AppLocalizations {
  AppLocalizationsRo([String locale = 'ro']) : super(locale);

  @override
  String get logoSemantics => 'Logo Talkpuppy';

  @override
  String startupFailed(String error) {
    return 'Talkpuppy nu a putut porni:\n$error';
  }

  @override
  String get settingsTooltip => 'Setări';

  @override
  String get switchModelTooltip => 'Schimbă modelul';

  @override
  String get manageModelsEllipsis => 'Gestionează modelele…';

  @override
  String get manageModels => 'Gestionează modelele';

  @override
  String get installModel => 'Instalează model';

  @override
  String get noModel => 'Niciun model';

  @override
  String get ok => 'OK';

  @override
  String get cancel => 'Anulează';

  @override
  String get delete => 'Șterge';

  @override
  String get copy => 'Copiază';

  @override
  String get record => 'Înregistrează';

  @override
  String get stopRecording => 'Oprește';

  @override
  String get transcribing => 'Se transcrie…';

  @override
  String get newRecording => 'Înregistrare nouă';

  @override
  String get continueRecording => 'Continuă';

  @override
  String get transcriptLabel => 'Transcriere';

  @override
  String get emptyTranscript =>
      'Nicio înregistrare încă.\nAtinge microfonul de mai jos.';

  @override
  String get noTextRecognized => '(niciun text recunoscut)';

  @override
  String get retranscribe => 'Transcrie din nou';

  @override
  String get today => 'Azi';

  @override
  String get yesterday => 'Ieri';

  @override
  String get welcomeTitle => 'Bun venit în Talkpuppy';

  @override
  String get welcomeBody =>
      'Alege un model de vorbire pentru transcriere. Rulează complet pe dispozitivul tău, fără internet.';

  @override
  String get recommended => 'Recomandat';

  @override
  String get preparing => 'Se pregătește…';

  @override
  String sizeMb(int size) {
    return '$size MB';
  }

  @override
  String downloadProgress(int received, int total) {
    return '$received MB / $total MB';
  }

  @override
  String get downloadAndStart => 'Descarcă și începe';

  @override
  String get download => 'Descarcă';

  @override
  String downloadFailed(String error) {
    return 'Descărcarea a eșuat: $error';
  }

  @override
  String get modelsTitle => 'Modele';

  @override
  String get deleteModelTitle => 'Ștergi modelul?';

  @override
  String deleteModelBody(String model, int size) {
    return '$model va fi șters de pe acest dispozitiv ($size MB).';
  }

  @override
  String get modelDescParakeet =>
      'Foarte rapid și foarte precis, 25 de limbi europene, detectează limba automat. Recomandat pentru telefoane cu cel puțin 6 GB de RAM.';

  @override
  String get modelDescWhisperSmall =>
      'Echilibru între viteză și precizie, 99 de limbi, limba poate fi fixată. Pentru telefoane cu cel puțin 4 GB de RAM.';

  @override
  String get modelDescWhisperBase =>
      'Ușor, pentru telefoane mai vechi, 99 de limbi, limba poate fi fixată. Pentru telefoane cu cel puțin 3 GB de RAM.';

  @override
  String get modelDescWhisperTiny =>
      'Minimal și cel mai rapid de descărcat. 99 de limbi, limba poate fi fixată. Merge pe aproape orice telefon.';

  @override
  String get languageLabel => 'Limbă';

  @override
  String get auto => 'Automat';

  @override
  String get modelLabel => 'Model';

  @override
  String get whisperRequired =>
      'Pentru o limbă fixă ai nevoie de un model Whisper.';

  @override
  String get downloadWhisperSmall => 'Descarcă Whisper Small';

  @override
  String get settingsTitle => 'Setări';

  @override
  String get appLanguageTitle => 'Limba aplicației';

  @override
  String get appLanguageSystem => 'Implicit sistem';

  @override
  String get autoCopyTitle => 'Copiere automată';

  @override
  String get autoCopySubtitle =>
      'Pune textul în clipboard imediat după transcriere';

  @override
  String get hapticsTitle => 'Feedback haptic';

  @override
  String get defaultLanguageTitle => 'Limba implicită pentru înregistrări noi';

  @override
  String get defaultLanguageHint =>
      'Se aplică doar modelelor Whisper; Parakeet detectează mereu limba automat.';

  @override
  String get licensesTitle => 'Licențe';

  @override
  String get licensesSubtitle => 'Software și modele folosite';

  @override
  String get licensesLegalese =>
      'Recunoaștere vocală cu sherpa-onnx, Parakeet (NVIDIA, CC BY 4.0) și Whisper (OpenAI, MIT).';

  @override
  String get deleteAllTitle => 'Șterge toate înregistrările';

  @override
  String get deleteAllConfirmTitle => 'Ștergi toate înregistrările?';

  @override
  String get deleteAllConfirmBody =>
      'Toate transcrierile și înregistrările vor fi șterse definitiv.';

  @override
  String get errorMicPermission =>
      'Nu există acces la microfon. Permite-l în setările telefonului.';

  @override
  String errorRecorderStart(String detail) {
    return 'Înregistrarea nu a putut porni ($detail).';
  }

  @override
  String errorRecorderStop(String detail) {
    return 'Înregistrarea nu a putut fi oprită ($detail).';
  }

  @override
  String errorTranscription(String detail) {
    return 'Transcrierea a eșuat ($detail). Înregistrarea este salvată și poate fi transcrisă din nou.';
  }

  @override
  String errorRetranscribe(String detail) {
    return 'Retranscrierea a eșuat ($detail).';
  }

  @override
  String errorModelLoad(String model, String detail) {
    return '$model nu a putut fi încărcat. Dacă problema persistă, șterge modelul și descarcă-l din nou. ($detail)';
  }

  @override
  String get errorNoModel => 'Niciun model încărcat.';

  @override
  String downloadAlreadyRunning(String model) {
    return '$model se descarcă deja.';
  }

  @override
  String get downloadCancelled => 'Descărcare anulată.';

  @override
  String get downloadNetworkError =>
      'Descărcarea a eșuat. Verifică conexiunea la internet și încearcă din nou.';

  @override
  String get downloadNotModelFile =>
      'Serverul nu a returnat un fișier de model (poate o pagină de autentificare Wi-Fi). Verifică rețeaua și încearcă din nou.';

  @override
  String downloadCorrupt(String file) {
    return 'Fișierul descărcat $file este corupt. Încearcă din nou.';
  }

  @override
  String downloadNoSpace(String model) {
    return 'Spațiu de stocare insuficient pentru $model.';
  }
}
