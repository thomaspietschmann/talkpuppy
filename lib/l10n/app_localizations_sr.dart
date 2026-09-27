// ignore: unused_import
import 'package:intl/intl.dart' as intl;

import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Serbian (`sr`).
class AppLocalizationsSr extends AppLocalizations {
  AppLocalizationsSr([String locale = 'sr']) : super(locale);

  @override
  String get logoSemantics => 'Talkpuppy лого';

  @override
  String startupFailed(String error) {
    return 'Talkpuppy није могао да се покрене:\n$error';
  }

  @override
  String get settingsTooltip => 'Подешавања';

  @override
  String get switchModelTooltip => 'Промени модел';

  @override
  String get manageModelsEllipsis => 'Управљај моделима…';

  @override
  String get manageModels => 'Управљај моделима';

  @override
  String get installModel => 'Инсталирај модел';

  @override
  String get noModel => 'Нема модела';

  @override
  String get ok => 'Потврди';

  @override
  String get cancel => 'Откажи';

  @override
  String get delete => 'Избриши';

  @override
  String get copy => 'Копирај';

  @override
  String get record => 'Сними';

  @override
  String get stopRecording => 'Заустави';

  @override
  String get transcribing => 'Транскрибујем…';

  @override
  String get newRecording => 'Нови снимак';

  @override
  String get continueRecording => 'Настави снимање';

  @override
  String get transcriptLabel => 'Транскрипт';

  @override
  String get emptyTranscript => 'Још нема снимка.\nДодирни микрофон испод.';

  @override
  String get noTextRecognized => '(текст није препознат)';

  @override
  String get retranscribe => 'Поново транскрибуј';

  @override
  String get today => 'Данас';

  @override
  String get yesterday => 'Јуче';

  @override
  String get welcomeTitle => 'Добро дошли у Talkpuppy';

  @override
  String get welcomeBody =>
      'Изабери говорни модел за транскрипцију. Ради у потпуности на твом уређају, без интернета.';

  @override
  String get recommended => 'Препоручено';

  @override
  String get preparing => 'Припремам…';

  @override
  String sizeMb(int size) {
    return '$size MB';
  }

  @override
  String downloadProgress(int received, int total) {
    return '$received MB / $total MB';
  }

  @override
  String get downloadAndStart => 'Преузми и почни';

  @override
  String get download => 'Преузми';

  @override
  String downloadFailed(String error) {
    return 'Преузимање није успело: $error';
  }

  @override
  String get modelsTitle => 'Модели';

  @override
  String get deleteModelTitle => 'Избрисати модел?';

  @override
  String deleteModelBody(String model, int size) {
    return '$model ће бити избрисан са овог уређаја ($size MB).';
  }

  @override
  String get modelDescParakeet =>
      'Веома брз и веома прецизан, 25 европских језика, аутоматски препознаје језик. Препоручено за телефоне са најмање 6 GB RAM-а.';

  @override
  String get modelDescWhisperSmall =>
      'Уравнотежен између брзине и прецизности, 99 језика, језик може да се фиксира. За телефоне са најмање 4 GB RAM-а.';

  @override
  String get modelDescWhisperBase =>
      'Лаган, за старије телефоне, 99 језика, језик може да се фиксира. За телефоне са најмање 3 GB RAM-а.';

  @override
  String get modelDescWhisperTiny =>
      'Најмањи и најбржи за преузимање. 99 језика, језик може да се фиксира. Ради на практично сваком телефону.';

  @override
  String get languageLabel => 'Језик';

  @override
  String get auto => 'Аутоматски';

  @override
  String get modelLabel => 'Модел';

  @override
  String get whisperRequired => 'За фиксни језик потребан је Whisper модел.';

  @override
  String get downloadWhisperSmall => 'Преузми Whisper Small';

  @override
  String get settingsTitle => 'Подешавања';

  @override
  String get appLanguageTitle => 'Језик апликације';

  @override
  String get appLanguageSystem => 'Подразумевани системски';

  @override
  String get autoCopyTitle => 'Копирај аутоматски';

  @override
  String get autoCopySubtitle =>
      'Стави текст у привремену меморију одмах после транскрипције';

  @override
  String get hapticsTitle => 'Тактилни одзив';

  @override
  String get defaultLanguageTitle => 'Подразумевани језик за нове снимке';

  @override
  String get defaultLanguageHint =>
      'Користе га само Whisper модели; Parakeet увек аутоматски препознаје језик.';

  @override
  String get licensesTitle => 'Лиценце';

  @override
  String get licensesSubtitle => 'Коришћени софтвер и модели';

  @override
  String get licensesLegalese =>
      'Препознавање говора помоћу sherpa-onnx, Parakeet (NVIDIA, CC BY 4.0) и Whisper (OpenAI, MIT).';

  @override
  String get deleteAllTitle => 'Избриши све снимке';

  @override
  String get deleteAllConfirmTitle => 'Избрисати све снимке?';

  @override
  String get deleteAllConfirmBody =>
      'Сви транскрипти и снимци биће трајно избрисани.';

  @override
  String get errorMicPermission =>
      'Нема приступа микрофону. Дозволи га у подешавањима телефона.';

  @override
  String errorRecorderStart(String detail) {
    return 'Снимање није могло да почне ($detail).';
  }

  @override
  String errorRecorderStop(String detail) {
    return 'Снимање није могло да се заустави ($detail).';
  }

  @override
  String errorTranscription(String detail) {
    return 'Транскрипција није успела ($detail). Снимак је сачуван и може поново да се транскрибује.';
  }

  @override
  String errorRetranscribe(String detail) {
    return 'Поновна транскрипција није успела ($detail).';
  }

  @override
  String errorModelLoad(String model, String detail) {
    return 'Модел $model није могао да се учита. Ако се ово понавља, избриши модел и поново га преузми. ($detail)';
  }

  @override
  String get errorNoModel => 'Ниједан модел није учитан.';

  @override
  String downloadAlreadyRunning(String model) {
    return '$model се већ преузима.';
  }

  @override
  String get downloadCancelled => 'Преузимање је отказано.';

  @override
  String get downloadNetworkError =>
      'Преузимање није успело. Провери интернет везу и покушај поново.';

  @override
  String get downloadNotModelFile =>
      'Сервер није вратио датотеку модела (можда страница за пријаву на Wi-Fi). Провери мрежу и покушај поново.';

  @override
  String downloadCorrupt(String file) {
    return 'Преузета датотека $file је оштећена. Покушај поново.';
  }

  @override
  String downloadNoSpace(String model) {
    return 'Нема довољно простора за $model.';
  }
}
