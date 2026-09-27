// ignore: unused_import
import 'package:intl/intl.dart' as intl;

import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for German (`de`).
class AppLocalizationsDe extends AppLocalizations {
  AppLocalizationsDe([String locale = 'de']) : super(locale);

  @override
  String get logoSemantics => 'Talkpuppy-Logo';

  @override
  String startupFailed(String error) {
    return 'Talkpuppy konnte nicht starten:\n$error';
  }

  @override
  String get settingsTooltip => 'Einstellungen';

  @override
  String get switchModelTooltip => 'Modell wechseln';

  @override
  String get manageModelsEllipsis => 'Modelle verwalten…';

  @override
  String get manageModels => 'Modelle verwalten';

  @override
  String get installModel => 'Modell installieren';

  @override
  String get noModel => 'Kein Modell';

  @override
  String get ok => 'OK';

  @override
  String get cancel => 'Abbrechen';

  @override
  String get delete => 'Löschen';

  @override
  String get copy => 'Kopieren';

  @override
  String get record => 'Aufnehmen';

  @override
  String get stopRecording => 'Stopp';

  @override
  String get transcribing => 'Transkribiere…';

  @override
  String get newRecording => 'Neue Aufnahme';

  @override
  String get continueRecording => 'Weiter aufnehmen';

  @override
  String get transcriptLabel => 'Transkript';

  @override
  String get emptyTranscript =>
      'Noch keine Aufnahme.\nTippe unten auf das Mikrofon.';

  @override
  String get noTextRecognized => '(kein Text erkannt)';

  @override
  String get retranscribe => 'Neu transkribieren';

  @override
  String get today => 'Heute';

  @override
  String get yesterday => 'Gestern';

  @override
  String get welcomeTitle => 'Willkommen bei Talkpuppy';

  @override
  String get welcomeBody =>
      'Wähle ein Sprachmodell für die Transkription. Es läuft komplett auf deinem Gerät, ganz ohne Internet.';

  @override
  String get recommended => 'Empfohlen';

  @override
  String get preparing => 'Wird vorbereitet…';

  @override
  String sizeMb(int size) {
    return '$size MB';
  }

  @override
  String downloadProgress(int received, int total) {
    return '$received MB / $total MB';
  }

  @override
  String get downloadAndStart => 'Herunterladen und loslegen';

  @override
  String get download => 'Herunterladen';

  @override
  String downloadFailed(String error) {
    return 'Download fehlgeschlagen: $error';
  }

  @override
  String get modelsTitle => 'Modelle';

  @override
  String get deleteModelTitle => 'Modell löschen?';

  @override
  String deleteModelBody(String model, int size) {
    return '$model wird von diesem Gerät gelöscht ($size MB).';
  }

  @override
  String get modelDescParakeet =>
      'Sehr schnell und sehr genau, 25 europäische Sprachen, erkennt die Sprache automatisch. Empfohlen für Handys mit mindestens 6 GB RAM.';

  @override
  String get modelDescWhisperSmall =>
      'Ausgewogen zwischen Geschwindigkeit und Genauigkeit, 99 Sprachen, Sprache kann festgelegt werden. Für Handys mit mindestens 4 GB RAM.';

  @override
  String get modelDescWhisperBase =>
      'Leichtgewichtig für ältere Handys, 99 Sprachen, Sprache kann festgelegt werden. Für Handys mit mindestens 3 GB RAM.';

  @override
  String get modelDescWhisperTiny =>
      'Minimal und am schnellsten heruntergeladen. 99 Sprachen, Sprache kann festgelegt werden. Läuft auf praktisch jedem Handy.';

  @override
  String get languageLabel => 'Sprache';

  @override
  String get auto => 'Auto';

  @override
  String get modelLabel => 'Modell';

  @override
  String get whisperRequired =>
      'Für eine feste Sprache brauchst du ein Whisper-Modell.';

  @override
  String get downloadWhisperSmall => 'Whisper Small herunterladen';

  @override
  String get settingsTitle => 'Einstellungen';

  @override
  String get appLanguageTitle => 'App-Sprache';

  @override
  String get appLanguageSystem => 'Systemstandard';

  @override
  String get autoCopyTitle => 'Automatisch kopieren';

  @override
  String get autoCopySubtitle =>
      'Text direkt nach der Transkription in die Zwischenablage legen';

  @override
  String get hapticsTitle => 'Haptisches Feedback';

  @override
  String get defaultLanguageTitle => 'Standardsprache für neue Aufnahmen';

  @override
  String get defaultLanguageHint =>
      'Wird nur von Whisper-Modellen genutzt; Parakeet erkennt die Sprache immer automatisch.';

  @override
  String get licensesTitle => 'Lizenzen';

  @override
  String get licensesSubtitle => 'Verwendete Software und Modelle';

  @override
  String get licensesLegalese =>
      'Spracherkennung mit sherpa-onnx, Parakeet (NVIDIA, CC BY 4.0) und Whisper (OpenAI, MIT).';

  @override
  String get deleteAllTitle => 'Alle Aufnahmen löschen';

  @override
  String get deleteAllConfirmTitle => 'Alle Aufnahmen löschen?';

  @override
  String get deleteAllConfirmBody =>
      'Alle Transkripte und Aufnahmen werden endgültig gelöscht.';

  @override
  String get errorMicPermission =>
      'Kein Zugriff aufs Mikrofon. Bitte erlaube ihn in den Einstellungen deines Handys.';

  @override
  String errorRecorderStart(String detail) {
    return 'Aufnahme konnte nicht gestartet werden ($detail).';
  }

  @override
  String errorRecorderStop(String detail) {
    return 'Aufnahme konnte nicht beendet werden ($detail).';
  }

  @override
  String errorTranscription(String detail) {
    return 'Transkription fehlgeschlagen ($detail). Die Aufnahme ist gespeichert und kann neu transkribiert werden.';
  }

  @override
  String errorRetranscribe(String detail) {
    return 'Neue Transkription fehlgeschlagen ($detail).';
  }

  @override
  String errorModelLoad(String model, String detail) {
    return '$model konnte nicht geladen werden. Wenn das öfter passiert, lösche das Modell und lade es neu herunter. ($detail)';
  }

  @override
  String get errorNoModel => 'Kein Modell geladen.';

  @override
  String downloadAlreadyRunning(String model) {
    return '$model wird bereits heruntergeladen.';
  }

  @override
  String get downloadCancelled => 'Download abgebrochen.';

  @override
  String get downloadNetworkError =>
      'Download fehlgeschlagen. Bitte prüfe deine Internetverbindung und versuche es erneut.';

  @override
  String get downloadNotModelFile =>
      'Der Server hat keine Modelldatei geliefert (vielleicht eine WLAN-Anmeldeseite). Bitte prüfe dein Netzwerk und versuche es erneut.';

  @override
  String downloadCorrupt(String file) {
    return 'Die heruntergeladene Datei $file ist beschädigt. Bitte versuche es erneut.';
  }

  @override
  String downloadNoSpace(String model) {
    return 'Nicht genug Speicherplatz für $model.';
  }
}
