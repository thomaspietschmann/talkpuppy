// ignore: unused_import
import 'package:intl/intl.dart' as intl;

import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Lithuanian (`lt`).
class AppLocalizationsLt extends AppLocalizations {
  AppLocalizationsLt([String locale = 'lt']) : super(locale);

  @override
  String get logoSemantics => 'Talkpuppy logotipas';

  @override
  String startupFailed(String error) {
    return 'Nepavyko paleisti Talkpuppy:\n$error';
  }

  @override
  String get settingsTooltip => 'Nustatymai';

  @override
  String get switchModelTooltip => 'Keisti modelį';

  @override
  String get manageModelsEllipsis => 'Tvarkyti modelius…';

  @override
  String get manageModels => 'Tvarkyti modelius';

  @override
  String get installModel => 'Įdiegti modelį';

  @override
  String get noModel => 'Nėra modelio';

  @override
  String get ok => 'Gerai';

  @override
  String get cancel => 'Atšaukti';

  @override
  String get delete => 'Ištrinti';

  @override
  String get copy => 'Kopijuoti';

  @override
  String get record => 'Įrašyti';

  @override
  String get stopRecording => 'Stabdyti';

  @override
  String get transcribing => 'Transkribuojama…';

  @override
  String get newRecording => 'Naujas įrašas';

  @override
  String get continueRecording => 'Tęsti įrašą';

  @override
  String get transcriptLabel => 'Tekstas';

  @override
  String get emptyTranscript => 'Įrašų dar nėra.\nPaliesk mikrofoną apačioje.';

  @override
  String get noTextRecognized => '(tekstas neatpažintas)';

  @override
  String get retranscribe => 'Atpažinti iš naujo';

  @override
  String get today => 'Šiandien';

  @override
  String get yesterday => 'Vakar';

  @override
  String get welcomeTitle => 'Sveiki atvykę į Talkpuppy';

  @override
  String get welcomeBody =>
      'Pasirink kalbos modelį transkripcijai. Jis veikia tik tavo įrenginyje, internetas nereikalingas.';

  @override
  String get recommended => 'Rekomenduojama';

  @override
  String get preparing => 'Ruošiama…';

  @override
  String sizeMb(int size) {
    return '$size MB';
  }

  @override
  String downloadProgress(int received, int total) {
    return '$received MB / $total MB';
  }

  @override
  String get downloadAndStart => 'Atsisiųsti ir pradėti';

  @override
  String get download => 'Atsisiųsti';

  @override
  String downloadFailed(String error) {
    return 'Atsisiųsti nepavyko: $error';
  }

  @override
  String get modelsTitle => 'Modeliai';

  @override
  String get deleteModelTitle => 'Ištrinti modelį?';

  @override
  String deleteModelBody(String model, int size) {
    return '$model bus ištrintas iš šio įrenginio ($size MB).';
  }

  @override
  String get modelDescParakeet =>
      'Labai greitas ir labai tikslus, 25 Europos kalbos, kalbą atpažįsta automatiškai. Rekomenduojamas telefonams su bent 6 GB RAM.';

  @override
  String get modelDescWhisperSmall =>
      'Greičio ir tikslumo pusiausvyra, 99 kalbos, kalbą galima nustatyti. Telefonams su bent 4 GB RAM.';

  @override
  String get modelDescWhisperBase =>
      'Lengvas modelis senesniems telefonams, 99 kalbos, kalbą galima nustatyti. Telefonams su bent 3 GB RAM.';

  @override
  String get modelDescWhisperTiny =>
      'Mažiausias ir greičiausiai atsisiunčiamas. 99 kalbos, kalbą galima nustatyti. Veikia beveik bet kuriame telefone.';

  @override
  String get languageLabel => 'Kalba';

  @override
  String get auto => 'Automatiškai';

  @override
  String get modelLabel => 'Modelis';

  @override
  String get whisperRequired => 'Fiksuotai kalbai reikia Whisper modelio.';

  @override
  String get downloadWhisperSmall => 'Atsisiųsti Whisper Small';

  @override
  String get settingsTitle => 'Nustatymai';

  @override
  String get appLanguageTitle => 'Programos kalba';

  @override
  String get appLanguageSystem => 'Sistemos numatytoji';

  @override
  String get autoCopyTitle => 'Kopijuoti automatiškai';

  @override
  String get autoCopySubtitle =>
      'Iškart po transkripcijos nukopijuoti tekstą į iškarpinę';

  @override
  String get hapticsTitle => 'Lytėjimo grįžtamasis ryšys';

  @override
  String get defaultLanguageTitle => 'Numatytoji naujų įrašų kalba';

  @override
  String get defaultLanguageHint =>
      'Naudoja tik Whisper modeliai; Parakeet visada atpažįsta kalbą automatiškai.';

  @override
  String get licensesTitle => 'Licencijos';

  @override
  String get licensesSubtitle => 'Naudojama programinė įranga ir modeliai';

  @override
  String get licensesLegalese =>
      'Kalbos atpažinimas naudojant sherpa-onnx, Parakeet (NVIDIA, CC BY 4.0) ir Whisper (OpenAI, MIT).';

  @override
  String get deleteAllTitle => 'Ištrinti visus įrašus';

  @override
  String get deleteAllConfirmTitle => 'Ištrinti visus įrašus?';

  @override
  String get deleteAllConfirmBody =>
      'Visi tekstai ir įrašai bus ištrinti visam laikui.';

  @override
  String get errorMicPermission =>
      'Nėra prieigos prie mikrofono. Leisk ją telefono nustatymuose.';

  @override
  String errorRecorderStart(String detail) {
    return 'Nepavyko pradėti įrašymo ($detail).';
  }

  @override
  String errorRecorderStop(String detail) {
    return 'Nepavyko sustabdyti įrašymo ($detail).';
  }

  @override
  String errorTranscription(String detail) {
    return 'Transkripcija nepavyko ($detail). Įrašas išsaugotas, jį galima atpažinti iš naujo.';
  }

  @override
  String errorRetranscribe(String detail) {
    return 'Atpažinti iš naujo nepavyko ($detail).';
  }

  @override
  String errorModelLoad(String model, String detail) {
    return 'Nepavyko įkelti $model. Jei tai kartojasi, ištrink modelį ir atsisiųsk jį iš naujo. ($detail)';
  }

  @override
  String get errorNoModel => 'Neįkeltas joks modelis.';

  @override
  String downloadAlreadyRunning(String model) {
    return '$model jau atsisiunčiamas.';
  }

  @override
  String get downloadCancelled => 'Atsisiuntimas atšauktas.';

  @override
  String get downloadNetworkError =>
      'Atsisiųsti nepavyko. Patikrink interneto ryšį ir bandyk dar kartą.';

  @override
  String get downloadNotModelFile =>
      'Serveris negrąžino modelio failo (galbūt Wi-Fi prisijungimo puslapį). Patikrink tinklą ir bandyk dar kartą.';

  @override
  String downloadCorrupt(String file) {
    return 'Atsisiųstas failas $file sugadintas. Bandyk dar kartą.';
  }

  @override
  String downloadNoSpace(String model) {
    return 'Nepakanka vietos modeliui $model.';
  }
}
