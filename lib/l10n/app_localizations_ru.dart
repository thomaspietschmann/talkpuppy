// ignore: unused_import
import 'package:intl/intl.dart' as intl;

import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Russian (`ru`).
class AppLocalizationsRu extends AppLocalizations {
  AppLocalizationsRu([String locale = 'ru']) : super(locale);

  @override
  String get logoSemantics => 'Логотип Talkpuppy';

  @override
  String startupFailed(String error) {
    return 'Не удалось запустить Talkpuppy:\n$error';
  }

  @override
  String get settingsTooltip => 'Настройки';

  @override
  String get switchModelTooltip => 'Сменить модель';

  @override
  String get manageModelsEllipsis => 'Управление моделями…';

  @override
  String get manageModels => 'Управление моделями';

  @override
  String get installModel => 'Установить модель';

  @override
  String get noModel => 'Нет модели';

  @override
  String get ok => 'OK';

  @override
  String get cancel => 'Отмена';

  @override
  String get delete => 'Удалить';

  @override
  String get copy => 'Копировать';

  @override
  String get record => 'Записать';

  @override
  String get stopRecording => 'Стоп';

  @override
  String get transcribing => 'Расшифровка…';

  @override
  String get newRecording => 'Новая запись';

  @override
  String get continueRecording => 'Продолжить запись';

  @override
  String get transcriptLabel => 'Текст';

  @override
  String get emptyTranscript => 'Записей пока нет.\nНажми на микрофон внизу.';

  @override
  String get noTextRecognized => '(текст не распознан)';

  @override
  String get retranscribe => 'Распознать заново';

  @override
  String get today => 'Сегодня';

  @override
  String get yesterday => 'Вчера';

  @override
  String get welcomeTitle => 'Добро пожаловать в Talkpuppy';

  @override
  String get welcomeBody =>
      'Выбери речевую модель для расшифровки. Она работает полностью на твоём устройстве, интернет не нужен.';

  @override
  String get recommended => 'Рекомендуется';

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
  String get downloadAndStart => 'Скачать и начать';

  @override
  String get download => 'Скачать';

  @override
  String downloadFailed(String error) {
    return 'Ошибка загрузки: $error';
  }

  @override
  String get modelsTitle => 'Модели';

  @override
  String get deleteModelTitle => 'Удалить модель?';

  @override
  String deleteModelBody(String model, int size) {
    return '$model будет удалена с этого устройства ($size MB).';
  }

  @override
  String get modelDescParakeet =>
      'Очень быстрая и очень точная, 25 европейских языков, определяет язык автоматически. Рекомендуется для телефонов с объёмом RAM от 6 GB.';

  @override
  String get modelDescWhisperSmall =>
      'Баланс скорости и точности, 99 языков, язык можно зафиксировать. Для телефонов с объёмом RAM от 4 GB.';

  @override
  String get modelDescWhisperBase =>
      'Лёгкая модель для старых телефонов, 99 языков, язык можно зафиксировать. Для телефонов с объёмом RAM от 3 GB.';

  @override
  String get modelDescWhisperTiny =>
      'Минимальная и быстрее всех скачивается. 99 языков, язык можно зафиксировать. Работает практически на любом телефоне.';

  @override
  String get languageLabel => 'Язык';

  @override
  String get auto => 'Авто';

  @override
  String get modelLabel => 'Модель';

  @override
  String get whisperRequired =>
      'Для фиксированного языка нужна модель Whisper.';

  @override
  String get downloadWhisperSmall => 'Скачать Whisper Small';

  @override
  String get settingsTitle => 'Настройки';

  @override
  String get appLanguageTitle => 'Язык приложения';

  @override
  String get appLanguageSystem => 'Как в системе';

  @override
  String get autoCopyTitle => 'Копировать автоматически';

  @override
  String get autoCopySubtitle =>
      'Копировать текст в буфер обмена сразу после расшифровки';

  @override
  String get hapticsTitle => 'Виброотклик';

  @override
  String get defaultLanguageTitle => 'Язык по умолчанию для новых записей';

  @override
  String get defaultLanguageHint =>
      'Используется только моделями Whisper; Parakeet всегда определяет язык автоматически.';

  @override
  String get licensesTitle => 'Лицензии';

  @override
  String get licensesSubtitle => 'Используемое ПО и модели';

  @override
  String get licensesLegalese =>
      'Распознавание речи с помощью sherpa-onnx, Parakeet (NVIDIA, CC BY 4.0) и Whisper (OpenAI, MIT).';

  @override
  String get deleteAllTitle => 'Удалить все записи';

  @override
  String get deleteAllConfirmTitle => 'Удалить все записи?';

  @override
  String get deleteAllConfirmBody =>
      'Все тексты и записи будут удалены безвозвратно.';

  @override
  String get errorMicPermission =>
      'Нет доступа к микрофону. Разреши его в настройках телефона.';

  @override
  String errorRecorderStart(String detail) {
    return 'Не удалось начать запись ($detail).';
  }

  @override
  String errorRecorderStop(String detail) {
    return 'Не удалось остановить запись ($detail).';
  }

  @override
  String errorTranscription(String detail) {
    return 'Не удалось расшифровать ($detail). Запись сохранена, её можно распознать заново.';
  }

  @override
  String errorRetranscribe(String detail) {
    return 'Не удалось распознать заново ($detail).';
  }

  @override
  String errorModelLoad(String model, String detail) {
    return 'Не удалось загрузить $model. Если это повторяется, удали модель и скачай её снова. ($detail)';
  }

  @override
  String get errorNoModel => 'Модель не загружена.';

  @override
  String downloadAlreadyRunning(String model) {
    return '$model уже скачивается.';
  }

  @override
  String get downloadCancelled => 'Загрузка отменена.';

  @override
  String get downloadNetworkError =>
      'Ошибка загрузки. Проверь подключение к интернету и попробуй ещё раз.';

  @override
  String get downloadNotModelFile =>
      'Сервер не вернул файл модели (возможно, страницу входа Wi-Fi). Проверь сеть и попробуй ещё раз.';

  @override
  String downloadCorrupt(String file) {
    return 'Скачанный файл $file повреждён. Попробуй ещё раз.';
  }

  @override
  String downloadNoSpace(String model) {
    return 'Недостаточно места для $model.';
  }
}
