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
      'Very accurate and fast. The text appears once you stop recording. 25 European languages, detected automatically; the language can\'t be fixed. Large download, for phones with at least 6 GB of RAM.';

  @override
  String get modelDescWhisperSmall =>
      'The most languages (99), detected automatically or fixed. Good accuracy, but slower than Parakeet, and on silence or noise it can occasionally make up words. For phones with at least 4 GB of RAM.';

  @override
  String get modelDescWhisperBase =>
      'Small download for older phones. 99 languages, detected automatically or fixed. Noticeably less accurate than Whisper Small. For phones with at least 3 GB of RAM.';

  @override
  String get modelDescWhisperTiny =>
      'Smallest and fastest, runs on practically any phone. 99 languages, detected automatically or fixed. Least accurate, best for short, clearly spoken notes.';

  @override
  String get modelDescNemotron =>
      'Live preview: the text appears while you speak and is ready as soon as you stop. 28 languages, detected automatically or fixed. Usually a little less accurate than Parakeet. Large download, for phones with at least 6 GB of RAM.';

  @override
  String get livePreviewLabel => 'Live preview';

  @override
  String get livePreviewListening => 'Listening…';

  @override
  String get languageLabel => 'Language';

  @override
  String get auto => 'Auto';

  @override
  String get modelLabel => 'Model';

  @override
  String get whisperRequired =>
      'A fixed language needs a Whisper or Nemotron model.';

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
  String get minimizeToOverlay => 'Minimize and show overlay';

  @override
  String get overlaySetupTitle => 'Turn on the accessibility service';

  @override
  String get overlaySetupBody =>
      'To show the button over other apps and insert the text at the cursor, Talkpuppy needs its accessibility service. It only reads the text field you\'re typing in, and only to insert the text. It doesn\'t read anything else on the screen, stores nothing from other apps and sends nothing anywhere.\n\nIn the next screen, open “Talkpuppy” and turn it on.';

  @override
  String get overlaySetupShortcut =>
      'Turn on only the Talkpuppy switch and leave “Shortcut” off: the button appears by itself.';

  @override
  String get shortcutHint =>
      'The Talkpuppy “Shortcut” is on, so Android pins the app icon to the edge of the screen. You don\'t need it: the floating button appears by itself. Turn off “Shortcut” in the Talkpuppy accessibility settings.';

  @override
  String get shortcutHintAction => 'Open Talkpuppy settings';

  @override
  String get overlayOpenAccessibility => 'Open accessibility settings';

  @override
  String get overlayRestrictedHint =>
      'Switch greyed out? Open App info → ⋮ → “Allow restricted settings”, then try again.';

  @override
  String get defaultLanguageTitle => 'Default language for new recordings';

  @override
  String get defaultLanguageHint =>
      'Used by Whisper and Nemotron; Parakeet always detects the language automatically.';

  @override
  String get licensesTitle => 'Licenses';

  @override
  String get licensesSubtitle => 'Software and models used';

  @override
  String get licensesLegalese =>
      'Speech recognition with sherpa-onnx, Parakeet (NVIDIA, CC BY 4.0), Nemotron (NVIDIA, OpenMDW 1.1) and Whisper (OpenAI, MIT).';

  @override
  String get licensesIntro =>
      'Talkpuppy is built on open-source software and openly licensed speech models.';

  @override
  String get licensesSpeechModels => 'Speech models';

  @override
  String get licensesSoftware => 'Software';

  @override
  String get licensesPackages => 'Flutter and other open-source packages';

  @override
  String get licensesShowAll => 'Show all license texts';

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
  String get errorMicBusy =>
      'The microphone is in use right now, for example by a phone call. Please try again after the call.';

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
