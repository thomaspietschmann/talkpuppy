// ignore: unused_import
import 'package:intl/intl.dart' as intl;

import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Bulgarian (`bg`).
class AppLocalizationsBg extends AppLocalizations {
  AppLocalizationsBg([String locale = 'bg']) : super(locale);

  @override
  String get logoSemantics => 'Лого на Talkpuppy';

  @override
  String startupFailed(String error) {
    return 'Talkpuppy не успя да стартира:\n$error';
  }

  @override
  String get settingsTooltip => 'Настройки';

  @override
  String get switchModelTooltip => 'Смяна на модела';

  @override
  String get manageModelsEllipsis => 'Управление на моделите…';

  @override
  String get manageModels => 'Управление на моделите';

  @override
  String get installModel => 'Инсталирай модел';

  @override
  String get noModel => 'Няма модел';

  @override
  String get ok => 'OK';

  @override
  String get cancel => 'Отказ';

  @override
  String get delete => 'Изтрий';

  @override
  String get copy => 'Копирай';

  @override
  String get record => 'Запис';

  @override
  String get stopRecording => 'Спри';

  @override
  String get transcribing => 'Транскрибиране…';

  @override
  String get newRecording => 'Нов запис';

  @override
  String get continueRecording => 'Продължи записа';

  @override
  String get transcriptLabel => 'Транскрипция';

  @override
  String get emptyTranscript => 'Още няма запис.\nДокосни микрофона долу.';

  @override
  String get noTextRecognized => '(не е разпознат текст)';

  @override
  String get retranscribe => 'Транскрибирай отново';

  @override
  String get today => 'Днес';

  @override
  String get yesterday => 'Вчера';

  @override
  String get welcomeTitle => 'Добре дошли в Talkpuppy';

  @override
  String get welcomeBody =>
      'Избери говорен модел за транскрипция. Работи изцяло на устройството ти, без интернет.';

  @override
  String get recommended => 'Препоръчан';

  @override
  String get preparing => 'Подготовка…';

  @override
  String sizeMb(int size) {
    return '$size MB';
  }

  @override
  String downloadProgress(int received, int total) {
    return '$received MB / $total MB';
  }

  @override
  String get downloadAndStart => 'Изтегли и започни';

  @override
  String get download => 'Изтегли';

  @override
  String downloadFailed(String error) {
    return 'Изтеглянето не успя: $error';
  }

  @override
  String get modelsTitle => 'Модели';

  @override
  String get deleteModelTitle => 'Изтриване на модела?';

  @override
  String deleteModelBody(String model, int size) {
    return '$model ще бъде изтрит от това устройство ($size MB).';
  }

  @override
  String get modelDescParakeet =>
      'Много точен и бърз. Текстът се появява, щом спреш записа. 25 европейски езика, разпознавани автоматично; езикът не може да се фиксира. Голямо изтегляне, за телефони с поне 6 GB RAM.';

  @override
  String get modelDescWhisperSmall =>
      'Най-много езици (99), разпознавани автоматично или фиксирани. Добра точност, но е по-бавен от Parakeet, а при тишина или шум понякога може да измисля думи. За телефони с поне 4 GB RAM.';

  @override
  String get modelDescWhisperBase =>
      'Малко изтегляне за по-стари телефони. 99 езика, разпознавани автоматично или фиксирани. Осезаемо по-неточен от Whisper Small. За телефони с поне 3 GB RAM.';

  @override
  String get modelDescWhisperTiny =>
      'Най-малкият и най-бърз, работи на практика на всеки телефон. 99 езика, разпознавани автоматично или фиксирани. Най-неточен, най-подходящ за кратки, ясно изговорени бележки.';

  @override
  String get modelDescNemotron =>
      'Преглед на живо: текстът се появява, докато говориш, и е готов веднага щом спреш. 28 езика, разпознавани автоматично или фиксирани. Обикновено малко по-неточен от Parakeet. Голямо изтегляне, за телефони с поне 6 GB RAM.';

  @override
  String get livePreviewLabel => 'Преглед на живо';

  @override
  String get livePreviewListening => 'Слуша…';

  @override
  String get languageLabel => 'Език';

  @override
  String get auto => 'Автоматично';

  @override
  String get modelLabel => 'Модел';

  @override
  String get whisperRequired =>
      'За фиксиран език е нужен модел Whisper или Nemotron.';

  @override
  String get downloadWhisperSmall => 'Изтегли Whisper Small';

  @override
  String get settingsTitle => 'Настройки';

  @override
  String get appLanguageTitle => 'Език на приложението';

  @override
  String get appLanguageSystem => 'Системен по подразбиране';

  @override
  String get autoCopyTitle => 'Автоматично копиране';

  @override
  String get autoCopySubtitle =>
      'Постави текста в буфера веднага след транскрипцията';

  @override
  String get hapticsTitle => 'Вибрация при докосване';

  @override
  String get minimizeToOverlay => 'Минимизиране и показване на наслагването';

  @override
  String get overlaySetupTitle => 'Включи услугата за достъпност';

  @override
  String get overlaySetupBody =>
      'За да показва бутона върху другите приложения и да вмъква текста на мястото на курсора, Talkpuppy има нужда от своята услуга за достъпност. Тя чете само полето, в което пишеш, и само за да вмъкне текста. Не чете нищо друго от екрана, не запазва нищо от други приложения и не изпраща нищо никъде.\n\nНа следващия екран отвори „Talkpuppy“ и го включи.';

  @override
  String get overlayOpenAccessibility => 'Отвори настройките за достъпност';

  @override
  String get overlayRestrictedHint =>
      'Превключвателят е сив? Отвори Информация за приложението → ⋮ → „Разрешаване на ограничените настройки“ и опитай отново.';

  @override
  String get defaultLanguageTitle => 'Език по подразбиране за нови записи';

  @override
  String get defaultLanguageHint =>
      'Използва се от Whisper и Nemotron; Parakeet винаги разпознава езика автоматично.';

  @override
  String get licensesTitle => 'Лицензи';

  @override
  String get licensesSubtitle => 'Използван софтуер и модели';

  @override
  String get licensesLegalese =>
      'Разпознаване на говор чрез sherpa-onnx, Parakeet (NVIDIA, CC BY 4.0), Nemotron (NVIDIA, OpenMDW 1.1) и Whisper (OpenAI, MIT).';

  @override
  String get licensesIntro =>
      'Talkpuppy е изграден върху софтуер с отворен код и говорни модели с отворени лицензи.';

  @override
  String get licensesSpeechModels => 'Говорни модели';

  @override
  String get licensesSoftware => 'Софтуер';

  @override
  String get licensesPackages => 'Flutter и други пакети с отворен код';

  @override
  String get licensesShowAll => 'Покажи всички лицензионни текстове';

  @override
  String get deleteAllTitle => 'Изтрий всички записи';

  @override
  String get deleteAllConfirmTitle => 'Изтриване на всички записи?';

  @override
  String get deleteAllConfirmBody =>
      'Всички транскрипции и записи ще бъдат изтрити завинаги.';

  @override
  String get errorMicPermission =>
      'Няма достъп до микрофона. Разреши го в настройките на телефона.';

  @override
  String errorRecorderStart(String detail) {
    return 'Записът не можа да започне ($detail).';
  }

  @override
  String errorRecorderStop(String detail) {
    return 'Записът не можа да бъде спрян ($detail).';
  }

  @override
  String errorTranscription(String detail) {
    return 'Транскрипцията не успя ($detail). Записът е запазен и може да се транскрибира отново.';
  }

  @override
  String errorRetranscribe(String detail) {
    return 'Повторната транскрипция не успя ($detail).';
  }

  @override
  String errorModelLoad(String model, String detail) {
    return '$model не можа да се зареди. Ако това се повтаря, изтрий модела и го изтегли отново. ($detail)';
  }

  @override
  String get errorNoModel => 'Няма зареден модел.';

  @override
  String downloadAlreadyRunning(String model) {
    return '$model вече се изтегля.';
  }

  @override
  String get downloadCancelled => 'Изтеглянето е отменено.';

  @override
  String get downloadNetworkError =>
      'Изтеглянето не успя. Провери интернет връзката си и опитай отново.';

  @override
  String get downloadNotModelFile =>
      'Сървърът не върна файл на модел (може би страница за вход в Wi-Fi). Провери мрежата и опитай отново.';

  @override
  String downloadCorrupt(String file) {
    return 'Изтегленият файл $file е повреден. Опитай отново.';
  }

  @override
  String downloadNoSpace(String model) {
    return 'Няма достатъчно място за $model.';
  }
}
