// ignore: unused_import
import 'package:intl/intl.dart' as intl;

import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Portuguese (`pt`).
class AppLocalizationsPt extends AppLocalizations {
  AppLocalizationsPt([String locale = 'pt']) : super(locale);

  @override
  String get logoSemantics => 'Logótipo do Talkpuppy';

  @override
  String startupFailed(String error) {
    return 'Não foi possível iniciar o Talkpuppy:\n$error';
  }

  @override
  String get settingsTooltip => 'Definições';

  @override
  String get switchModelTooltip => 'Mudar de modelo';

  @override
  String get manageModelsEllipsis => 'Gerir modelos…';

  @override
  String get manageModels => 'Gerir modelos';

  @override
  String get installModel => 'Instalar modelo';

  @override
  String get noModel => 'Sem modelo';

  @override
  String get ok => 'OK';

  @override
  String get cancel => 'Cancelar';

  @override
  String get delete => 'Eliminar';

  @override
  String get copy => 'Copiar';

  @override
  String get record => 'Gravar';

  @override
  String get stopRecording => 'Parar';

  @override
  String get transcribing => 'A transcrever…';

  @override
  String get newRecording => 'Nova gravação';

  @override
  String get continueRecording => 'Continuar a gravar';

  @override
  String get transcriptLabel => 'Transcrição';

  @override
  String get emptyTranscript =>
      'Ainda não há gravações.\nToca no microfone abaixo.';

  @override
  String get noTextRecognized => '(nenhum texto reconhecido)';

  @override
  String get retranscribe => 'Transcrever de novo';

  @override
  String get today => 'Hoje';

  @override
  String get yesterday => 'Ontem';

  @override
  String get welcomeTitle => 'Boas-vindas ao Talkpuppy';

  @override
  String get welcomeBody =>
      'Escolhe um modelo de voz para a transcrição. Funciona totalmente no teu dispositivo, sem precisar de internet.';

  @override
  String get recommended => 'Recomendado';

  @override
  String get preparing => 'A preparar…';

  @override
  String sizeMb(int size) {
    return '$size MB';
  }

  @override
  String downloadProgress(int received, int total) {
    return '$received MB / $total MB';
  }

  @override
  String get downloadAndStart => 'Transferir e começar';

  @override
  String get download => 'Transferir';

  @override
  String downloadFailed(String error) {
    return 'Falha na transferência: $error';
  }

  @override
  String get modelsTitle => 'Modelos';

  @override
  String get deleteModelTitle => 'Eliminar modelo?';

  @override
  String deleteModelBody(String model, int size) {
    return '$model será eliminado deste dispositivo ($size MB).';
  }

  @override
  String get modelDescParakeet =>
      'Muito rápido e muito preciso, 25 idiomas europeus, deteta o idioma automaticamente. Recomendado para telemóveis com pelo menos 6 GB de RAM.';

  @override
  String get modelDescWhisperSmall =>
      'Equilíbrio entre velocidade e precisão, 99 idiomas, o idioma pode ser fixado. Para telemóveis com pelo menos 4 GB de RAM.';

  @override
  String get modelDescWhisperBase =>
      'Leve, para telemóveis mais antigos, 99 idiomas, o idioma pode ser fixado. Para telemóveis com pelo menos 3 GB de RAM.';

  @override
  String get modelDescWhisperTiny =>
      'Mínimo e o mais rápido a transferir. 99 idiomas, o idioma pode ser fixado. Funciona em praticamente qualquer telemóvel.';

  @override
  String get languageLabel => 'Idioma';

  @override
  String get auto => 'Auto';

  @override
  String get modelLabel => 'Modelo';

  @override
  String get whisperRequired =>
      'Para fixar um idioma, precisas de um modelo Whisper.';

  @override
  String get downloadWhisperSmall => 'Transferir Whisper Small';

  @override
  String get settingsTitle => 'Definições';

  @override
  String get appLanguageTitle => 'Idioma da app';

  @override
  String get appLanguageSystem => 'Predefinição do sistema';

  @override
  String get autoCopyTitle => 'Copiar automaticamente';

  @override
  String get autoCopySubtitle =>
      'Copiar o texto para a área de transferência logo após a transcrição';

  @override
  String get hapticsTitle => 'Resposta tátil';

  @override
  String get defaultLanguageTitle => 'Idioma predefinido para novas gravações';

  @override
  String get defaultLanguageHint =>
      'Só é usado pelos modelos Whisper; o Parakeet deteta sempre o idioma automaticamente.';

  @override
  String get licensesTitle => 'Licenças';

  @override
  String get licensesSubtitle => 'Software e modelos utilizados';

  @override
  String get licensesLegalese =>
      'Reconhecimento de voz com sherpa-onnx, Parakeet (NVIDIA, CC BY 4.0) e Whisper (OpenAI, MIT).';

  @override
  String get deleteAllTitle => 'Eliminar todas as gravações';

  @override
  String get deleteAllConfirmTitle => 'Eliminar todas as gravações?';

  @override
  String get deleteAllConfirmBody =>
      'Todas as transcrições e gravações serão eliminadas permanentemente.';

  @override
  String get errorMicPermission =>
      'Sem acesso ao microfone. Permite-o nas definições do telemóvel.';

  @override
  String errorRecorderStart(String detail) {
    return 'Não foi possível iniciar a gravação ($detail).';
  }

  @override
  String errorRecorderStop(String detail) {
    return 'Não foi possível parar a gravação ($detail).';
  }

  @override
  String errorTranscription(String detail) {
    return 'Falha na transcrição ($detail). A gravação foi guardada e pode ser transcrita de novo.';
  }

  @override
  String errorRetranscribe(String detail) {
    return 'Falha ao transcrever de novo ($detail).';
  }

  @override
  String errorModelLoad(String model, String detail) {
    return 'Não foi possível carregar $model. Se continuar a acontecer, elimina o modelo e transfere-o novamente. ($detail)';
  }

  @override
  String get errorNoModel => 'Nenhum modelo carregado.';

  @override
  String downloadAlreadyRunning(String model) {
    return '$model já está a ser transferido.';
  }

  @override
  String get downloadCancelled => 'Transferência cancelada.';

  @override
  String get downloadNetworkError =>
      'Falha na transferência. Verifica a tua ligação à internet e tenta novamente.';

  @override
  String get downloadNotModelFile =>
      'O servidor não devolveu um ficheiro de modelo (talvez uma página de início de sessão Wi-Fi). Verifica a tua rede e tenta novamente.';

  @override
  String downloadCorrupt(String file) {
    return 'O ficheiro transferido $file está danificado. Tenta novamente.';
  }

  @override
  String downloadNoSpace(String model) {
    return 'Sem espaço de armazenamento suficiente para $model.';
  }
}
