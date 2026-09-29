// ignore: unused_import
import 'package:intl/intl.dart' as intl;

import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Spanish Castilian (`es`).
class AppLocalizationsEs extends AppLocalizations {
  AppLocalizationsEs([String locale = 'es']) : super(locale);

  @override
  String get logoSemantics => 'Logotipo de Talkpuppy';

  @override
  String startupFailed(String error) {
    return 'Talkpuppy no se pudo iniciar:\n$error';
  }

  @override
  String get settingsTooltip => 'Ajustes';

  @override
  String get switchModelTooltip => 'Cambiar modelo';

  @override
  String get manageModelsEllipsis => 'Gestionar modelos…';

  @override
  String get manageModels => 'Gestionar modelos';

  @override
  String get installModel => 'Instalar modelo';

  @override
  String get noModel => 'Sin modelo';

  @override
  String get ok => 'Aceptar';

  @override
  String get cancel => 'Cancelar';

  @override
  String get delete => 'Eliminar';

  @override
  String get copy => 'Copiar';

  @override
  String get record => 'Grabar';

  @override
  String get stopRecording => 'Detener';

  @override
  String get transcribing => 'Transcribiendo…';

  @override
  String get newRecording => 'Nueva grabación';

  @override
  String get continueRecording => 'Seguir grabando';

  @override
  String get transcriptLabel => 'Transcripción';

  @override
  String get emptyTranscript =>
      'Aún no hay grabaciones.\nToca el micrófono de abajo.';

  @override
  String get noTextRecognized => '(no se reconoció texto)';

  @override
  String get retranscribe => 'Volver a transcribir';

  @override
  String get today => 'Hoy';

  @override
  String get yesterday => 'Ayer';

  @override
  String get welcomeTitle => 'Te damos la bienvenida a Talkpuppy';

  @override
  String get welcomeBody =>
      'Elige un modelo de voz para la transcripción. Funciona completamente en tu dispositivo, sin necesidad de internet.';

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
  String get downloadAndStart => 'Descargar y empezar';

  @override
  String get download => 'Descargar';

  @override
  String downloadFailed(String error) {
    return 'Error en la descarga: $error';
  }

  @override
  String get modelsTitle => 'Modelos';

  @override
  String get deleteModelTitle => '¿Eliminar modelo?';

  @override
  String deleteModelBody(String model, int size) {
    return '$model se eliminará de este dispositivo ($size MB).';
  }

  @override
  String get modelDescParakeet =>
      'Muy preciso y rápido. El texto aparece al detener la grabación. 25 idiomas europeos, detectados automáticamente; no se puede fijar el idioma. Descarga grande, para móviles con al menos 6 GB de RAM.';

  @override
  String get modelDescWhisperSmall =>
      'El que más idiomas tiene (99), detectados automáticamente o fijados. Buena precisión, pero más lento que Parakeet, y con silencio o ruido a veces puede inventarse palabras. Para móviles con al menos 4 GB de RAM.';

  @override
  String get modelDescWhisperBase =>
      'Descarga pequeña para móviles antiguos. 99 idiomas, detectados automáticamente o fijados. Notablemente menos preciso que Whisper Small. Para móviles con al menos 3 GB de RAM.';

  @override
  String get modelDescWhisperTiny =>
      'El más pequeño y rápido, funciona en prácticamente cualquier móvil. 99 idiomas, detectados automáticamente o fijados. El menos preciso, ideal para notas cortas y bien pronunciadas.';

  @override
  String get modelDescNemotron =>
      'Vista previa en directo: el texto aparece mientras hablas y está listo en cuanto paras. 28 idiomas, detectados automáticamente o fijados. Normalmente algo menos preciso que Parakeet. Descarga grande, para móviles con al menos 6 GB de RAM.';

  @override
  String get livePreviewLabel => 'Vista previa en directo';

  @override
  String get livePreviewListening => 'Escuchando…';

  @override
  String get languageLabel => 'Idioma';

  @override
  String get auto => 'Auto';

  @override
  String get modelLabel => 'Modelo';

  @override
  String get whisperRequired =>
      'Para fijar un idioma necesitas un modelo Whisper o Nemotron.';

  @override
  String get downloadWhisperSmall => 'Descargar Whisper Small';

  @override
  String get settingsTitle => 'Ajustes';

  @override
  String get appLanguageTitle => 'Idioma de la app';

  @override
  String get appLanguageSystem => 'Predeterminado del sistema';

  @override
  String get autoCopyTitle => 'Copiar automáticamente';

  @override
  String get autoCopySubtitle =>
      'Copia el texto al portapapeles justo después de transcribir';

  @override
  String get hapticsTitle => 'Respuesta háptica';

  @override
  String get minimizeToOverlay => 'Minimizar y mostrar superposición';

  @override
  String get overlaySetupTitle => 'Activa el servicio de accesibilidad';

  @override
  String get overlaySetupBody =>
      'Para mostrar el botón sobre otras apps e insertar el texto en el cursor, Talkpuppy necesita su servicio de accesibilidad. Solo lee el campo en el que estás escribiendo, y solo para insertar el texto. No lee nada más de la pantalla, no guarda nada de otras apps y no envía nada a ningún sitio.\n\nEn la siguiente pantalla, abre «Talkpuppy» y actívalo.';

  @override
  String get overlaySetupShortcut =>
      'Activa solo el interruptor de Talkpuppy y deja «Acceso directo» desactivado: el botón aparece solo.';

  @override
  String get shortcutHint =>
      'El «Acceso directo» de Talkpuppy está activado, por eso Android fija el icono de la app en el borde de la pantalla. No lo necesitas: el botón flotante aparece solo. Desactiva el «Acceso directo» en los ajustes de accesibilidad de Talkpuppy.';

  @override
  String get shortcutHintAction => 'Abrir ajustes de Talkpuppy';

  @override
  String get overlayOpenAccessibility => 'Abrir ajustes de accesibilidad';

  @override
  String get overlayRestrictedHint =>
      '¿El interruptor está en gris? Abre Información de la aplicación → ⋮ → «Permitir ajustes restringidos» y vuelve a intentarlo.';

  @override
  String get defaultLanguageTitle =>
      'Idioma predeterminado para nuevas grabaciones';

  @override
  String get defaultLanguageHint =>
      'Lo usan Whisper y Nemotron; Parakeet siempre detecta el idioma automáticamente.';

  @override
  String get licensesTitle => 'Licencias';

  @override
  String get licensesSubtitle => 'Software y modelos utilizados';

  @override
  String get licensesLegalese =>
      'Reconocimiento de voz con sherpa-onnx, Parakeet (NVIDIA, CC BY 4.0), Nemotron (NVIDIA, OpenMDW 1.1) y Whisper (OpenAI, MIT).';

  @override
  String get licensesIntro =>
      'Talkpuppy se basa en software de código abierto y en modelos de voz con licencias abiertas.';

  @override
  String get licensesSpeechModels => 'Modelos de voz';

  @override
  String get licensesSoftware => 'Software';

  @override
  String get licensesPackages => 'Flutter y otros paquetes de código abierto';

  @override
  String get licensesShowAll => 'Mostrar todos los textos de licencia';

  @override
  String get deleteAllTitle => 'Eliminar todas las grabaciones';

  @override
  String get deleteAllConfirmTitle => '¿Eliminar todas las grabaciones?';

  @override
  String get deleteAllConfirmBody =>
      'Todas las transcripciones y grabaciones se eliminarán de forma permanente.';

  @override
  String get errorMicPermission =>
      'No hay acceso al micrófono. Permítelo en los ajustes de tu móvil.';

  @override
  String get errorMicBusy =>
      'El micrófono está en uso ahora mismo, por ejemplo por una llamada. Inténtalo de nuevo después de la llamada.';

  @override
  String errorRecorderStart(String detail) {
    return 'No se pudo iniciar la grabación ($detail).';
  }

  @override
  String errorRecorderStop(String detail) {
    return 'No se pudo detener la grabación ($detail).';
  }

  @override
  String errorTranscription(String detail) {
    return 'Error en la transcripción ($detail). La grabación está guardada y se puede volver a transcribir.';
  }

  @override
  String errorRetranscribe(String detail) {
    return 'Error al volver a transcribir ($detail).';
  }

  @override
  String errorModelLoad(String model, String detail) {
    return 'No se pudo cargar $model. Si vuelve a ocurrir, elimina el modelo y descárgalo de nuevo. ($detail)';
  }

  @override
  String get errorNoModel => 'No hay ningún modelo cargado.';

  @override
  String downloadAlreadyRunning(String model) {
    return '$model ya se está descargando.';
  }

  @override
  String get downloadCancelled => 'Descarga cancelada.';

  @override
  String get downloadNetworkError =>
      'Error en la descarga. Comprueba tu conexión a internet y vuelve a intentarlo.';

  @override
  String get downloadNotModelFile =>
      'El servidor no devolvió un archivo de modelo (quizá una página de inicio de sesión wifi). Comprueba tu red y vuelve a intentarlo.';

  @override
  String downloadCorrupt(String file) {
    return 'El archivo descargado $file está dañado. Vuelve a intentarlo.';
  }

  @override
  String downloadNoSpace(String model) {
    return 'No hay suficiente espacio para $model.';
  }
}
