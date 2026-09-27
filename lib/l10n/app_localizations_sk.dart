// ignore: unused_import
import 'package:intl/intl.dart' as intl;

import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Slovak (`sk`).
class AppLocalizationsSk extends AppLocalizations {
  AppLocalizationsSk([String locale = 'sk']) : super(locale);

  @override
  String get logoSemantics => 'Logo Talkpuppy';

  @override
  String startupFailed(String error) {
    return 'Talkpuppy sa nepodarilo spustiť:\n$error';
  }

  @override
  String get settingsTooltip => 'Nastavenia';

  @override
  String get switchModelTooltip => 'Zmeniť model';

  @override
  String get manageModelsEllipsis => 'Spravovať modely…';

  @override
  String get manageModels => 'Spravovať modely';

  @override
  String get installModel => 'Nainštalovať model';

  @override
  String get noModel => 'Žiadny model';

  @override
  String get ok => 'OK';

  @override
  String get cancel => 'Zrušiť';

  @override
  String get delete => 'Odstrániť';

  @override
  String get copy => 'Kopírovať';

  @override
  String get record => 'Nahrávať';

  @override
  String get stopRecording => 'Zastaviť';

  @override
  String get transcribing => 'Prepisujem…';

  @override
  String get newRecording => 'Nová nahrávka';

  @override
  String get continueRecording => 'Nahrávať ďalej';

  @override
  String get transcriptLabel => 'Prepis';

  @override
  String get emptyTranscript =>
      'Zatiaľ žiadna nahrávka.\nŤukni na mikrofón dole.';

  @override
  String get noTextRecognized => '(nebol rozpoznaný žiadny text)';

  @override
  String get retranscribe => 'Prepísať znova';

  @override
  String get today => 'Dnes';

  @override
  String get yesterday => 'Včera';

  @override
  String get welcomeTitle => 'Vitaj v Talkpuppy';

  @override
  String get welcomeBody =>
      'Vyber si rečový model na prepis. Beží celý v tvojom zariadení, bez internetu.';

  @override
  String get recommended => 'Odporúčané';

  @override
  String get preparing => 'Pripravujem…';

  @override
  String sizeMb(int size) {
    return '$size MB';
  }

  @override
  String downloadProgress(int received, int total) {
    return '$received MB / $total MB';
  }

  @override
  String get downloadAndStart => 'Stiahnuť a začať';

  @override
  String get download => 'Stiahnuť';

  @override
  String downloadFailed(String error) {
    return 'Sťahovanie zlyhalo: $error';
  }

  @override
  String get modelsTitle => 'Modely';

  @override
  String get deleteModelTitle => 'Odstrániť model?';

  @override
  String deleteModelBody(String model, int size) {
    return '$model bude z tohto zariadenia odstránený ($size MB).';
  }

  @override
  String get modelDescParakeet =>
      'Veľmi rýchly a veľmi presný, 25 európskych jazykov, jazyk rozpozná automaticky. Odporúčaný pre telefóny s aspoň 6 GB RAM.';

  @override
  String get modelDescWhisperSmall =>
      'Vyvážený pomer rýchlosti a presnosti, 99 jazykov, jazyk sa dá pevne nastaviť. Pre telefóny s aspoň 4 GB RAM.';

  @override
  String get modelDescWhisperBase =>
      'Nenáročný pre staršie telefóny, 99 jazykov, jazyk sa dá pevne nastaviť. Pre telefóny s aspoň 3 GB RAM.';

  @override
  String get modelDescWhisperTiny =>
      'Najmenší a najrýchlejšie stiahnutý. 99 jazykov, jazyk sa dá pevne nastaviť. Pobeží prakticky na každom telefóne.';

  @override
  String get languageLabel => 'Jazyk';

  @override
  String get auto => 'Auto';

  @override
  String get modelLabel => 'Model';

  @override
  String get whisperRequired => 'Pevne nastavený jazyk vyžaduje model Whisper.';

  @override
  String get downloadWhisperSmall => 'Stiahnuť Whisper Small';

  @override
  String get settingsTitle => 'Nastavenia';

  @override
  String get appLanguageTitle => 'Jazyk aplikácie';

  @override
  String get appLanguageSystem => 'Podľa systému';

  @override
  String get autoCopyTitle => 'Kopírovať automaticky';

  @override
  String get autoCopySubtitle => 'Vložiť text do schránky hneď po prepise';

  @override
  String get hapticsTitle => 'Hmatová odozva';

  @override
  String get defaultLanguageTitle => 'Predvolený jazyk nových nahrávok';

  @override
  String get defaultLanguageHint =>
      'Používajú ho iba modely Whisper; Parakeet jazyk vždy rozpozná automaticky.';

  @override
  String get licensesTitle => 'Licencie';

  @override
  String get licensesSubtitle => 'Použitý softvér a modely';

  @override
  String get licensesLegalese =>
      'Rozpoznávanie reči pomocou sherpa-onnx, Parakeet (NVIDIA, CC BY 4.0) a Whisper (OpenAI, MIT).';

  @override
  String get deleteAllTitle => 'Odstrániť všetky nahrávky';

  @override
  String get deleteAllConfirmTitle => 'Odstrániť všetky nahrávky?';

  @override
  String get deleteAllConfirmBody =>
      'Všetky prepisy a nahrávky budú natrvalo odstránené.';

  @override
  String get errorMicPermission =>
      'Chýba prístup k mikrofónu. Povoľ ho v nastaveniach telefónu.';

  @override
  String errorRecorderStart(String detail) {
    return 'Nahrávanie sa nepodarilo spustiť ($detail).';
  }

  @override
  String errorRecorderStop(String detail) {
    return 'Nahrávanie sa nepodarilo zastaviť ($detail).';
  }

  @override
  String errorTranscription(String detail) {
    return 'Prepis zlyhal ($detail). Nahrávka je uložená a dá sa prepísať znova.';
  }

  @override
  String errorRetranscribe(String detail) {
    return 'Opätovný prepis zlyhal ($detail).';
  }

  @override
  String errorModelLoad(String model, String detail) {
    return 'Model $model sa nepodarilo načítať. Ak sa to opakuje, odstráň model a stiahni ho znova. ($detail)';
  }

  @override
  String get errorNoModel => 'Nie je načítaný žiadny model.';

  @override
  String downloadAlreadyRunning(String model) {
    return '$model sa už sťahuje.';
  }

  @override
  String get downloadCancelled => 'Sťahovanie zrušené.';

  @override
  String get downloadNetworkError =>
      'Sťahovanie zlyhalo. Skontroluj pripojenie k internetu a skús to znova.';

  @override
  String get downloadNotModelFile =>
      'Server nevrátil súbor modelu (možno prihlasovacia stránka Wi-Fi). Skontroluj sieť a skús to znova.';

  @override
  String downloadCorrupt(String file) {
    return 'Stiahnutý súbor $file je poškodený. Skús to znova.';
  }

  @override
  String downloadNoSpace(String model) {
    return 'Nedostatok miesta pre $model.';
  }
}
