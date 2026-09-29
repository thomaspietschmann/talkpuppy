// ignore: unused_import
import 'package:intl/intl.dart' as intl;

import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Galician (`gl`).
class AppLocalizationsGl extends AppLocalizations {
  AppLocalizationsGl([String locale = 'gl']) : super(locale);

  @override
  String get logoSemantics => 'Logotipo de Talkpuppy';

  @override
  String startupFailed(String error) {
    return 'Non se puido iniciar Talkpuppy:\n$error';
  }

  @override
  String get settingsTooltip => 'Configuración';

  @override
  String get switchModelTooltip => 'Cambiar de modelo';

  @override
  String get manageModelsEllipsis => 'Xestionar modelos…';

  @override
  String get manageModels => 'Xestionar modelos';

  @override
  String get installModel => 'Instalar modelo';

  @override
  String get noModel => 'Sen modelo';

  @override
  String get ok => 'Aceptar';

  @override
  String get cancel => 'Cancelar';

  @override
  String get delete => 'Eliminar';

  @override
  String get copy => 'Copiar';

  @override
  String get record => 'Gravar';

  @override
  String get stopRecording => 'Deter';

  @override
  String get transcribing => 'Transcribindo…';

  @override
  String get newRecording => 'Nova gravación';

  @override
  String get continueRecording => 'Seguir gravando';

  @override
  String get transcriptLabel => 'Transcrición';

  @override
  String get emptyTranscript =>
      'Aínda non hai gravacións.\nToca o micrófono de abaixo.';

  @override
  String get noTextRecognized => '(non se recoñeceu texto)';

  @override
  String get retranscribe => 'Volver transcribir';

  @override
  String get today => 'Hoxe';

  @override
  String get yesterday => 'Onte';

  @override
  String get welcomeTitle => 'Dámosche a benvida a Talkpuppy';

  @override
  String get welcomeBody =>
      'Escolle un modelo de voz para a transcrición. Funciona completamente no teu dispositivo, sen necesidade de internet.';

  @override
  String get recommended => 'Recomendado';

  @override
  String get preparing => 'Preparando…';

  @override
  String sizeMb(int size) {
    return '$size MB';
  }

  @override
  String downloadProgress(int received, int total) {
    return '$received MB / $total MB';
  }

  @override
  String get downloadAndStart => 'Descargar e comezar';

  @override
  String get download => 'Descargar';

  @override
  String downloadFailed(String error) {
    return 'Erro na descarga: $error';
  }

  @override
  String get modelsTitle => 'Modelos';

  @override
  String get deleteModelTitle => 'Queres eliminar o modelo?';

  @override
  String deleteModelBody(String model, int size) {
    return '$model eliminarase deste dispositivo ($size MB).';
  }

  @override
  String get modelDescParakeet =>
      'Moi preciso e rápido. O texto aparece cando detés a gravación. 25 idiomas europeos, detectados automaticamente; non se pode fixar o idioma. Descarga grande, para móbiles con polo menos 6 GB de RAM.';

  @override
  String get modelDescWhisperSmall =>
      'O que máis idiomas ten (99), detectados automaticamente ou fixados. Boa precisión, pero máis lento ca Parakeet, e con silencio ou ruído ás veces pode inventar palabras. Para móbiles con polo menos 4 GB de RAM.';

  @override
  String get modelDescWhisperBase =>
      'Descarga pequena para móbiles antigos. 99 idiomas, detectados automaticamente ou fixados. Notablemente menos preciso ca Whisper Small. Para móbiles con polo menos 3 GB de RAM.';

  @override
  String get modelDescWhisperTiny =>
      'O máis pequeno e rápido, funciona en practicamente calquera móbil. 99 idiomas, detectados automaticamente ou fixados. O menos preciso, ideal para notas curtas e ben pronunciadas.';

  @override
  String get modelDescNemotron =>
      'Vista previa en directo: o texto aparece mentres falas e está listo en canto paras. 28 idiomas, detectados automaticamente ou fixados. Normalmente algo menos preciso ca Parakeet. Descarga grande, para móbiles con polo menos 6 GB de RAM.';

  @override
  String get livePreviewLabel => 'Vista previa en directo';

  @override
  String get livePreviewListening => 'Escoitando…';

  @override
  String get languageLabel => 'Idioma';

  @override
  String get auto => 'Auto';

  @override
  String get modelLabel => 'Modelo';

  @override
  String get whisperRequired =>
      'Para fixar un idioma necesitas un modelo Whisper ou Nemotron.';

  @override
  String get downloadWhisperSmall => 'Descargar Whisper Small';

  @override
  String get settingsTitle => 'Configuración';

  @override
  String get appLanguageTitle => 'Idioma da app';

  @override
  String get appLanguageSystem => 'Predeterminado do sistema';

  @override
  String get autoCopyTitle => 'Copiar automaticamente';

  @override
  String get autoCopySubtitle =>
      'Copia o texto no portapapeis xusto despois da transcrición';

  @override
  String get hapticsTitle => 'Resposta háptica';

  @override
  String get defaultLanguageTitle =>
      'Idioma predeterminado para novas gravacións';

  @override
  String get defaultLanguageHint =>
      'Úsano Whisper e Nemotron; Parakeet sempre detecta o idioma automaticamente.';

  @override
  String get licensesTitle => 'Licenzas';

  @override
  String get licensesSubtitle => 'Software e modelos utilizados';

  @override
  String get licensesLegalese =>
      'Recoñecemento de voz con sherpa-onnx, Parakeet (NVIDIA, CC BY 4.0), Nemotron (NVIDIA, OpenMDW 1.1) e Whisper (OpenAI, MIT).';

  @override
  String get licensesIntro =>
      'Talkpuppy baséase en software de código aberto e en modelos de voz con licenzas abertas.';

  @override
  String get licensesSpeechModels => 'Modelos de voz';

  @override
  String get licensesSoftware => 'Software';

  @override
  String get licensesPackages => 'Flutter e outros paquetes de código aberto';

  @override
  String get licensesShowAll => 'Amosar todos os textos de licenza';

  @override
  String get deleteAllTitle => 'Eliminar todas as gravacións';

  @override
  String get deleteAllConfirmTitle => 'Queres eliminar todas as gravacións?';

  @override
  String get deleteAllConfirmBody =>
      'Todas as transcricións e gravacións eliminaranse definitivamente.';

  @override
  String get errorMicPermission =>
      'Non hai acceso ao micrófono. Permíteo na configuración do teu móbil.';

  @override
  String errorRecorderStart(String detail) {
    return 'Non se puido iniciar a gravación ($detail).';
  }

  @override
  String errorRecorderStop(String detail) {
    return 'Non se puido deter a gravación ($detail).';
  }

  @override
  String errorTranscription(String detail) {
    return 'Fallou a transcrición ($detail). A gravación está gardada e pódese volver transcribir.';
  }

  @override
  String errorRetranscribe(String detail) {
    return 'Fallou a nova transcrición ($detail).';
  }

  @override
  String errorModelLoad(String model, String detail) {
    return 'Non se puido cargar $model. Se segue pasando, elimina o modelo e descárgao de novo. ($detail)';
  }

  @override
  String get errorNoModel => 'Non hai ningún modelo cargado.';

  @override
  String downloadAlreadyRunning(String model) {
    return '$model xa se está descargando.';
  }

  @override
  String get downloadCancelled => 'Descarga cancelada.';

  @override
  String get downloadNetworkError =>
      'Fallou a descarga. Comproba a túa conexión a internet e téntao de novo.';

  @override
  String get downloadNotModelFile =>
      'O servidor non devolveu un ficheiro de modelo (quizais unha páxina de inicio de sesión wifi). Comproba a túa rede e téntao de novo.';

  @override
  String downloadCorrupt(String file) {
    return 'O ficheiro descargado $file está danado. Téntao de novo.';
  }

  @override
  String downloadNoSpace(String model) {
    return 'Non hai espazo suficiente para $model.';
  }
}
