// ignore: unused_import
import 'package:intl/intl.dart' as intl;

import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Ukrainian (`uk`).
class AppLocalizationsUk extends AppLocalizations {
  AppLocalizationsUk([String locale = 'uk']) : super(locale);

  @override
  String get logoSemantics => 'Логотип Talkpuppy';

  @override
  String startupFailed(String error) {
    return 'Не вдалося запустити Talkpuppy:\n$error';
  }

  @override
  String get settingsTooltip => 'Налаштування';

  @override
  String get switchModelTooltip => 'Змінити модель';

  @override
  String get manageModelsEllipsis => 'Керувати моделями…';

  @override
  String get manageModels => 'Керувати моделями';

  @override
  String get installModel => 'Встановити модель';

  @override
  String get noModel => 'Немає моделі';

  @override
  String get ok => 'OK';

  @override
  String get cancel => 'Скасувати';

  @override
  String get delete => 'Видалити';

  @override
  String get copy => 'Копіювати';

  @override
  String get record => 'Записати';

  @override
  String get stopRecording => 'Стоп';

  @override
  String get transcribing => 'Транскрибування…';

  @override
  String get newRecording => 'Новий запис';

  @override
  String get continueRecording => 'Продовжити запис';

  @override
  String get transcriptLabel => 'Текст';

  @override
  String get emptyTranscript => 'Ще немає записів.\nТоркнися мікрофона внизу.';

  @override
  String get noTextRecognized => '(текст не розпізнано)';

  @override
  String get retranscribe => 'Розпізнати знову';

  @override
  String get today => 'Сьогодні';

  @override
  String get yesterday => 'Учора';

  @override
  String get welcomeTitle => 'Вітаємо в Talkpuppy';

  @override
  String get welcomeBody =>
      'Обери мовну модель для транскрипції. Вона працює повністю на твоєму пристрої, інтернет не потрібен.';

  @override
  String get recommended => 'Рекомендовано';

  @override
  String get preparing => 'Підготовка…';

  @override
  String sizeMb(int size) {
    return '$size MB';
  }

  @override
  String downloadProgress(int received, int total) {
    return '$received MB / $total MB';
  }

  @override
  String get downloadAndStart => 'Завантажити й почати';

  @override
  String get download => 'Завантажити';

  @override
  String downloadFailed(String error) {
    return 'Помилка завантаження: $error';
  }

  @override
  String get modelsTitle => 'Моделі';

  @override
  String get deleteModelTitle => 'Видалити модель?';

  @override
  String deleteModelBody(String model, int size) {
    return '$model буде видалено з цього пристрою ($size MB).';
  }

  @override
  String get modelDescParakeet =>
      'Дуже швидка й дуже точна, 25 європейських мов, визначає мову автоматично. Рекомендовано для телефонів із щонайменше 6 GB RAM.';

  @override
  String get modelDescWhisperSmall =>
      'Баланс між швидкістю й точністю, 99 мов, мову можна зафіксувати. Для телефонів із щонайменше 4 GB RAM.';

  @override
  String get modelDescWhisperBase =>
      'Легка модель для старіших телефонів, 99 мов, мову можна зафіксувати. Для телефонів із щонайменше 3 GB RAM.';

  @override
  String get modelDescWhisperTiny =>
      'Мінімальна й найшвидша для завантаження. 99 мов, мову можна зафіксувати. Працює практично на будь-якому телефоні.';

  @override
  String get languageLabel => 'Мова';

  @override
  String get auto => 'Авто';

  @override
  String get modelLabel => 'Модель';

  @override
  String get whisperRequired => 'Для фіксованої мови потрібна модель Whisper.';

  @override
  String get downloadWhisperSmall => 'Завантажити Whisper Small';

  @override
  String get settingsTitle => 'Налаштування';

  @override
  String get appLanguageTitle => 'Мова застосунку';

  @override
  String get appLanguageSystem => 'Як у системі';

  @override
  String get autoCopyTitle => 'Копіювати автоматично';

  @override
  String get autoCopySubtitle =>
      'Копіювати текст у буфер обміну одразу після транскрипції';

  @override
  String get hapticsTitle => 'Тактильний відгук';

  @override
  String get defaultLanguageTitle => 'Мова за замовчуванням для нових записів';

  @override
  String get defaultLanguageHint =>
      'Використовується лише моделями Whisper; Parakeet завжди визначає мову автоматично.';

  @override
  String get licensesTitle => 'Ліцензії';

  @override
  String get licensesSubtitle => 'Використане ПЗ і моделі';

  @override
  String get licensesLegalese =>
      'Розпізнавання мовлення за допомогою sherpa-onnx, Parakeet (NVIDIA, CC BY 4.0) і Whisper (OpenAI, MIT).';

  @override
  String get deleteAllTitle => 'Видалити всі записи';

  @override
  String get deleteAllConfirmTitle => 'Видалити всі записи?';

  @override
  String get deleteAllConfirmBody =>
      'Усі тексти й записи буде видалено назавжди.';

  @override
  String get errorMicPermission =>
      'Немає доступу до мікрофона. Дозволь його в налаштуваннях телефона.';

  @override
  String errorRecorderStart(String detail) {
    return 'Не вдалося почати запис ($detail).';
  }

  @override
  String errorRecorderStop(String detail) {
    return 'Не вдалося зупинити запис ($detail).';
  }

  @override
  String errorTranscription(String detail) {
    return 'Не вдалося транскрибувати ($detail). Запис збережено, його можна розпізнати знову.';
  }

  @override
  String errorRetranscribe(String detail) {
    return 'Не вдалося розпізнати знову ($detail).';
  }

  @override
  String errorModelLoad(String model, String detail) {
    return 'Не вдалося завантажити $model. Якщо це повторюється, видали модель і завантаж її знову. ($detail)';
  }

  @override
  String get errorNoModel => 'Модель не завантажено.';

  @override
  String downloadAlreadyRunning(String model) {
    return '$model уже завантажується.';
  }

  @override
  String get downloadCancelled => 'Завантаження скасовано.';

  @override
  String get downloadNetworkError =>
      'Помилка завантаження. Перевір підключення до інтернету й спробуй ще раз.';

  @override
  String get downloadNotModelFile =>
      'Сервер не повернув файл моделі (можливо, сторінку входу Wi-Fi). Перевір мережу й спробуй ще раз.';

  @override
  String downloadCorrupt(String file) {
    return 'Завантажений файл $file пошкоджено. Спробуй ще раз.';
  }

  @override
  String downloadNoSpace(String model) {
    return 'Недостатньо пам\'яті для $model.';
  }
}
