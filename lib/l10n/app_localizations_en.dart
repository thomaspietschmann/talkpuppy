// ignore: unused_import
import 'package:intl/intl.dart' as intl;

import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get logoSemantics => 'Talkpuppy logo';

  @override
  String startupFailed(String error) {
    return 'Talkpuppy couldn\'t start:\n$error';
  }

  @override
  String get settingsTooltip => 'Settings';

  @override
  String get switchModelTooltip => 'Switch model';

  @override
  String get manageModelsEllipsis => 'Manage models…';

  @override
  String get manageModels => 'Manage models';

  @override
  String get installModel => 'Install model';

  @override
  String get noModel => 'No model';

  @override
  String get ok => 'OK';

  @override
  String get cancel => 'Cancel';

  @override
  String get delete => 'Delete';

  @override
  String get copy => 'Copy';

  @override
  String get record => 'Record';

  @override
  String get stopRecording => 'Stop';

  @override
  String get transcribing => 'Transcribing…';

  @override
  String get newRecording => 'New recording';

  @override
  String get continueRecording => 'Keep recording';

  @override
  String get transcriptLabel => 'Transcript';

  @override
  String get emptyTranscript => 'No recording yet.\nTap the microphone below.';

  @override
  String get noTextRecognized => '(no text recognized)';

  @override
  String get retranscribe => 'Re-transcribe';

  @override
  String get today => 'Today';

  @override
  String get yesterday => 'Yesterday';

  @override
  String get welcomeTitle => 'Welcome to Talkpuppy';

  @override
  String get welcomeBody =>
      'Choose a speech model for transcription. It runs entirely on your device, no internet needed.';

  @override
  String get recommended => 'Recommended';

  @override
  String get preparing => 'Preparing…';

  @override
  String sizeMb(int size) {
    return '$size MB';
  }

  @override
  String downloadProgress(int received, int total) {
    return '$received MB / $total MB';
  }

  @override
  String get downloadAndStart => 'Download and get started';

  @override
  String get download => 'Download';

  @override
  String downloadFailed(String error) {
    return 'Download failed: $error';
  }

  @override
  String get modelsTitle => 'Models';

  @override
  String get deleteModelTitle => 'Delete model?';

  @override
  String deleteModelBody(String model, int size) {
    return '$model will be deleted from this device ($size MB).';
  }

  @override
  String get modelDescParakeet =>
      'Very fast and very accurate, 25 European languages, detects the language automatically. Recommended for phones with at least 6 GB of RAM.';

  @override
  String get modelDescWhisperSmall =>
      'Balanced between speed and accuracy, 99 languages, language can be fixed. For phones with at least 4 GB of RAM.';

  @override
  String get modelDescWhisperBase =>
      'Lightweight for older phones, 99 languages, language can be fixed. For phones with at least 3 GB of RAM.';

  @override
  String get modelDescWhisperTiny =>
      'Minimal and fastest to download. 99 languages, language can be fixed. Runs on practically any phone.';

  @override
  String get languageLabel => 'Language';

  @override
  String get auto => 'Auto';

  @override
  String get modelLabel => 'Model';

  @override
  String get whisperRequired => 'A fixed language needs a Whisper model.';

  @override
  String get downloadWhisperSmall => 'Download Whisper Small';

  @override
  String get settingsTitle => 'Settings';

  @override
  String get appLanguageTitle => 'App language';

  @override
  String get appLanguageSystem => 'System default';

  @override
  String get autoCopyTitle => 'Copy automatically';

  @override
  String get autoCopySubtitle =>
      'Put the text on the clipboard right after transcription';

  @override
  String get hapticsTitle => 'Haptic feedback';

  @override
  String get defaultLanguageTitle => 'Default language for new recordings';

  @override
  String get defaultLanguageHint =>
      'Only Whisper models use this; Parakeet always detects the language automatically.';

  @override
  String get licensesTitle => 'Licenses';

  @override
  String get licensesSubtitle => 'Software and models used';

  @override
  String get licensesLegalese =>
      'Speech recognition with sherpa-onnx, Parakeet (NVIDIA, CC BY 4.0) and Whisper (OpenAI, MIT).';

  @override
  String get deleteAllTitle => 'Delete all recordings';

  @override
  String get deleteAllConfirmTitle => 'Delete all recordings?';

  @override
  String get deleteAllConfirmBody =>
      'All transcripts and recordings will be permanently deleted.';

  @override
  String get errorMicPermission =>
      'No microphone access. Please allow it in your phone\'s settings.';

  @override
  String errorRecorderStart(String detail) {
    return 'Couldn\'t start recording ($detail).';
  }

  @override
  String errorRecorderStop(String detail) {
    return 'Couldn\'t stop recording ($detail).';
  }

  @override
  String errorTranscription(String detail) {
    return 'Transcription failed ($detail). The recording is saved and can be re-transcribed.';
  }

  @override
  String errorRetranscribe(String detail) {
    return 'Re-transcription failed ($detail).';
  }

  @override
  String errorModelLoad(String model, String detail) {
    return '$model couldn\'t be loaded. If this keeps happening, delete the model and download it again. ($detail)';
  }

  @override
  String get errorNoModel => 'No model loaded.';

  @override
  String downloadAlreadyRunning(String model) {
    return '$model is already downloading.';
  }

  @override
  String get downloadCancelled => 'Download cancelled.';

  @override
  String get downloadNetworkError =>
      'Download failed. Please check your internet connection and try again.';

  @override
  String get downloadNotModelFile =>
      'The server didn\'t return a model file (maybe a Wi-Fi login page). Please check your network and try again.';

  @override
  String downloadCorrupt(String file) {
    return 'The downloaded file $file is corrupted. Please try again.';
  }

  @override
  String downloadNoSpace(String model) {
    return 'Not enough storage for $model.';
  }
}
