// ignore: unused_import
import 'package:intl/intl.dart' as intl;

import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for French (`fr`).
class AppLocalizationsFr extends AppLocalizations {
  AppLocalizationsFr([String locale = 'fr']) : super(locale);

  @override
  String get logoSemantics => 'Logo Talkpuppy';

  @override
  String startupFailed(String error) {
    return 'Talkpuppy n\'a pas pu démarrer :\n$error';
  }

  @override
  String get settingsTooltip => 'Paramètres';

  @override
  String get switchModelTooltip => 'Changer de modèle';

  @override
  String get manageModelsEllipsis => 'Gérer les modèles…';

  @override
  String get manageModels => 'Gérer les modèles';

  @override
  String get installModel => 'Installer un modèle';

  @override
  String get noModel => 'Aucun modèle';

  @override
  String get ok => 'OK';

  @override
  String get cancel => 'Annuler';

  @override
  String get delete => 'Supprimer';

  @override
  String get copy => 'Copier';

  @override
  String get record => 'Enregistrer';

  @override
  String get stopRecording => 'Arrêter';

  @override
  String get transcribing => 'Transcription…';

  @override
  String get newRecording => 'Nouvel enregistrement';

  @override
  String get continueRecording => 'Continuer';

  @override
  String get transcriptLabel => 'Transcription';

  @override
  String get emptyTranscript =>
      'Aucun enregistrement pour l\'instant.\nAppuie sur le micro ci-dessous.';

  @override
  String get noTextRecognized => '(aucun texte reconnu)';

  @override
  String get retranscribe => 'Retranscrire';

  @override
  String get today => 'Aujourd\'hui';

  @override
  String get yesterday => 'Hier';

  @override
  String get welcomeTitle => 'Bienvenue dans Talkpuppy';

  @override
  String get welcomeBody =>
      'Choisis un modèle vocal pour la transcription. Il fonctionne entièrement sur ton appareil, sans connexion Internet.';

  @override
  String get recommended => 'Recommandé';

  @override
  String get preparing => 'Préparation…';

  @override
  String sizeMb(int size) {
    return '$size MB';
  }

  @override
  String downloadProgress(int received, int total) {
    return '$received MB / $total MB';
  }

  @override
  String get downloadAndStart => 'Télécharger et commencer';

  @override
  String get download => 'Télécharger';

  @override
  String downloadFailed(String error) {
    return 'Échec du téléchargement : $error';
  }

  @override
  String get modelsTitle => 'Modèles';

  @override
  String get deleteModelTitle => 'Supprimer le modèle ?';

  @override
  String deleteModelBody(String model, int size) {
    return '$model sera supprimé de cet appareil ($size MB).';
  }

  @override
  String get modelDescParakeet =>
      'Très rapide et très précis, 25 langues européennes, détecte la langue automatiquement. Recommandé pour les téléphones avec au moins 6 GB de RAM.';

  @override
  String get modelDescWhisperSmall =>
      'Bon équilibre entre vitesse et précision, 99 langues, la langue peut être fixée. Pour les téléphones avec au moins 4 GB de RAM.';

  @override
  String get modelDescWhisperBase =>
      'Léger, pour les téléphones plus anciens, 99 langues, la langue peut être fixée. Pour les téléphones avec au moins 3 GB de RAM.';

  @override
  String get modelDescWhisperTiny =>
      'Minimal et le plus rapide à télécharger. 99 langues, la langue peut être fixée. Fonctionne sur pratiquement tous les téléphones.';

  @override
  String get languageLabel => 'Langue';

  @override
  String get auto => 'Auto';

  @override
  String get modelLabel => 'Modèle';

  @override
  String get whisperRequired => 'Une langue fixe nécessite un modèle Whisper.';

  @override
  String get downloadWhisperSmall => 'Télécharger Whisper Small';

  @override
  String get settingsTitle => 'Paramètres';

  @override
  String get appLanguageTitle => 'Langue de l\'app';

  @override
  String get appLanguageSystem => 'Langue du système';

  @override
  String get autoCopyTitle => 'Copie automatique';

  @override
  String get autoCopySubtitle =>
      'Copier le texte dans le presse-papiers juste après la transcription';

  @override
  String get hapticsTitle => 'Retour haptique';

  @override
  String get defaultLanguageTitle =>
      'Langue par défaut des nouveaux enregistrements';

  @override
  String get defaultLanguageHint =>
      'Utilisée uniquement par les modèles Whisper ; Parakeet détecte toujours la langue automatiquement.';

  @override
  String get licensesTitle => 'Licences';

  @override
  String get licensesSubtitle => 'Logiciels et modèles utilisés';

  @override
  String get licensesLegalese =>
      'Reconnaissance vocale avec sherpa-onnx, Parakeet (NVIDIA, CC BY 4.0) et Whisper (OpenAI, MIT).';

  @override
  String get deleteAllTitle => 'Supprimer tous les enregistrements';

  @override
  String get deleteAllConfirmTitle => 'Supprimer tous les enregistrements ?';

  @override
  String get deleteAllConfirmBody =>
      'Toutes les transcriptions et tous les enregistrements seront définitivement supprimés.';

  @override
  String get errorMicPermission =>
      'Pas d\'accès au micro. Autorise-le dans les paramètres de ton téléphone.';

  @override
  String errorRecorderStart(String detail) {
    return 'Impossible de démarrer l\'enregistrement ($detail).';
  }

  @override
  String errorRecorderStop(String detail) {
    return 'Impossible d\'arrêter l\'enregistrement ($detail).';
  }

  @override
  String errorTranscription(String detail) {
    return 'Échec de la transcription ($detail). L\'enregistrement est sauvegardé et peut être retranscrit.';
  }

  @override
  String errorRetranscribe(String detail) {
    return 'Échec de la retranscription ($detail).';
  }

  @override
  String errorModelLoad(String model, String detail) {
    return 'Impossible de charger $model. Si le problème persiste, supprime le modèle et télécharge-le à nouveau. ($detail)';
  }

  @override
  String get errorNoModel => 'Aucun modèle chargé.';

  @override
  String downloadAlreadyRunning(String model) {
    return '$model est déjà en cours de téléchargement.';
  }

  @override
  String get downloadCancelled => 'Téléchargement annulé.';

  @override
  String get downloadNetworkError =>
      'Échec du téléchargement. Vérifie ta connexion Internet et réessaie.';

  @override
  String get downloadNotModelFile =>
      'Le serveur n\'a pas renvoyé de fichier de modèle (peut-être une page de connexion Wi-Fi). Vérifie ton réseau et réessaie.';

  @override
  String downloadCorrupt(String file) {
    return 'Le fichier téléchargé $file est corrompu. Réessaie.';
  }

  @override
  String downloadNoSpace(String model) {
    return 'Espace de stockage insuffisant pour $model.';
  }
}
