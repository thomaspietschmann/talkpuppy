// ignore: unused_import
import 'package:intl/intl.dart' as intl;

import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Italian (`it`).
class AppLocalizationsIt extends AppLocalizations {
  AppLocalizationsIt([String locale = 'it']) : super(locale);

  @override
  String get logoSemantics => 'Logo di Talkpuppy';

  @override
  String startupFailed(String error) {
    return 'Impossibile avviare Talkpuppy:\n$error';
  }

  @override
  String get settingsTooltip => 'Impostazioni';

  @override
  String get switchModelTooltip => 'Cambia modello';

  @override
  String get manageModelsEllipsis => 'Gestisci modelli…';

  @override
  String get manageModels => 'Gestisci modelli';

  @override
  String get installModel => 'Installa modello';

  @override
  String get noModel => 'Nessun modello';

  @override
  String get ok => 'OK';

  @override
  String get cancel => 'Annulla';

  @override
  String get delete => 'Elimina';

  @override
  String get copy => 'Copia';

  @override
  String get record => 'Registra';

  @override
  String get stopRecording => 'Interrompi';

  @override
  String get transcribing => 'Trascrizione…';

  @override
  String get newRecording => 'Nuova registrazione';

  @override
  String get continueRecording => 'Continua';

  @override
  String get transcriptLabel => 'Trascrizione';

  @override
  String get emptyTranscript =>
      'Ancora nessuna registrazione.\nTocca il microfono qui sotto.';

  @override
  String get noTextRecognized => '(nessun testo riconosciuto)';

  @override
  String get retranscribe => 'Ritrascrivi';

  @override
  String get today => 'Oggi';

  @override
  String get yesterday => 'Ieri';

  @override
  String get welcomeTitle => 'Ti diamo il benvenuto in Talkpuppy';

  @override
  String get welcomeBody =>
      'Scegli un modello vocale per la trascrizione. Funziona interamente sul tuo dispositivo, senza bisogno di internet.';

  @override
  String get recommended => 'Consigliato';

  @override
  String get preparing => 'Preparazione…';

  @override
  String sizeMb(int size) {
    return '$size MB';
  }

  @override
  String downloadProgress(int received, int total) {
    return '$received MB / $total MB';
  }

  @override
  String get downloadAndStart => 'Scarica e inizia';

  @override
  String get download => 'Scarica';

  @override
  String downloadFailed(String error) {
    return 'Download non riuscito: $error';
  }

  @override
  String get modelsTitle => 'Modelli';

  @override
  String get deleteModelTitle => 'Eliminare il modello?';

  @override
  String deleteModelBody(String model, int size) {
    return '$model verrà eliminato da questo dispositivo ($size MB).';
  }

  @override
  String get modelDescParakeet =>
      'Molto veloce e molto preciso, 25 lingue europee, rileva la lingua automaticamente. Consigliato per telefoni con almeno 6 GB di RAM.';

  @override
  String get modelDescWhisperSmall =>
      'Equilibrato tra velocità e precisione, 99 lingue, la lingua può essere fissata. Per telefoni con almeno 4 GB di RAM.';

  @override
  String get modelDescWhisperBase =>
      'Leggero per telefoni meno recenti, 99 lingue, la lingua può essere fissata. Per telefoni con almeno 3 GB di RAM.';

  @override
  String get modelDescWhisperTiny =>
      'Minimo e il più veloce da scaricare. 99 lingue, la lingua può essere fissata. Funziona praticamente su qualsiasi telefono.';

  @override
  String get languageLabel => 'Lingua';

  @override
  String get auto => 'Auto';

  @override
  String get modelLabel => 'Modello';

  @override
  String get whisperRequired =>
      'Per una lingua fissa serve un modello Whisper.';

  @override
  String get downloadWhisperSmall => 'Scarica Whisper Small';

  @override
  String get settingsTitle => 'Impostazioni';

  @override
  String get appLanguageTitle => 'Lingua dell\'app';

  @override
  String get appLanguageSystem => 'Predefinita di sistema';

  @override
  String get autoCopyTitle => 'Copia automatica';

  @override
  String get autoCopySubtitle =>
      'Copia il testo negli appunti subito dopo la trascrizione';

  @override
  String get hapticsTitle => 'Feedback aptico';

  @override
  String get defaultLanguageTitle =>
      'Lingua predefinita per le nuove registrazioni';

  @override
  String get defaultLanguageHint =>
      'Usata solo dai modelli Whisper; Parakeet rileva sempre la lingua automaticamente.';

  @override
  String get licensesTitle => 'Licenze';

  @override
  String get licensesSubtitle => 'Software e modelli utilizzati';

  @override
  String get licensesLegalese =>
      'Riconoscimento vocale con sherpa-onnx, Parakeet (NVIDIA, CC BY 4.0) e Whisper (OpenAI, MIT).';

  @override
  String get deleteAllTitle => 'Elimina tutte le registrazioni';

  @override
  String get deleteAllConfirmTitle => 'Eliminare tutte le registrazioni?';

  @override
  String get deleteAllConfirmBody =>
      'Tutte le trascrizioni e le registrazioni verranno eliminate definitivamente.';

  @override
  String get errorMicPermission =>
      'Nessun accesso al microfono. Consentilo nelle impostazioni del telefono.';

  @override
  String errorRecorderStart(String detail) {
    return 'Impossibile avviare la registrazione ($detail).';
  }

  @override
  String errorRecorderStop(String detail) {
    return 'Impossibile interrompere la registrazione ($detail).';
  }

  @override
  String errorTranscription(String detail) {
    return 'Trascrizione non riuscita ($detail). La registrazione è salvata e può essere ritrascritta.';
  }

  @override
  String errorRetranscribe(String detail) {
    return 'Nuova trascrizione non riuscita ($detail).';
  }

  @override
  String errorModelLoad(String model, String detail) {
    return 'Impossibile caricare $model. Se succede ancora, elimina il modello e scaricalo di nuovo. ($detail)';
  }

  @override
  String get errorNoModel => 'Nessun modello caricato.';

  @override
  String downloadAlreadyRunning(String model) {
    return 'Download di $model già in corso.';
  }

  @override
  String get downloadCancelled => 'Download annullato.';

  @override
  String get downloadNetworkError =>
      'Download non riuscito. Controlla la connessione a internet e riprova.';

  @override
  String get downloadNotModelFile =>
      'Il server non ha restituito un file del modello (forse una pagina di accesso Wi-Fi). Controlla la rete e riprova.';

  @override
  String downloadCorrupt(String file) {
    return 'Il file scaricato $file è danneggiato. Riprova.';
  }

  @override
  String downloadNoSpace(String model) {
    return 'Spazio di archiviazione insufficiente per $model.';
  }
}
