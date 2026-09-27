// ignore: unused_import
import 'package:intl/intl.dart' as intl;

import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Hungarian (`hu`).
class AppLocalizationsHu extends AppLocalizations {
  AppLocalizationsHu([String locale = 'hu']) : super(locale);

  @override
  String get logoSemantics => 'Talkpuppy logó';

  @override
  String startupFailed(String error) {
    return 'A Talkpuppy nem tudott elindulni:\n$error';
  }

  @override
  String get settingsTooltip => 'Beállítások';

  @override
  String get switchModelTooltip => 'Modell váltása';

  @override
  String get manageModelsEllipsis => 'Modellek kezelése…';

  @override
  String get manageModels => 'Modellek kezelése';

  @override
  String get installModel => 'Modell telepítése';

  @override
  String get noModel => 'Nincs modell';

  @override
  String get ok => 'OK';

  @override
  String get cancel => 'Mégse';

  @override
  String get delete => 'Törlés';

  @override
  String get copy => 'Másolás';

  @override
  String get record => 'Felvétel';

  @override
  String get stopRecording => 'Leállítás';

  @override
  String get transcribing => 'Átírás…';

  @override
  String get newRecording => 'Új felvétel';

  @override
  String get continueRecording => 'Folytatás';

  @override
  String get transcriptLabel => 'Átirat';

  @override
  String get emptyTranscript =>
      'Még nincs felvétel.\nKoppints lent a mikrofonra.';

  @override
  String get noTextRecognized => '(nem ismerhető fel szöveg)';

  @override
  String get retranscribe => 'Újraátírás';

  @override
  String get today => 'Ma';

  @override
  String get yesterday => 'Tegnap';

  @override
  String get welcomeTitle => 'Üdv a Talkpuppyban';

  @override
  String get welcomeBody =>
      'Válassz egy beszédmodellt az átíráshoz. Teljesen a készülékeden fut, internet nélkül.';

  @override
  String get recommended => 'Ajánlott';

  @override
  String get preparing => 'Előkészítés…';

  @override
  String sizeMb(int size) {
    return '$size MB';
  }

  @override
  String downloadProgress(int received, int total) {
    return '$received MB / $total MB';
  }

  @override
  String get downloadAndStart => 'Letöltés és indulás';

  @override
  String get download => 'Letöltés';

  @override
  String downloadFailed(String error) {
    return 'A letöltés sikertelen: $error';
  }

  @override
  String get modelsTitle => 'Modellek';

  @override
  String get deleteModelTitle => 'Törlöd a modellt?';

  @override
  String deleteModelBody(String model, int size) {
    return 'A(z) $model törlődik erről a készülékről ($size MB).';
  }

  @override
  String get modelDescParakeet =>
      'Nagyon gyors és nagyon pontos, 25 európai nyelv, a nyelvet automatikusan felismeri. Legalább 6 GB RAM-mal rendelkező telefonokhoz ajánlott.';

  @override
  String get modelDescWhisperSmall =>
      'Egyensúly a sebesség és a pontosság között, 99 nyelv, a nyelv rögzíthető. Legalább 4 GB RAM-mal rendelkező telefonokhoz.';

  @override
  String get modelDescWhisperBase =>
      'Könnyű modell régebbi telefonokhoz, 99 nyelv, a nyelv rögzíthető. Legalább 3 GB RAM-mal rendelkező telefonokhoz.';

  @override
  String get modelDescWhisperTiny =>
      'Minimális és a leggyorsabban letölthető. 99 nyelv, a nyelv rögzíthető. Gyakorlatilag bármilyen telefonon fut.';

  @override
  String get languageLabel => 'Nyelv';

  @override
  String get auto => 'Automatikus';

  @override
  String get modelLabel => 'Modell';

  @override
  String get whisperRequired => 'Rögzített nyelvhez Whisper modell kell.';

  @override
  String get downloadWhisperSmall => 'Whisper Small letöltése';

  @override
  String get settingsTitle => 'Beállítások';

  @override
  String get appLanguageTitle => 'Alkalmazás nyelve';

  @override
  String get appLanguageSystem => 'Rendszer alapértelmezése';

  @override
  String get autoCopyTitle => 'Automatikus másolás';

  @override
  String get autoCopySubtitle =>
      'A szöveg az átírás után azonnal a vágólapra kerül';

  @override
  String get hapticsTitle => 'Haptikus visszajelzés';

  @override
  String get defaultLanguageTitle => 'Alapértelmezett nyelv új felvételekhez';

  @override
  String get defaultLanguageHint =>
      'Csak a Whisper modellek használják; a Parakeet mindig automatikusan ismeri fel a nyelvet.';

  @override
  String get licensesTitle => 'Licencek';

  @override
  String get licensesSubtitle => 'Használt szoftverek és modellek';

  @override
  String get licensesLegalese =>
      'Beszédfelismerés: sherpa-onnx, Parakeet (NVIDIA, CC BY 4.0) és Whisper (OpenAI, MIT).';

  @override
  String get deleteAllTitle => 'Összes felvétel törlése';

  @override
  String get deleteAllConfirmTitle => 'Törlöd az összes felvételt?';

  @override
  String get deleteAllConfirmBody =>
      'Minden átirat és felvétel véglegesen törlődik.';

  @override
  String get errorMicPermission =>
      'Nincs hozzáférés a mikrofonhoz. Engedélyezd a telefon beállításaiban.';

  @override
  String errorRecorderStart(String detail) {
    return 'Nem sikerült elindítani a felvételt ($detail).';
  }

  @override
  String errorRecorderStop(String detail) {
    return 'Nem sikerült leállítani a felvételt ($detail).';
  }

  @override
  String errorTranscription(String detail) {
    return 'Az átírás sikertelen ($detail). A felvétel mentve van, és újra átírható.';
  }

  @override
  String errorRetranscribe(String detail) {
    return 'Az újraátírás sikertelen ($detail).';
  }

  @override
  String errorModelLoad(String model, String detail) {
    return 'A(z) $model nem tölthető be. Ha ez továbbra is előfordul, töröld a modellt, és töltsd le újra. ($detail)';
  }

  @override
  String get errorNoModel => 'Nincs betöltött modell.';

  @override
  String downloadAlreadyRunning(String model) {
    return 'A(z) $model letöltése már folyamatban van.';
  }

  @override
  String get downloadCancelled => 'Letöltés megszakítva.';

  @override
  String get downloadNetworkError =>
      'A letöltés sikertelen. Ellenőrizd az internetkapcsolatot, és próbáld újra.';

  @override
  String get downloadNotModelFile =>
      'A szerver nem modellfájlt küldött (talán egy Wi-Fi bejelentkezési oldalt). Ellenőrizd a hálózatot, és próbáld újra.';

  @override
  String downloadCorrupt(String file) {
    return 'A letöltött $file fájl sérült. Próbáld újra.';
  }

  @override
  String downloadNoSpace(String model) {
    return 'Nincs elég tárhely a(z) $model számára.';
  }
}
