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
      'Très précis et rapide. Le texte s\'affiche dès que tu arrêtes l\'enregistrement. 25 langues européennes, détectées automatiquement ; la langue ne peut pas être fixée. Téléchargement volumineux, pour les téléphones avec au moins 6 GB de RAM.';

  @override
  String get modelDescWhisperSmall =>
      'Le plus de langues (99), détectées automatiquement ou fixées. Bonne précision, mais plus lent que Parakeet, et en cas de silence ou de bruit, il peut parfois inventer des mots. Pour les téléphones avec au moins 4 GB de RAM.';

  @override
  String get modelDescWhisperBase =>
      'Petit téléchargement pour les téléphones plus anciens. 99 langues, détectées automatiquement ou fixées. Nettement moins précis que Whisper Small. Pour les téléphones avec au moins 3 GB de RAM.';

  @override
  String get modelDescWhisperTiny =>
      'Le plus petit et le plus rapide, fonctionne sur pratiquement tous les téléphones. 99 langues, détectées automatiquement ou fixées. Le moins précis, idéal pour de courtes notes clairement prononcées.';

  @override
  String get modelDescNemotron =>
      'Aperçu en direct : le texte s\'affiche pendant que tu parles et est prêt dès que tu t\'arrêtes. 28 langues, détectées automatiquement ou fixées. En général un peu moins précis que Parakeet. Téléchargement volumineux, pour les téléphones avec au moins 6 GB de RAM.';

  @override
  String get livePreviewLabel => 'Aperçu en direct';

  @override
  String get livePreviewListening => 'À l\'écoute…';

  @override
  String get languageLabel => 'Langue';

  @override
  String get auto => 'Auto';

  @override
  String get modelLabel => 'Modèle';

  @override
  String get whisperRequired =>
      'Une langue fixe nécessite un modèle Whisper ou Nemotron.';

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
  String get minimizeToOverlay => 'Réduire et afficher la superposition';

  @override
  String get overlaySetupTitle => 'Active le service d\'accessibilité';

  @override
  String get overlaySetupBody =>
      'Pour afficher le bouton par-dessus les autres applis et insérer le texte au niveau du curseur, Talkpuppy a besoin de son service d\'accessibilité. Il ne lit que le champ où tu écris, et uniquement pour y insérer le texte. Il ne lit rien d\'autre à l\'écran, n\'enregistre rien des autres applis et n\'envoie rien nulle part.\n\nSur l\'écran suivant, ouvre « Talkpuppy » et active-le.';

  @override
  String get overlayOpenAccessibility =>
      'Ouvrir les paramètres d\'accessibilité';

  @override
  String get overlayRestrictedHint =>
      'Interrupteur grisé ? Ouvre Infos sur l\'appli → ⋮ → « Autoriser les paramètres restreints », puis réessaie.';

  @override
  String get defaultLanguageTitle =>
      'Langue par défaut des nouveaux enregistrements';

  @override
  String get defaultLanguageHint =>
      'Utilisée par Whisper et Nemotron ; Parakeet détecte toujours la langue automatiquement.';

  @override
  String get licensesTitle => 'Licences';

  @override
  String get licensesSubtitle => 'Logiciels et modèles utilisés';

  @override
  String get licensesLegalese =>
      'Reconnaissance vocale avec sherpa-onnx, Parakeet (NVIDIA, CC BY 4.0), Nemotron (NVIDIA, OpenMDW 1.1) et Whisper (OpenAI, MIT).';

  @override
  String get licensesIntro =>
      'Talkpuppy repose sur des logiciels open source et des modèles vocaux sous licence ouverte.';

  @override
  String get licensesSpeechModels => 'Modèles vocaux';

  @override
  String get licensesSoftware => 'Logiciels';

  @override
  String get licensesPackages => 'Flutter et d\'autres paquets open source';

  @override
  String get licensesShowAll => 'Afficher tous les textes de licence';

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
