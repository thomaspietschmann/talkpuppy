// ignore: unused_import
import 'package:intl/intl.dart' as intl;

import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Czech (`cs`).
class AppLocalizationsCs extends AppLocalizations {
  AppLocalizationsCs([String locale = 'cs']) : super(locale);

  @override
  String get logoSemantics => 'Logo Talkpuppy';

  @override
  String startupFailed(String error) {
    return 'Talkpuppy se nepodařilo spustit:\n$error';
  }

  @override
  String get settingsTooltip => 'Nastavení';

  @override
  String get switchModelTooltip => 'Změnit model';

  @override
  String get manageModelsEllipsis => 'Spravovat modely…';

  @override
  String get manageModels => 'Spravovat modely';

  @override
  String get installModel => 'Nainstalovat model';

  @override
  String get noModel => 'Žádný model';

  @override
  String get ok => 'OK';

  @override
  String get cancel => 'Zrušit';

  @override
  String get delete => 'Smazat';

  @override
  String get copy => 'Kopírovat';

  @override
  String get record => 'Nahrát';

  @override
  String get stopRecording => 'Zastavit';

  @override
  String get transcribing => 'Přepisuji…';

  @override
  String get newRecording => 'Nová nahrávka';

  @override
  String get continueRecording => 'Nahrávat dál';

  @override
  String get transcriptLabel => 'Přepis';

  @override
  String get emptyTranscript =>
      'Zatím žádná nahrávka.\nKlepni na mikrofon dole.';

  @override
  String get noTextRecognized => '(nebyl rozpoznán žádný text)';

  @override
  String get retranscribe => 'Přepsat znovu';

  @override
  String get today => 'Dnes';

  @override
  String get yesterday => 'Včera';

  @override
  String get welcomeTitle => 'Vítej v Talkpuppy';

  @override
  String get welcomeBody =>
      'Vyber si řečový model pro přepis. Běží celý na tvém zařízení, bez internetu.';

  @override
  String get recommended => 'Doporučeno';

  @override
  String get preparing => 'Připravuji…';

  @override
  String sizeMb(int size) {
    return '$size MB';
  }

  @override
  String downloadProgress(int received, int total) {
    return '$received MB / $total MB';
  }

  @override
  String get downloadAndStart => 'Stáhnout a začít';

  @override
  String get download => 'Stáhnout';

  @override
  String downloadFailed(String error) {
    return 'Stahování selhalo: $error';
  }

  @override
  String get modelsTitle => 'Modely';

  @override
  String get deleteModelTitle => 'Smazat model?';

  @override
  String deleteModelBody(String model, int size) {
    return '$model bude z tohoto zařízení smazán ($size MB).';
  }

  @override
  String get modelDescParakeet =>
      'Velmi přesný a rychlý. Text se zobrazí, jakmile nahrávání ukončíš. 25 evropských jazyků, rozpoznávaných automaticky; jazyk nelze pevně nastavit. Velké stahování, pro telefony s alespoň 6 GB RAM.';

  @override
  String get modelDescWhisperSmall =>
      'Nejvíce jazyků (99), rozpoznávaných automaticky nebo pevně nastavených. Dobrá přesnost, ale pomalejší než Parakeet a při tichu nebo šumu si občas může vymýšlet slova. Pro telefony s alespoň 4 GB RAM.';

  @override
  String get modelDescWhisperBase =>
      'Malé stahování pro starší telefony. 99 jazyků, rozpoznávaných automaticky nebo pevně nastavených. Znatelně méně přesný než Whisper Small. Pro telefony s alespoň 3 GB RAM.';

  @override
  String get modelDescWhisperTiny =>
      'Nejmenší a nejrychlejší, poběží prakticky na každém telefonu. 99 jazyků, rozpoznávaných automaticky nebo pevně nastavených. Nejméně přesný, nejlepší pro krátké, zřetelně namluvené poznámky.';

  @override
  String get modelDescNemotron =>
      'Živý náhled: text se zobrazuje už během mluvení a je hotový, jakmile přestaneš. 28 jazyků, rozpoznávaných automaticky nebo pevně nastavených. Obvykle o něco méně přesný než Parakeet. Velké stahování, pro telefony s alespoň 6 GB RAM.';

  @override
  String get livePreviewLabel => 'Živý náhled';

  @override
  String get livePreviewListening => 'Poslouchám…';

  @override
  String get languageLabel => 'Jazyk';

  @override
  String get auto => 'Auto';

  @override
  String get modelLabel => 'Model';

  @override
  String get whisperRequired =>
      'Pevně nastavený jazyk vyžaduje model Whisper nebo Nemotron.';

  @override
  String get downloadWhisperSmall => 'Stáhnout Whisper Small';

  @override
  String get settingsTitle => 'Nastavení';

  @override
  String get appLanguageTitle => 'Jazyk aplikace';

  @override
  String get appLanguageSystem => 'Podle systému';

  @override
  String get autoCopyTitle => 'Kopírovat automaticky';

  @override
  String get autoCopySubtitle => 'Vložit text do schránky hned po přepisu';

  @override
  String get hapticsTitle => 'Haptická odezva';

  @override
  String get defaultLanguageTitle => 'Výchozí jazyk nových nahrávek';

  @override
  String get defaultLanguageHint =>
      'Používají ho modely Whisper a Nemotron; Parakeet jazyk vždy rozpozná automaticky.';

  @override
  String get licensesTitle => 'Licence';

  @override
  String get licensesSubtitle => 'Použitý software a modely';

  @override
  String get licensesLegalese =>
      'Rozpoznávání řeči pomocí sherpa-onnx, Parakeet (NVIDIA, CC BY 4.0), Nemotron (NVIDIA, OpenMDW 1.1) a Whisper (OpenAI, MIT).';

  @override
  String get licensesIntro =>
      'Talkpuppy stojí na open-source softwaru a řečových modelech s otevřenými licencemi.';

  @override
  String get licensesSpeechModels => 'Řečové modely';

  @override
  String get licensesSoftware => 'Software';

  @override
  String get licensesPackages => 'Flutter a další open-source balíčky';

  @override
  String get licensesShowAll => 'Zobrazit všechny licenční texty';

  @override
  String get deleteAllTitle => 'Smazat všechny nahrávky';

  @override
  String get deleteAllConfirmTitle => 'Smazat všechny nahrávky?';

  @override
  String get deleteAllConfirmBody =>
      'Všechny přepisy a nahrávky budou trvale smazány.';

  @override
  String get errorMicPermission =>
      'Chybí přístup k mikrofonu. Povol ho prosím v nastavení telefonu.';

  @override
  String errorRecorderStart(String detail) {
    return 'Nahrávání se nepodařilo spustit ($detail).';
  }

  @override
  String errorRecorderStop(String detail) {
    return 'Nahrávání se nepodařilo zastavit ($detail).';
  }

  @override
  String errorTranscription(String detail) {
    return 'Přepis selhal ($detail). Nahrávka je uložená a lze ji přepsat znovu.';
  }

  @override
  String errorRetranscribe(String detail) {
    return 'Opakovaný přepis selhal ($detail).';
  }

  @override
  String errorModelLoad(String model, String detail) {
    return 'Model $model se nepodařilo načíst. Pokud se to opakuje, smaž model a stáhni ho znovu. ($detail)';
  }

  @override
  String get errorNoModel => 'Není načten žádný model.';

  @override
  String downloadAlreadyRunning(String model) {
    return '$model se už stahuje.';
  }

  @override
  String get downloadCancelled => 'Stahování zrušeno.';

  @override
  String get downloadNetworkError =>
      'Stahování selhalo. Zkontroluj připojení k internetu a zkus to znovu.';

  @override
  String get downloadNotModelFile =>
      'Server nevrátil soubor modelu (možná přihlašovací stránka Wi-Fi). Zkontroluj síť a zkus to znovu.';

  @override
  String downloadCorrupt(String file) {
    return 'Stažený soubor $file je poškozený. Zkus to prosím znovu.';
  }

  @override
  String downloadNoSpace(String model) {
    return 'Nedostatek místa pro $model.';
  }
}
