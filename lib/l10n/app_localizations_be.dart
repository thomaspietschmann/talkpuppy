// ignore: unused_import
import 'package:intl/intl.dart' as intl;

import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Belarusian (`be`).
class AppLocalizationsBe extends AppLocalizations {
  AppLocalizationsBe([String locale = 'be']) : super(locale);

  @override
  String get logoSemantics => 'Лагатып Talkpuppy';

  @override
  String startupFailed(String error) {
    return 'Не ўдалося запусціць Talkpuppy:\n$error';
  }

  @override
  String get settingsTooltip => 'Налады';

  @override
  String get switchModelTooltip => 'Змяніць мадэль';

  @override
  String get manageModelsEllipsis => 'Кіраваць мадэлямі…';

  @override
  String get manageModels => 'Кіраваць мадэлямі';

  @override
  String get installModel => 'Усталяваць мадэль';

  @override
  String get noModel => 'Няма мадэлі';

  @override
  String get ok => 'OK';

  @override
  String get cancel => 'Скасаваць';

  @override
  String get delete => 'Выдаліць';

  @override
  String get copy => 'Капіраваць';

  @override
  String get record => 'Запісаць';

  @override
  String get stopRecording => 'Стоп';

  @override
  String get transcribing => 'Расшыфроўка…';

  @override
  String get newRecording => 'Новы запіс';

  @override
  String get continueRecording => 'Працягнуць запіс';

  @override
  String get transcriptLabel => 'Тэкст';

  @override
  String get emptyTranscript =>
      'Запісаў пакуль няма.\nНацісні на мікрафон унізе.';

  @override
  String get noTextRecognized => '(тэкст не распазнаны)';

  @override
  String get retranscribe => 'Распазнаць зноў';

  @override
  String get today => 'Сёння';

  @override
  String get yesterday => 'Учора';

  @override
  String get welcomeTitle => 'Вітаем у Talkpuppy';

  @override
  String get welcomeBody =>
      'Абяры маўленчую мадэль для расшыфроўкі. Яна працуе цалкам на тваёй прыладзе, інтэрнэт не патрэбны.';

  @override
  String get recommended => 'Рэкамендуецца';

  @override
  String get preparing => 'Падрыхтоўка…';

  @override
  String sizeMb(int size) {
    return '$size MB';
  }

  @override
  String downloadProgress(int received, int total) {
    return '$received MB / $total MB';
  }

  @override
  String get downloadAndStart => 'Спампаваць і пачаць';

  @override
  String get download => 'Спампаваць';

  @override
  String downloadFailed(String error) {
    return 'Памылка спампоўкі: $error';
  }

  @override
  String get modelsTitle => 'Мадэлі';

  @override
  String get deleteModelTitle => 'Выдаліць мадэль?';

  @override
  String deleteModelBody(String model, int size) {
    return '$model будзе выдалена з гэтай прылады ($size MB).';
  }

  @override
  String get modelDescParakeet =>
      'Вельмі дакладная і хуткая. Тэкст з\'яўляецца, калі ты спыніш запіс. 25 еўрапейскіх моў, вызначаюцца аўтаматычна; мову нельга зафіксаваць. Вялікая спампоўка, для тэлефонаў з RAM ад 6 GB.';

  @override
  String get modelDescWhisperSmall =>
      'Найбольш моў (99), вызначаюцца аўтаматычна або фіксуюцца. Добрая дакладнасць, але павольней за Parakeet, а пры цішыні ці шуме можа часам выдумляць словы. Для тэлефонаў з RAM ад 4 GB.';

  @override
  String get modelDescWhisperBase =>
      'Невялікая спампоўка для старых тэлефонаў. 99 моў, вызначаюцца аўтаматычна або фіксуюцца. Заўважна менш дакладная, чым Whisper Small. Для тэлефонаў з RAM ад 3 GB.';

  @override
  String get modelDescWhisperTiny =>
      'Самая маленькая і хуткая, працуе практычна на любым тэлефоне. 99 моў, вызначаюцца аўтаматычна або фіксуюцца. Найменш дакладная, лепш за ўсё падыходзіць для кароткіх, выразна прамоўленых нататак.';

  @override
  String get modelDescNemotron =>
      'Жывы прагляд: тэкст з\'яўляецца, пакуль ты гаворыш, і гатовы, як толькі ты спынішся. 28 моў, вызначаюцца аўтаматычна або фіксуюцца. Звычайна крыху менш дакладная, чым Parakeet. Вялікая спампоўка, для тэлефонаў з RAM ад 6 GB.';

  @override
  String get livePreviewLabel => 'Жывы прагляд';

  @override
  String get livePreviewListening => 'Слухаю…';

  @override
  String get languageLabel => 'Мова';

  @override
  String get auto => 'Аўта';

  @override
  String get modelLabel => 'Мадэль';

  @override
  String get whisperRequired =>
      'Для фіксаванай мовы патрэбна мадэль Whisper або Nemotron.';

  @override
  String get downloadWhisperSmall => 'Спампаваць Whisper Small';

  @override
  String get settingsTitle => 'Налады';

  @override
  String get appLanguageTitle => 'Мова праграмы';

  @override
  String get appLanguageSystem => 'Як у сістэме';

  @override
  String get autoCopyTitle => 'Капіраваць аўтаматычна';

  @override
  String get autoCopySubtitle =>
      'Капіраваць тэкст у буфер абмену адразу пасля расшыфроўкі';

  @override
  String get hapticsTitle => 'Тактыльны водгук';

  @override
  String get minimizeToOverlay => 'Згарнуць і паказаць накладку';

  @override
  String get overlaySetupTitle => 'Уключы службу спецыяльных магчымасцей';

  @override
  String get overlaySetupBody =>
      'Каб паказваць кнопку паверх іншых праграм і ўстаўляць тэкст у месца курсора, Talkpuppy патрэбна яго служба спецыяльных магчымасцей. Яна чытае толькі поле, у якім ты пішаш, і толькі для таго, каб уставіць тэкст. Больш яна нічога не чытае на экране, нічога не захоўвае з іншых праграм і нікуды нічога не адпраўляе.\n\nНа наступным экране адкрый «Talkpuppy» і ўключы яго.';

  @override
  String get overlaySetupShortcut =>
      'Уключы толькі перамыкач Talkpuppy і пакінь «Хуткі доступ» выключаным: кнопка з\'явіцца сама.';

  @override
  String get shortcutHint =>
      '«Хуткі доступ» для Talkpuppy уключаны, таму Android замацоўвае значок праграмы на краі экрана. Ён табе не патрэбны: плаваючая кнопка з\'яўляецца сама. Выключы «Хуткі доступ» у наладах спецыяльных магчымасцей Talkpuppy.';

  @override
  String get shortcutHintAction => 'Адкрыць налады Talkpuppy';

  @override
  String get overlayOpenAccessibility => 'Адкрыць спецыяльныя магчымасці';

  @override
  String get overlayRestrictedHint =>
      'Пераключальнік неактыўны? Адкрый «Звесткі пра праграму» → ⋮ → «Дазволіць абмежаваныя налады» і паспрабуй зноў.';

  @override
  String get defaultLanguageTitle => 'Мова па змаўчанні для новых запісаў';

  @override
  String get defaultLanguageHint =>
      'Выкарыстоўваецца мадэлямі Whisper і Nemotron; Parakeet заўсёды вызначае мову аўтаматычна.';

  @override
  String get licensesTitle => 'Ліцэнзіі';

  @override
  String get licensesSubtitle => 'Выкарыстанае ПЗ і мадэлі';

  @override
  String get licensesLegalese =>
      'Распазнаванне маўлення з дапамогай sherpa-onnx, Parakeet (NVIDIA, CC BY 4.0), Nemotron (NVIDIA, OpenMDW 1.1) і Whisper (OpenAI, MIT).';

  @override
  String get licensesIntro =>
      'Talkpuppy пабудаваны на праграмным забеспячэнні з адкрытым зыходным кодам і маўленчых мадэлях з адкрытымі ліцэнзіямі.';

  @override
  String get licensesSpeechModels => 'Маўленчыя мадэлі';

  @override
  String get licensesSoftware => 'Праграмнае забеспячэнне';

  @override
  String get licensesPackages =>
      'Flutter і іншыя пакеты з адкрытым зыходным кодам';

  @override
  String get licensesShowAll => 'Паказаць усе тэксты ліцэнзій';

  @override
  String get deleteAllTitle => 'Выдаліць усе запісы';

  @override
  String get deleteAllConfirmTitle => 'Выдаліць усе запісы?';

  @override
  String get deleteAllConfirmBody =>
      'Усе тэксты і запісы будуць выдалены назаўсёды.';

  @override
  String get errorMicPermission =>
      'Няма доступу да мікрафона. Дазволь яго ў наладах тэлефона.';

  @override
  String get errorMicBusy =>
      'Мікрафон зараз заняты, напрыклад тэлефонным званком. Паспрабуй яшчэ раз пасля размовы.';

  @override
  String errorRecorderStart(String detail) {
    return 'Не ўдалося пачаць запіс ($detail).';
  }

  @override
  String errorRecorderStop(String detail) {
    return 'Не ўдалося спыніць запіс ($detail).';
  }

  @override
  String errorTranscription(String detail) {
    return 'Не ўдалося расшыфраваць ($detail). Запіс захаваны, яго можна распазнаць зноў.';
  }

  @override
  String errorRetranscribe(String detail) {
    return 'Не ўдалося распазнаць зноў ($detail).';
  }

  @override
  String errorModelLoad(String model, String detail) {
    return 'Не ўдалося загрузіць $model. Калі гэта паўтараецца, выдалі мадэль і спампуй яе зноў. ($detail)';
  }

  @override
  String get errorNoModel => 'Мадэль не загружана.';

  @override
  String downloadAlreadyRunning(String model) {
    return '$model ужо спампоўваецца.';
  }

  @override
  String get downloadCancelled => 'Спампоўка скасавана.';

  @override
  String get downloadNetworkError =>
      'Памылка спампоўкі. Правер падключэнне да інтэрнэту і паспрабуй яшчэ раз.';

  @override
  String get downloadNotModelFile =>
      'Сервер не вярнуў файл мадэлі (магчыма, старонку ўваходу Wi-Fi). Правер сетку і паспрабуй яшчэ раз.';

  @override
  String downloadCorrupt(String file) {
    return 'Спампаваны файл $file пашкоджаны. Паспрабуй яшчэ раз.';
  }

  @override
  String downloadNoSpace(String model) {
    return 'Недастаткова месца для $model.';
  }
}
