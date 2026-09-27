// ignore: unused_import
import 'package:intl/intl.dart' as intl;

import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Macedonian (`mk`).
class AppLocalizationsMk extends AppLocalizations {
  AppLocalizationsMk([String locale = 'mk']) : super(locale);

  @override
  String get logoSemantics => 'Лого на Talkpuppy';

  @override
  String startupFailed(String error) {
    return 'Talkpuppy не можеше да се стартува:\n$error';
  }

  @override
  String get settingsTooltip => 'Поставки';

  @override
  String get switchModelTooltip => 'Промени модел';

  @override
  String get manageModelsEllipsis => 'Управувај со модели…';

  @override
  String get manageModels => 'Управувај со модели';

  @override
  String get installModel => 'Инсталирај модел';

  @override
  String get noModel => 'Нема модел';

  @override
  String get ok => 'Во ред';

  @override
  String get cancel => 'Откажи';

  @override
  String get delete => 'Избриши';

  @override
  String get copy => 'Копирај';

  @override
  String get record => 'Снимај';

  @override
  String get stopRecording => 'Запри';

  @override
  String get transcribing => 'Транскрибирам…';

  @override
  String get newRecording => 'Нова снимка';

  @override
  String get continueRecording => 'Продолжи со снимање';

  @override
  String get transcriptLabel => 'Транскрипт';

  @override
  String get emptyTranscript =>
      'Сè уште нема снимка.\nДопри го микрофонот долу.';

  @override
  String get noTextRecognized => '(не е препознаен текст)';

  @override
  String get retranscribe => 'Транскрибирај повторно';

  @override
  String get today => 'Денес';

  @override
  String get yesterday => 'Вчера';

  @override
  String get welcomeTitle => 'Добредојде во Talkpuppy';

  @override
  String get welcomeBody =>
      'Избери говорен модел за транскрипција. Работи целосно на твојот уред, без интернет.';

  @override
  String get recommended => 'Препорачано';

  @override
  String get preparing => 'Се подготвува…';

  @override
  String sizeMb(int size) {
    return '$size MB';
  }

  @override
  String downloadProgress(int received, int total) {
    return '$received MB / $total MB';
  }

  @override
  String get downloadAndStart => 'Преземи и започни';

  @override
  String get download => 'Преземи';

  @override
  String downloadFailed(String error) {
    return 'Преземањето не успеа: $error';
  }

  @override
  String get modelsTitle => 'Модели';

  @override
  String get deleteModelTitle => 'Да се избрише моделот?';

  @override
  String deleteModelBody(String model, int size) {
    return '$model ќе биде избришан од овој уред ($size MB).';
  }

  @override
  String get modelDescParakeet =>
      'Многу брз и многу прецизен, 25 европски јазици, автоматски го препознава јазикот. Препорачан за телефони со најмалку 6 GB RAM.';

  @override
  String get modelDescWhisperSmall =>
      'Избалансиран меѓу брзина и прецизност, 99 јазици, јазикот може да се фиксира. За телефони со најмалку 4 GB RAM.';

  @override
  String get modelDescWhisperBase =>
      'Лесен, за постари телефони, 99 јазици, јазикот може да се фиксира. За телефони со најмалку 3 GB RAM.';

  @override
  String get modelDescWhisperTiny =>
      'Најмал и најбрз за преземање. 99 јазици, јазикот може да се фиксира. Работи на речиси секој телефон.';

  @override
  String get languageLabel => 'Јазик';

  @override
  String get auto => 'Автоматски';

  @override
  String get modelLabel => 'Модел';

  @override
  String get whisperRequired => 'За фиксен јазик е потребен Whisper модел.';

  @override
  String get downloadWhisperSmall => 'Преземи Whisper Small';

  @override
  String get settingsTitle => 'Поставки';

  @override
  String get appLanguageTitle => 'Јазик на апликацијата';

  @override
  String get appLanguageSystem => 'Системски стандард';

  @override
  String get autoCopyTitle => 'Копирај автоматски';

  @override
  String get autoCopySubtitle =>
      'Стави го текстот во меѓумеморијата веднаш по транскрипцијата';

  @override
  String get hapticsTitle => 'Хаптички повратни информации';

  @override
  String get defaultLanguageTitle => 'Стандарден јазик за нови снимки';

  @override
  String get defaultLanguageHint =>
      'Го користат само Whisper моделите; Parakeet секогаш автоматски го препознава јазикот.';

  @override
  String get licensesTitle => 'Лиценци';

  @override
  String get licensesSubtitle => 'Користен софтвер и модели';

  @override
  String get licensesLegalese =>
      'Препознавање говор со sherpa-onnx, Parakeet (NVIDIA, CC BY 4.0) и Whisper (OpenAI, MIT).';

  @override
  String get deleteAllTitle => 'Избриши ги сите снимки';

  @override
  String get deleteAllConfirmTitle => 'Да се избришат сите снимки?';

  @override
  String get deleteAllConfirmBody =>
      'Сите транскрипти и снимки ќе бидат трајно избришани.';

  @override
  String get errorMicPermission =>
      'Нема пристап до микрофонот. Дозволи го во поставките на телефонот.';

  @override
  String errorRecorderStart(String detail) {
    return 'Снимањето не можеше да започне ($detail).';
  }

  @override
  String errorRecorderStop(String detail) {
    return 'Снимањето не можеше да се запре ($detail).';
  }

  @override
  String errorTranscription(String detail) {
    return 'Транскрипцијата не успеа ($detail). Снимката е зачувана и може повторно да се транскрибира.';
  }

  @override
  String errorRetranscribe(String detail) {
    return 'Повторната транскрипција не успеа ($detail).';
  }

  @override
  String errorModelLoad(String model, String detail) {
    return '$model не можеше да се вчита. Ако ова се повторува, избриши го моделот и преземи го повторно. ($detail)';
  }

  @override
  String get errorNoModel => 'Нема вчитан модел.';

  @override
  String downloadAlreadyRunning(String model) {
    return '$model веќе се презема.';
  }

  @override
  String get downloadCancelled => 'Преземањето е откажано.';

  @override
  String get downloadNetworkError =>
      'Преземањето не успеа. Провери ја интернет врската и обиди се повторно.';

  @override
  String get downloadNotModelFile =>
      'Серверот не врати датотека на модел (можеби страница за најава на Wi-Fi). Провери ја мрежата и обиди се повторно.';

  @override
  String downloadCorrupt(String file) {
    return 'Преземената датотека $file е оштетена. Обиди се повторно.';
  }

  @override
  String downloadNoSpace(String model) {
    return 'Нема доволно простор за $model.';
  }
}
