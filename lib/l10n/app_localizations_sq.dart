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
      'Shumë i shpejtë dhe shumë i saktë, 25 gjuhë evropiane, e njeh gjuhën automatikisht. I rekomanduar për telefona me të paktën 6 GB RAM.';

  @override
  String get modelDescWhisperSmall =>
      'I balancuar mes shpejtësisë dhe saktësisë, 99 gjuhë, gjuha mund të fiksohet. Për telefona me të paktën 4 GB RAM.';

  @override
  String get modelDescWhisperBase =>
      'I lehtë për telefona më të vjetër, 99 gjuhë, gjuha mund të fiksohet. Për telefona me të paktën 3 GB RAM.';

  @override
  String get modelDescWhisperTiny =>
      'Minimal dhe më i shpejti për t\'u shkarkuar. 99 gjuhë, gjuha mund të fiksohet. Punon praktikisht në çdo telefon.';

  @override
  String get languageLabel => 'Gjuha';

  @override
  String get auto => 'Automatike';

  @override
  String get modelLabel => 'Modeli';

  @override
  String get whisperRequired => 'Një gjuhë e fiksuar kërkon një model Whisper.';

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
      'E përdorin vetëm modelet Whisper; Parakeet e njeh gjithmonë gjuhën automatikisht.';

  @override
  String get licensesTitle => 'Licencat';

  @override
  String get licensesSubtitle => 'Softueri dhe modelet e përdorura';

  @override
  String get licensesLegalese =>
      'Njohja e të folurit me sherpa-onnx, Parakeet (NVIDIA, CC BY 4.0) dhe Whisper (OpenAI, MIT).';

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
