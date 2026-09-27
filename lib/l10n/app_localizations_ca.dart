// ignore: unused_import
import 'package:intl/intl.dart' as intl;

import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Catalan Valencian (`ca`).
class AppLocalizationsCa extends AppLocalizations {
  AppLocalizationsCa([String locale = 'ca']) : super(locale);

  @override
  String get logoSemantics => 'Logotip de Talkpuppy';

  @override
  String startupFailed(String error) {
    return 'No s\'ha pogut iniciar Talkpuppy:\n$error';
  }

  @override
  String get settingsTooltip => 'Configuració';

  @override
  String get switchModelTooltip => 'Canvia de model';

  @override
  String get manageModelsEllipsis => 'Gestiona els models…';

  @override
  String get manageModels => 'Gestiona els models';

  @override
  String get installModel => 'Instal·la un model';

  @override
  String get noModel => 'Cap model';

  @override
  String get ok => 'D\'acord';

  @override
  String get cancel => 'Cancel·la';

  @override
  String get delete => 'Suprimeix';

  @override
  String get copy => 'Copia';

  @override
  String get record => 'Grava';

  @override
  String get stopRecording => 'Atura';

  @override
  String get transcribing => 'S\'està transcrivint…';

  @override
  String get newRecording => 'Enregistrament nou';

  @override
  String get continueRecording => 'Continua gravant';

  @override
  String get transcriptLabel => 'Transcripció';

  @override
  String get emptyTranscript =>
      'Encara no hi ha cap enregistrament.\nToca el micròfon de sota.';

  @override
  String get noTextRecognized => '(no s\'ha reconegut cap text)';

  @override
  String get retranscribe => 'Torna a transcriure';

  @override
  String get today => 'Avui';

  @override
  String get yesterday => 'Ahir';

  @override
  String get welcomeTitle => 'Et donem la benvinguda a Talkpuppy';

  @override
  String get welcomeBody =>
      'Tria un model de veu per a la transcripció. Funciona completament al teu dispositiu, sense necessitat d\'internet.';

  @override
  String get recommended => 'Recomanat';

  @override
  String get preparing => 'S\'està preparant…';

  @override
  String sizeMb(int size) {
    return '$size MB';
  }

  @override
  String downloadProgress(int received, int total) {
    return '$received MB / $total MB';
  }

  @override
  String get downloadAndStart => 'Baixa i comença';

  @override
  String get download => 'Baixa';

  @override
  String downloadFailed(String error) {
    return 'Error en la baixada: $error';
  }

  @override
  String get modelsTitle => 'Models';

  @override
  String get deleteModelTitle => 'Vols suprimir el model?';

  @override
  String deleteModelBody(String model, int size) {
    return '$model se suprimirà d\'aquest dispositiu ($size MB).';
  }

  @override
  String get modelDescParakeet =>
      'Molt ràpid i molt precís, 25 idiomes europeus, detecta l\'idioma automàticament. Recomanat per a mòbils amb almenys 6 GB de RAM.';

  @override
  String get modelDescWhisperSmall =>
      'Equilibri entre velocitat i precisió, 99 idiomes, es pot fixar l\'idioma. Per a mòbils amb almenys 4 GB de RAM.';

  @override
  String get modelDescWhisperBase =>
      'Lleuger per a mòbils antics, 99 idiomes, es pot fixar l\'idioma. Per a mòbils amb almenys 3 GB de RAM.';

  @override
  String get modelDescWhisperTiny =>
      'Mínim i el més ràpid de baixar. 99 idiomes, es pot fixar l\'idioma. Funciona pràcticament en qualsevol mòbil.';

  @override
  String get languageLabel => 'Idioma';

  @override
  String get auto => 'Auto';

  @override
  String get modelLabel => 'Model';

  @override
  String get whisperRequired => 'Per fixar un idioma cal un model Whisper.';

  @override
  String get downloadWhisperSmall => 'Baixa Whisper Small';

  @override
  String get settingsTitle => 'Configuració';

  @override
  String get appLanguageTitle => 'Idioma de l\'app';

  @override
  String get appLanguageSystem => 'Predeterminat del sistema';

  @override
  String get autoCopyTitle => 'Copia automàticament';

  @override
  String get autoCopySubtitle =>
      'Copia el text al porta-retalls just després de la transcripció';

  @override
  String get hapticsTitle => 'Resposta hàptica';

  @override
  String get defaultLanguageTitle =>
      'Idioma predeterminat per als enregistraments nous';

  @override
  String get defaultLanguageHint =>
      'Només l\'utilitzen els models Whisper; Parakeet sempre detecta l\'idioma automàticament.';

  @override
  String get licensesTitle => 'Llicències';

  @override
  String get licensesSubtitle => 'Programari i models utilitzats';

  @override
  String get licensesLegalese =>
      'Reconeixement de veu amb sherpa-onnx, Parakeet (NVIDIA, CC BY 4.0) i Whisper (OpenAI, MIT).';

  @override
  String get deleteAllTitle => 'Suprimeix tots els enregistraments';

  @override
  String get deleteAllConfirmTitle => 'Vols suprimir tots els enregistraments?';

  @override
  String get deleteAllConfirmBody =>
      'Totes les transcripcions i els enregistraments se suprimiran definitivament.';

  @override
  String get errorMicPermission =>
      'No hi ha accés al micròfon. Permet-lo a la configuració del mòbil.';

  @override
  String errorRecorderStart(String detail) {
    return 'No s\'ha pogut iniciar l\'enregistrament ($detail).';
  }

  @override
  String errorRecorderStop(String detail) {
    return 'No s\'ha pogut aturar l\'enregistrament ($detail).';
  }

  @override
  String errorTranscription(String detail) {
    return 'Ha fallat la transcripció ($detail). L\'enregistrament s\'ha desat i es pot tornar a transcriure.';
  }

  @override
  String errorRetranscribe(String detail) {
    return 'Ha fallat la nova transcripció ($detail).';
  }

  @override
  String errorModelLoad(String model, String detail) {
    return 'No s\'ha pogut carregar $model. Si continua passant, suprimeix el model i torna\'l a baixar. ($detail)';
  }

  @override
  String get errorNoModel => 'No hi ha cap model carregat.';

  @override
  String downloadAlreadyRunning(String model) {
    return '$model ja s\'està baixant.';
  }

  @override
  String get downloadCancelled => 'S\'ha cancel·lat la baixada.';

  @override
  String get downloadNetworkError =>
      'Ha fallat la baixada. Comprova la connexió a internet i torna-ho a provar.';

  @override
  String get downloadNotModelFile =>
      'El servidor no ha retornat cap fitxer de model (potser una pàgina d\'inici de sessió de la wifi). Comprova la xarxa i torna-ho a provar.';

  @override
  String downloadCorrupt(String file) {
    return 'El fitxer baixat $file està malmès. Torna-ho a provar.';
  }

  @override
  String downloadNoSpace(String model) {
    return 'No hi ha prou espai d\'emmagatzematge per a $model.';
  }
}
