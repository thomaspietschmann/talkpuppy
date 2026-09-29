// ignore: unused_import
import 'package:intl/intl.dart' as intl;

import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Albanian (`sq`).
class AppLocalizationsSq extends AppLocalizations {
  AppLocalizationsSq([String locale = 'sq']) : super(locale);

  @override
  String get logoSemantics => 'Logoja e Talkpuppy';

  @override
  String startupFailed(String error) {
    return 'Talkpuppy nuk mund të niste:\n$error';
  }

  @override
  String get settingsTooltip => 'Cilësimet';

  @override
  String get switchModelTooltip => 'Ndërro modelin';

  @override
  String get manageModelsEllipsis => 'Menaxho modelet…';

  @override
  String get manageModels => 'Menaxho modelet';

  @override
  String get installModel => 'Instalo modelin';

  @override
  String get noModel => 'Asnjë model';

  @override
  String get ok => 'Në rregull';

  @override
  String get cancel => 'Anulo';

  @override
  String get delete => 'Fshi';

  @override
  String get copy => 'Kopjo';

  @override
  String get record => 'Regjistro';

  @override
  String get stopRecording => 'Ndalo';

  @override
  String get transcribing => 'Po transkriptohet…';

  @override
  String get newRecording => 'Regjistrim i ri';

  @override
  String get continueRecording => 'Vazhdo regjistrimin';

  @override
  String get transcriptLabel => 'Transkripti';

  @override
  String get emptyTranscript =>
      'Ende asnjë regjistrim.\nPrek mikrofonin më poshtë.';

  @override
  String get noTextRecognized => '(nuk u njoh asnjë tekst)';

  @override
  String get retranscribe => 'Transkripto sërish';

  @override
  String get today => 'Sot';

  @override
  String get yesterday => 'Dje';

  @override
  String get welcomeTitle => 'Mirë se vjen në Talkpuppy';

  @override
  String get welcomeBody =>
      'Zgjidh një model të të folurit për transkriptim. Punon plotësisht në pajisjen tënde, pa internet.';

  @override
  String get recommended => 'I rekomanduar';

  @override
  String get preparing => 'Po përgatitet…';

  @override
  String sizeMb(int size) {
    return '$size MB';
  }

  @override
  String downloadProgress(int received, int total) {
    return '$received MB / $total MB';
  }

  @override
  String get downloadAndStart => 'Shkarko dhe fillo';

  @override
  String get download => 'Shkarko';

  @override
  String downloadFailed(String error) {
    return 'Shkarkimi dështoi: $error';
  }

  @override
  String get modelsTitle => 'Modelet';

  @override
  String get deleteModelTitle => 'Të fshihet modeli?';

  @override
  String deleteModelBody(String model, int size) {
    return '$model do të fshihet nga kjo pajisje ($size MB).';
  }

  @override
  String get modelDescParakeet =>
      'Shumë i saktë dhe i shpejtë. Teksti shfaqet sapo ndalon regjistrimin. 25 gjuhë evropiane, të njohura automatikisht; gjuha nuk mund të fiksohet. Shkarkim i madh, për telefona me të paktën 6 GB RAM.';

  @override
  String get modelDescWhisperSmall =>
      'Më shumë gjuhë (99), të njohura automatikisht ose të fiksuara. Saktësi e mirë, por më i ngadaltë se Parakeet, dhe në heshtje ose zhurmë ndonjëherë mund të shpikë fjalë. Për telefona me të paktën 4 GB RAM.';

  @override
  String get modelDescWhisperBase =>
      'Shkarkim i vogël për telefona më të vjetër. 99 gjuhë, të njohura automatikisht ose të fiksuara. Dukshëm më pak i saktë se Whisper Small. Për telefona me të paktën 3 GB RAM.';

  @override
  String get modelDescWhisperTiny =>
      'Më i vogli dhe më i shpejti, punon praktikisht në çdo telefon. 99 gjuhë, të njohura automatikisht ose të fiksuara. Më pak i sakti, më i miri për shënime të shkurtra, të thëna qartë.';

  @override
  String get modelDescNemotron =>
      'Pamje paraprake e drejtpërdrejtë: teksti shfaqet ndërsa flet dhe është gati sapo ndalon. 28 gjuhë, të njohura automatikisht ose të fiksuara. Zakonisht pak më pak i saktë se Parakeet. Shkarkim i madh, për telefona me të paktën 6 GB RAM.';

  @override
  String get livePreviewLabel => 'Pamje paraprake e drejtpërdrejtë';

  @override
  String get livePreviewListening => 'Duke dëgjuar…';

  @override
  String get languageLabel => 'Gjuha';

  @override
  String get auto => 'Automatike';

  @override
  String get modelLabel => 'Modeli';

  @override
  String get whisperRequired =>
      'Një gjuhë e fiksuar kërkon një model Whisper ose Nemotron.';

  @override
  String get downloadWhisperSmall => 'Shkarko Whisper Small';

  @override
  String get settingsTitle => 'Cilësimet';

  @override
  String get appLanguageTitle => 'Gjuha e aplikacionit';

  @override
  String get appLanguageSystem => 'Parazgjedhja e sistemit';

  @override
  String get autoCopyTitle => 'Kopjo automatikisht';

  @override
  String get autoCopySubtitle =>
      'Vendos tekstin në kujtesën e fragmenteve menjëherë pas transkriptimit';

  @override
  String get hapticsTitle => 'Reagimi me prekje';

  @override
  String get defaultLanguageTitle =>
      'Gjuha e parazgjedhur për regjistrimet e reja';

  @override
  String get defaultLanguageHint =>
      'E përdorin Whisper dhe Nemotron; Parakeet e njeh gjithmonë gjuhën automatikisht.';

  @override
  String get licensesTitle => 'Licencat';

  @override
  String get licensesSubtitle => 'Softueri dhe modelet e përdorura';

  @override
  String get licensesLegalese =>
      'Njohja e të folurit me sherpa-onnx, Parakeet (NVIDIA, CC BY 4.0), Nemotron (NVIDIA, OpenMDW 1.1) dhe Whisper (OpenAI, MIT).';

  @override
  String get licensesIntro =>
      'Talkpuppy është ndërtuar mbi softuer me burim të hapur dhe modele të të folurit me licenca të hapura.';

  @override
  String get licensesSpeechModels => 'Modelet e të folurit';

  @override
  String get licensesSoftware => 'Softueri';

  @override
  String get licensesPackages =>
      'Flutter dhe paketa të tjera me burim të hapur';

  @override
  String get licensesShowAll => 'Shfaq të gjitha tekstet e licencave';

  @override
  String get deleteAllTitle => 'Fshi të gjitha regjistrimet';

  @override
  String get deleteAllConfirmTitle => 'Të fshihen të gjitha regjistrimet?';

  @override
  String get deleteAllConfirmBody =>
      'Të gjitha transkriptet dhe regjistrimet do të fshihen përgjithmonë.';

  @override
  String get errorMicPermission =>
      'Nuk ka qasje te mikrofoni. Lejoje te cilësimet e telefonit.';

  @override
  String errorRecorderStart(String detail) {
    return 'Regjistrimi nuk mund të niste ($detail).';
  }

  @override
  String errorRecorderStop(String detail) {
    return 'Regjistrimi nuk mund të ndalej ($detail).';
  }

  @override
  String errorTranscription(String detail) {
    return 'Transkriptimi dështoi ($detail). Regjistrimi është ruajtur dhe mund të transkriptohet sërish.';
  }

  @override
  String errorRetranscribe(String detail) {
    return 'Ritranskriptimi dështoi ($detail).';
  }

  @override
  String errorModelLoad(String model, String detail) {
    return '$model nuk mund të ngarkohej. Nëse kjo përsëritet, fshije modelin dhe shkarkoje përsëri. ($detail)';
  }

  @override
  String get errorNoModel => 'Asnjë model i ngarkuar.';

  @override
  String downloadAlreadyRunning(String model) {
    return '$model po shkarkohet tashmë.';
  }

  @override
  String get downloadCancelled => 'Shkarkimi u anulua.';

  @override
  String get downloadNetworkError =>
      'Shkarkimi dështoi. Kontrollo lidhjen me internetin dhe provo sërish.';

  @override
  String get downloadNotModelFile =>
      'Serveri nuk ktheu skedar modeli (ndoshta një faqe hyrjeje Wi-Fi). Kontrollo rrjetin dhe provo sërish.';

  @override
  String downloadCorrupt(String file) {
    return 'Skedari i shkarkuar $file është i dëmtuar. Provo sërish.';
  }

  @override
  String downloadNoSpace(String model) {
    return 'Nuk ka hapësirë të mjaftueshme për $model.';
  }
}
