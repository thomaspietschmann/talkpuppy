// ignore: unused_import
import 'package:intl/intl.dart' as intl;

import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Luxembourgish Letzeburgesch (`lb`).
class AppLocalizationsLb extends AppLocalizations {
  AppLocalizationsLb([String locale = 'lb']) : super(locale);

  @override
  String get logoSemantics => 'Talkpuppy-Logo';

  @override
  String startupFailed(String error) {
    return 'Talkpuppy konnt net starten:\n$error';
  }

  @override
  String get settingsTooltip => 'Astellungen';

  @override
  String get switchModelTooltip => 'Modell wiesselen';

  @override
  String get manageModelsEllipsis => 'Modeller verwalten…';

  @override
  String get manageModels => 'Modeller verwalten';

  @override
  String get installModel => 'Modell installéieren';

  @override
  String get noModel => 'Kee Modell';

  @override
  String get ok => 'OK';

  @override
  String get cancel => 'Ofbriechen';

  @override
  String get delete => 'Läschen';

  @override
  String get copy => 'Kopéieren';

  @override
  String get record => 'Ophuelen';

  @override
  String get stopRecording => 'Stopp';

  @override
  String get transcribing => 'Gëtt transkribéiert…';

  @override
  String get newRecording => 'Nei Opnam';

  @override
  String get continueRecording => 'Weider ophuelen';

  @override
  String get transcriptLabel => 'Transkript';

  @override
  String get emptyTranscript => 'Nach keng Opnam.\nTipp ënnen op de Mikro.';

  @override
  String get noTextRecognized => '(keen Text erkannt)';

  @override
  String get retranscribe => 'Nei transkribéieren';

  @override
  String get today => 'Haut';

  @override
  String get yesterday => 'Gëschter';

  @override
  String get welcomeTitle => 'Wëllkomm bei Talkpuppy';

  @override
  String get welcomeBody =>
      'Wiel e Sproochmodell fir d\'Transkriptioun. En leeft komplett op dengem Apparat, ouni Internet.';

  @override
  String get recommended => 'Recommandéiert';

  @override
  String get preparing => 'Gëtt virbereet…';

  @override
  String sizeMb(int size) {
    return '$size MB';
  }

  @override
  String downloadProgress(int received, int total) {
    return '$received MB / $total MB';
  }

  @override
  String get downloadAndStart => 'Eroflueden a lassleeën';

  @override
  String get download => 'Eroflueden';

  @override
  String downloadFailed(String error) {
    return 'Eroflueden ass feelgeschloen: $error';
  }

  @override
  String get modelsTitle => 'Modeller';

  @override
  String get deleteModelTitle => 'Modell läschen?';

  @override
  String deleteModelBody(String model, int size) {
    return '$model gëtt vun dësem Apparat geläscht ($size MB).';
  }

  @override
  String get modelDescParakeet =>
      'Ganz séier a ganz präzis, 25 europäesch Sproochen, erkennt d\'Sprooch automatesch. Recommandéiert fir Handyen mat mindestens 6 GB RAM.';

  @override
  String get modelDescWhisperSmall =>
      'Ausgeglach tëscht Vitesse a Präzisioun, 99 Sproochen, d\'Sprooch ka festgeluecht ginn. Fir Handyen mat mindestens 4 GB RAM.';

  @override
  String get modelDescWhisperBase =>
      'Liicht fir méi al Handyen, 99 Sproochen, d\'Sprooch ka festgeluecht ginn. Fir Handyen mat mindestens 3 GB RAM.';

  @override
  String get modelDescWhisperTiny =>
      'Minimal an am séiersten erofgelueden. 99 Sproochen, d\'Sprooch ka festgeluecht ginn. Leeft op praktesch all Handy.';

  @override
  String get languageLabel => 'Sprooch';

  @override
  String get auto => 'Auto';

  @override
  String get modelLabel => 'Modell';

  @override
  String get whisperRequired =>
      'Fir eng fix Sprooch brauchs de e Whisper-Modell.';

  @override
  String get downloadWhisperSmall => 'Whisper Small eroflueden';

  @override
  String get settingsTitle => 'Astellungen';

  @override
  String get appLanguageTitle => 'App-Sprooch';

  @override
  String get appLanguageSystem => 'Systemstandard';

  @override
  String get autoCopyTitle => 'Automatesch kopéieren';

  @override
  String get autoCopySubtitle =>
      'Den Text direkt no der Transkriptioun an d\'Zwëschenoflag leeën';

  @override
  String get hapticsTitle => 'Haptesche Feedback';

  @override
  String get defaultLanguageTitle => 'Standardsprooch fir nei Opnamen';

  @override
  String get defaultLanguageHint =>
      'Gëtt nëmme vu Whisper-Modeller benotzt; Parakeet erkennt d\'Sprooch ëmmer automatesch.';

  @override
  String get licensesTitle => 'Lizenzen';

  @override
  String get licensesSubtitle => 'Benotzt Software a Modeller';

  @override
  String get licensesLegalese =>
      'Spriecherkennung mat sherpa-onnx, Parakeet (NVIDIA, CC BY 4.0) a Whisper (OpenAI, MIT).';

  @override
  String get deleteAllTitle => 'All Opnamen läschen';

  @override
  String get deleteAllConfirmTitle => 'All Opnamen läschen?';

  @override
  String get deleteAllConfirmBody =>
      'All Transkripter an Opnamen ginn definitiv geläscht.';

  @override
  String get errorMicPermission =>
      'Keen Zougrëff op de Mikro. Erlaab en an den Astellunge vun dengem Handy.';

  @override
  String errorRecorderStart(String detail) {
    return 'D\'Opnam konnt net gestart ginn ($detail).';
  }

  @override
  String errorRecorderStop(String detail) {
    return 'D\'Opnam konnt net gestoppt ginn ($detail).';
  }

  @override
  String errorTranscription(String detail) {
    return 'D\'Transkriptioun ass feelgeschloen ($detail). D\'Opnam ass gespäichert a ka nei transkribéiert ginn.';
  }

  @override
  String errorRetranscribe(String detail) {
    return 'Déi nei Transkriptioun ass feelgeschloen ($detail).';
  }

  @override
  String errorModelLoad(String model, String detail) {
    return '$model konnt net geluede ginn. Wann dat ëmmer erëm geschitt, läsch de Modell a lued en nei erof. ($detail)';
  }

  @override
  String get errorNoModel => 'Kee Modell gelueden.';

  @override
  String downloadAlreadyRunning(String model) {
    return '$model gëtt schonn erofgelueden.';
  }

  @override
  String get downloadCancelled => 'Eroflueden ofgebrach.';

  @override
  String get downloadNetworkError =>
      'Eroflueden ass feelgeschloen. Kontrolléier deng Internetverbindung a prouf nach eng Kéier.';

  @override
  String get downloadNotModelFile =>
      'De Server huet keng Modelldatei geschéckt (vläicht eng WLAN-Umeldungssäit). Kontrolléier däin Netzwierk a prouf nach eng Kéier.';

  @override
  String downloadCorrupt(String file) {
    return 'Déi erofgeluede Datei $file ass beschiedegt. Prouf nach eng Kéier.';
  }

  @override
  String downloadNoSpace(String model) {
    return 'Net genuch Späicher fir $model.';
  }
}
