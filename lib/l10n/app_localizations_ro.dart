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
      'Foarte precis și rapid. Textul apare când oprești înregistrarea. 25 de limbi europene, detectate automat; limba nu poate fi fixată. Descărcare mare, pentru telefoane cu cel puțin 6 GB de RAM.';

  @override
  String get modelDescWhisperSmall =>
      'Cele mai multe limbi (99), detectate automat sau fixate. Precizie bună, dar mai lent decât Parakeet, iar la liniște sau zgomot poate uneori să inventeze cuvinte. Pentru telefoane cu cel puțin 4 GB de RAM.';

  @override
  String get modelDescWhisperBase =>
      'Descărcare mică pentru telefoane mai vechi. 99 de limbi, detectate automat sau fixate. Vizibil mai puțin precis decât Whisper Small. Pentru telefoane cu cel puțin 3 GB de RAM.';

  @override
  String get modelDescWhisperTiny =>
      'Cel mai mic și mai rapid, merge pe aproape orice telefon. 99 de limbi, detectate automat sau fixate. Cel mai puțin precis, potrivit pentru notițe scurte, rostite clar.';

  @override
  String get modelDescNemotron =>
      'Previzualizare live: textul apare în timp ce vorbești și e gata imediat ce te oprești. 28 de limbi, detectate automat sau fixate. De obicei puțin mai puțin precis decât Parakeet. Descărcare mare, pentru telefoane cu cel puțin 6 GB de RAM.';

  @override
  String get livePreviewLabel => 'Previzualizare live';

  @override
  String get livePreviewListening => 'Ascult…';

  @override
  String get languageLabel => 'Limbă';

  @override
  String get auto => 'Automat';

  @override
  String get modelLabel => 'Model';

  @override
  String get whisperRequired =>
      'Pentru o limbă fixă ai nevoie de un model Whisper sau Nemotron.';

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
  String get minimizeToOverlay => 'Minimizează și afișează suprapunerea';

  @override
  String get overlaySetupTitle => 'Activează serviciul de accesibilitate';

  @override
  String get overlaySetupBody =>
      'Pentru a afișa butonul deasupra altor aplicații și a insera textul la cursor, Talkpuppy are nevoie de serviciul său de accesibilitate. Citește doar câmpul în care scrii și doar pentru a insera textul. Nu citește nimic altceva de pe ecran, nu salvează nimic din alte aplicații și nu trimite nimic nicăieri.\n\nPe ecranul următor, deschide „Talkpuppy” și activează-l.';

  @override
  String get overlaySetupShortcut =>
      'Activează doar comutatorul Talkpuppy și lasă „Comandă rapidă” dezactivată: butonul apare singur.';

  @override
  String get shortcutHint =>
      '„Comandă rapidă” pentru Talkpuppy este activată, de aceea Android fixează pictograma aplicației la marginea ecranului. Nu ai nevoie de ea: butonul plutitor apare singur. Dezactivează „Comandă rapidă” în setările de accesibilitate ale Talkpuppy.';

  @override
  String get shortcutHintAction => 'Deschide setările Talkpuppy';

  @override
  String get overlayOpenAccessibility => 'Deschide setările de accesibilitate';

  @override
  String get overlayRestrictedHint =>
      'Comutatorul e gri? Deschide Informații despre aplicație → ⋮ → „Permite setările restricționate”, apoi încearcă din nou.';

  @override
  String get defaultLanguageTitle => 'Limba implicită pentru înregistrări noi';

  @override
  String get defaultLanguageHint =>
      'Se aplică modelelor Whisper și Nemotron; Parakeet detectează mereu limba automat.';

  @override
  String get licensesTitle => 'Licențe';

  @override
  String get licensesSubtitle => 'Software și modele folosite';

  @override
  String get licensesLegalese =>
      'Recunoaștere vocală cu sherpa-onnx, Parakeet (NVIDIA, CC BY 4.0), Nemotron (NVIDIA, OpenMDW 1.1) și Whisper (OpenAI, MIT).';

  @override
  String get licensesIntro =>
      'Talkpuppy se bazează pe software open-source și pe modele de vorbire cu licențe deschise.';

  @override
  String get licensesSpeechModels => 'Modele de vorbire';

  @override
  String get licensesSoftware => 'Software';

  @override
  String get licensesPackages => 'Flutter și alte pachete open-source';

  @override
  String get licensesShowAll => 'Afișează toate textele licențelor';

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
  String get errorMicBusy =>
      'Microfonul este ocupat acum, de exemplu de un apel. Încearcă din nou după apel.';

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
