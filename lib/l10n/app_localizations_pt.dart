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
      'Muito preciso e rápido. O texto aparece quando paras a gravação. 25 idiomas europeus, detetados automaticamente; não é possível fixar o idioma. Transferência grande, para telemóveis com pelo menos 6 GB de RAM.';

  @override
  String get modelDescWhisperSmall =>
      'O que tem mais idiomas (99), detetados automaticamente ou fixados. Boa precisão, mas mais lento do que o Parakeet, e com silêncio ou ruído pode ocasionalmente inventar palavras. Para telemóveis com pelo menos 4 GB de RAM.';

  @override
  String get modelDescWhisperBase =>
      'Transferência pequena para telemóveis mais antigos. 99 idiomas, detetados automaticamente ou fixados. Visivelmente menos preciso do que o Whisper Small. Para telemóveis com pelo menos 3 GB de RAM.';

  @override
  String get modelDescWhisperTiny =>
      'O mais pequeno e rápido, funciona em praticamente qualquer telemóvel. 99 idiomas, detetados automaticamente ou fixados. O menos preciso, ideal para notas curtas e bem pronunciadas.';

  @override
  String get modelDescNemotron =>
      'Pré-visualização em direto: o texto aparece enquanto falas e fica pronto assim que paras. 28 idiomas, detetados automaticamente ou fixados. Normalmente um pouco menos preciso do que o Parakeet. Transferência grande, para telemóveis com pelo menos 6 GB de RAM.';

  @override
  String get livePreviewLabel => 'Pré-visualização em direto';

  @override
  String get livePreviewListening => 'A ouvir…';

  @override
  String get languageLabel => 'Idioma';

  @override
  String get auto => 'Auto';

  @override
  String get modelLabel => 'Modelo';

  @override
  String get whisperRequired =>
      'Para fixar um idioma, precisas de um modelo Whisper ou Nemotron.';

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
  String get minimizeToOverlay => 'Minimizar e mostrar sobreposição';

  @override
  String get overlaySetupTitle => 'Ativa o serviço de acessibilidade';

  @override
  String get overlaySetupBody =>
      'Para mostrar o botão sobre outras apps e inserir o texto no cursor, o Talkpuppy precisa do seu serviço de acessibilidade. Só lê o campo em que estás a escrever, e só para inserir o texto. Não lê mais nada no ecrã, não guarda nada de outras apps e não envia nada para lado nenhum.\n\nNo ecrã seguinte, abre «Talkpuppy» e ativa-o.';

  @override
  String get overlaySetupShortcut =>
      'Ativa apenas o interruptor do Talkpuppy e deixa o «Atalho» desativado: o botão aparece sozinho.';

  @override
  String get shortcutHint =>
      'O «Atalho» do Talkpuppy está ativado, por isso o Android fixa o ícone da app na margem do ecrã. Não precisas dele: o botão flutuante aparece sozinho. Desativa o «Atalho» nas definições de acessibilidade do Talkpuppy.';

  @override
  String get shortcutHintAction => 'Abrir definições do Talkpuppy';

  @override
  String get overlayOpenAccessibility => 'Abrir definições de acessibilidade';

  @override
  String get overlayRestrictedHint =>
      'O interruptor está a cinzento? Abre Informações da app → ⋮ → «Permitir definições restritas» e tenta novamente.';

  @override
  String get defaultLanguageTitle => 'Idioma predefinido para novas gravações';

  @override
  String get defaultLanguageHint =>
      'É usado pelo Whisper e pelo Nemotron; o Parakeet deteta sempre o idioma automaticamente.';

  @override
  String get licensesTitle => 'Licenças';

  @override
  String get licensesSubtitle => 'Software e modelos utilizados';

  @override
  String get licensesLegalese =>
      'Reconhecimento de voz com sherpa-onnx, Parakeet (NVIDIA, CC BY 4.0), Nemotron (NVIDIA, OpenMDW 1.1) e Whisper (OpenAI, MIT).';

  @override
  String get licensesIntro =>
      'O Talkpuppy assenta em software de código aberto e em modelos de voz com licenças abertas.';

  @override
  String get licensesSpeechModels => 'Modelos de voz';

  @override
  String get licensesSoftware => 'Software';

  @override
  String get licensesPackages => 'Flutter e outros pacotes de código aberto';

  @override
  String get licensesShowAll => 'Mostrar todos os textos de licença';

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
  String get errorMicBusy =>
      'O microfone está a ser usado neste momento, por exemplo por uma chamada. Tenta novamente depois da chamada.';

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
