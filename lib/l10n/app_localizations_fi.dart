// ignore: unused_import
import 'package:intl/intl.dart' as intl;

import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Finnish (`fi`).
class AppLocalizationsFi extends AppLocalizations {
  AppLocalizationsFi([String locale = 'fi']) : super(locale);

  @override
  String get logoSemantics => 'Talkpuppy-logo';

  @override
  String startupFailed(String error) {
    return 'Talkpuppyn käynnistys epäonnistui:\n$error';
  }

  @override
  String get settingsTooltip => 'Asetukset';

  @override
  String get switchModelTooltip => 'Vaihda malli';

  @override
  String get manageModelsEllipsis => 'Hallitse malleja…';

  @override
  String get manageModels => 'Hallitse malleja';

  @override
  String get installModel => 'Asenna malli';

  @override
  String get noModel => 'Ei mallia';

  @override
  String get ok => 'OK';

  @override
  String get cancel => 'Peruuta';

  @override
  String get delete => 'Poista';

  @override
  String get copy => 'Kopioi';

  @override
  String get record => 'Nauhoita';

  @override
  String get stopRecording => 'Lopeta';

  @override
  String get transcribing => 'Litteroidaan…';

  @override
  String get newRecording => 'Uusi nauhoitus';

  @override
  String get continueRecording => 'Jatka nauhoitusta';

  @override
  String get transcriptLabel => 'Litterointi';

  @override
  String get emptyTranscript =>
      'Ei vielä nauhoituksia.\nNapauta alla olevaa mikrofonia.';

  @override
  String get noTextRecognized => '(tekstiä ei tunnistettu)';

  @override
  String get retranscribe => 'Litteroi uudelleen';

  @override
  String get today => 'Tänään';

  @override
  String get yesterday => 'Eilen';

  @override
  String get welcomeTitle => 'Tervetuloa Talkpuppyyn';

  @override
  String get welcomeBody =>
      'Valitse puhemalli litterointia varten. Se toimii kokonaan laitteellasi, eikä internetyhteyttä tarvita.';

  @override
  String get recommended => 'Suositeltu';

  @override
  String get preparing => 'Valmistellaan…';

  @override
  String sizeMb(int size) {
    return '$size MB';
  }

  @override
  String downloadProgress(int received, int total) {
    return '$received MB / $total MB';
  }

  @override
  String get downloadAndStart => 'Lataa ja aloita';

  @override
  String get download => 'Lataa';

  @override
  String downloadFailed(String error) {
    return 'Lataus epäonnistui: $error';
  }

  @override
  String get modelsTitle => 'Mallit';

  @override
  String get deleteModelTitle => 'Poistetaanko malli?';

  @override
  String deleteModelBody(String model, int size) {
    return '$model poistetaan tältä laitteelta ($size MB).';
  }

  @override
  String get modelDescParakeet =>
      'Erittäin tarkka ja nopea. Teksti tulee näkyviin, kun lopetat nauhoituksen. 25 eurooppalaista kieltä, tunnistetaan automaattisesti; kieltä ei voi lukita. Suuri lataus, puhelimille, joissa on vähintään 6 GB RAM-muistia.';

  @override
  String get modelDescWhisperSmall =>
      'Eniten kieliä (99), tunnistetaan automaattisesti tai lukitaan. Hyvä tarkkuus, mutta hitaampi kuin Parakeet, ja hiljaisuudessa tai melussa se voi joskus keksiä sanoja. Puhelimille, joissa on vähintään 4 GB RAM-muistia.';

  @override
  String get modelDescWhisperBase =>
      'Pieni lataus vanhemmille puhelimille. 99 kieltä, tunnistetaan automaattisesti tai lukitaan. Selvästi epätarkempi kuin Whisper Small. Puhelimille, joissa on vähintään 3 GB RAM-muistia.';

  @override
  String get modelDescWhisperTiny =>
      'Pienin ja nopein, toimii käytännössä kaikilla puhelimilla. 99 kieltä, tunnistetaan automaattisesti tai lukitaan. Epätarkin, sopii parhaiten lyhyisiin, selkeästi sanottuihin muistiinpanoihin.';

  @override
  String get modelDescNemotron =>
      'Reaaliaikainen esikatselu: teksti näkyy jo puhuessasi ja on valmis heti, kun lopetat. 28 kieltä, tunnistetaan automaattisesti tai lukitaan. Yleensä hieman epätarkempi kuin Parakeet. Suuri lataus, puhelimille, joissa on vähintään 6 GB RAM-muistia.';

  @override
  String get livePreviewLabel => 'Reaaliaikainen esikatselu';

  @override
  String get livePreviewListening => 'Kuunnellaan…';

  @override
  String get languageLabel => 'Kieli';

  @override
  String get auto => 'Auto';

  @override
  String get modelLabel => 'Malli';

  @override
  String get whisperRequired =>
      'Kiinteä kieli vaatii Whisper- tai Nemotron-mallin.';

  @override
  String get downloadWhisperSmall => 'Lataa Whisper Small';

  @override
  String get settingsTitle => 'Asetukset';

  @override
  String get appLanguageTitle => 'Sovelluksen kieli';

  @override
  String get appLanguageSystem => 'Järjestelmän oletus';

  @override
  String get autoCopyTitle => 'Kopioi automaattisesti';

  @override
  String get autoCopySubtitle =>
      'Siirrä teksti leikepöydälle heti litteroinnin jälkeen';

  @override
  String get hapticsTitle => 'Värinäpalaute';

  @override
  String get defaultLanguageTitle => 'Uusien nauhoitusten oletuskieli';

  @override
  String get defaultLanguageHint =>
      'Koskee Whisper- ja Nemotron-malleja; Parakeet tunnistaa kielen aina automaattisesti.';

  @override
  String get licensesTitle => 'Lisenssit';

  @override
  String get licensesSubtitle => 'Käytetyt ohjelmistot ja mallit';

  @override
  String get licensesLegalese =>
      'Puheentunnistus: sherpa-onnx, Parakeet (NVIDIA, CC BY 4.0), Nemotron (NVIDIA, OpenMDW 1.1) ja Whisper (OpenAI, MIT).';

  @override
  String get licensesIntro =>
      'Talkpuppy perustuu avoimen lähdekoodin ohjelmistoihin ja avoimesti lisensoituihin puhemalleihin.';

  @override
  String get licensesSpeechModels => 'Puhemallit';

  @override
  String get licensesSoftware => 'Ohjelmistot';

  @override
  String get licensesPackages => 'Flutter ja muut avoimen lähdekoodin paketit';

  @override
  String get licensesShowAll => 'Näytä kaikki lisenssitekstit';

  @override
  String get deleteAllTitle => 'Poista kaikki nauhoitukset';

  @override
  String get deleteAllConfirmTitle => 'Poistetaanko kaikki nauhoitukset?';

  @override
  String get deleteAllConfirmBody =>
      'Kaikki litteroinnit ja nauhoitukset poistetaan pysyvästi.';

  @override
  String get errorMicPermission =>
      'Ei pääsyä mikrofoniin. Salli se puhelimen asetuksista.';

  @override
  String errorRecorderStart(String detail) {
    return 'Nauhoituksen aloitus epäonnistui ($detail).';
  }

  @override
  String errorRecorderStop(String detail) {
    return 'Nauhoituksen lopetus epäonnistui ($detail).';
  }

  @override
  String errorTranscription(String detail) {
    return 'Litterointi epäonnistui ($detail). Nauhoitus on tallennettu, ja sen voi litteroida uudelleen.';
  }

  @override
  String errorRetranscribe(String detail) {
    return 'Uudelleenlitterointi epäonnistui ($detail).';
  }

  @override
  String errorModelLoad(String model, String detail) {
    return 'Mallin $model lataaminen epäonnistui. Jos ongelma toistuu, poista malli ja lataa se uudelleen. ($detail)';
  }

  @override
  String get errorNoModel => 'Mallia ei ole ladattu.';

  @override
  String downloadAlreadyRunning(String model) {
    return 'Mallin $model lataus on jo käynnissä.';
  }

  @override
  String get downloadCancelled => 'Lataus peruttu.';

  @override
  String get downloadNetworkError =>
      'Lataus epäonnistui. Tarkista internetyhteys ja yritä uudelleen.';

  @override
  String get downloadNotModelFile =>
      'Palvelin ei palauttanut mallitiedostoa (ehkä Wi-Fi-kirjautumissivu). Tarkista verkkoyhteys ja yritä uudelleen.';

  @override
  String downloadCorrupt(String file) {
    return 'Ladattu tiedosto $file on vioittunut. Yritä uudelleen.';
  }

  @override
  String downloadNoSpace(String model) {
    return 'Tallennustila ei riitä mallille $model.';
  }
}
