// ignore: unused_import
import 'package:intl/intl.dart' as intl;

import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Basque (`eu`).
class AppLocalizationsEu extends AppLocalizations {
  AppLocalizationsEu([String locale = 'eu']) : super(locale);

  @override
  String get logoSemantics => 'Talkpuppy-ren logoa';

  @override
  String startupFailed(String error) {
    return 'Ezin izan da Talkpuppy abiarazi:\n$error';
  }

  @override
  String get settingsTooltip => 'Ezarpenak';

  @override
  String get switchModelTooltip => 'Aldatu eredua';

  @override
  String get manageModelsEllipsis => 'Kudeatu ereduak…';

  @override
  String get manageModels => 'Kudeatu ereduak';

  @override
  String get installModel => 'Instalatu eredua';

  @override
  String get noModel => 'Eredurik ez';

  @override
  String get ok => 'Ados';

  @override
  String get cancel => 'Utzi';

  @override
  String get delete => 'Ezabatu';

  @override
  String get copy => 'Kopiatu';

  @override
  String get record => 'Grabatu';

  @override
  String get stopRecording => 'Gelditu';

  @override
  String get transcribing => 'Transkribatzen…';

  @override
  String get newRecording => 'Grabazio berria';

  @override
  String get continueRecording => 'Jarraitu grabatzen';

  @override
  String get transcriptLabel => 'Transkripzioa';

  @override
  String get emptyTranscript =>
      'Oraindik ez dago grabaziorik.\nSakatu beheko mikrofonoa.';

  @override
  String get noTextRecognized => '(ez da testurik ezagutu)';

  @override
  String get retranscribe => 'Transkribatu berriro';

  @override
  String get today => 'Gaur';

  @override
  String get yesterday => 'Atzo';

  @override
  String get welcomeTitle => 'Ongi etorri Talkpuppy-ra';

  @override
  String get welcomeBody =>
      'Aukeratu transkripziorako hizketa-eredu bat. Zure gailuan bertan exekutatzen da osorik, Interneterik gabe.';

  @override
  String get recommended => 'Gomendatua';

  @override
  String get preparing => 'Prestatzen…';

  @override
  String sizeMb(int size) {
    return '$size MB';
  }

  @override
  String downloadProgress(int received, int total) {
    return '$received MB / $total MB';
  }

  @override
  String get downloadAndStart => 'Deskargatu eta hasi';

  @override
  String get download => 'Deskargatu';

  @override
  String downloadFailed(String error) {
    return 'Ezin izan da deskargatu: $error';
  }

  @override
  String get modelsTitle => 'Ereduak';

  @override
  String get deleteModelTitle => 'Eredua ezabatu?';

  @override
  String deleteModelBody(String model, int size) {
    return '$model gailu honetatik ezabatuko da ($size MB).';
  }

  @override
  String get modelDescParakeet =>
      'Oso zehatza eta azkarra. Testua grabazioa gelditzean agertzen da. Europako 25 hizkuntza, automatikoki hautemanak; hizkuntza ezin da finkatu. Deskarga handia, gutxienez 6 GB RAM dituzten telefonoetarako.';

  @override
  String get modelDescWhisperSmall =>
      'Hizkuntza gehien (99), automatikoki hautemanak edo finkatuak. Zehaztasun ona, baina Parakeet baino motelagoa, eta isiltasunean edo zaratan batzuetan hitzak asma ditzake. Gutxienez 4 GB RAM dituzten telefonoetarako.';

  @override
  String get modelDescWhisperBase =>
      'Deskarga txikia telefono zaharretarako. 99 hizkuntza, automatikoki hautemanak edo finkatuak. Whisper Small baino nabarmen zehaztasun txikiagokoa. Gutxienez 3 GB RAM dituzten telefonoetarako.';

  @override
  String get modelDescWhisperTiny =>
      'Txikiena eta azkarrena, ia edozein telefonotan dabil. 99 hizkuntza, automatikoki hautemanak edo finkatuak. Zehaztasun txikienekoa, argi esandako ohar laburretarako egokiena.';

  @override
  String get modelDescNemotron =>
      'Zuzeneko aurrebista: testua hitz egin ahala agertzen da eta gelditu bezain laster prest dago. 28 hizkuntza, automatikoki hautemanak edo finkatuak. Normalean Parakeet baino zehaztasun apur bat txikiagokoa. Deskarga handia, gutxienez 6 GB RAM dituzten telefonoetarako.';

  @override
  String get livePreviewLabel => 'Zuzeneko aurrebista';

  @override
  String get livePreviewListening => 'Entzuten…';

  @override
  String get languageLabel => 'Hizkuntza';

  @override
  String get auto => 'Auto';

  @override
  String get modelLabel => 'Eredua';

  @override
  String get whisperRequired =>
      'Hizkuntza finko baterako Whisper edo Nemotron eredu bat behar da.';

  @override
  String get downloadWhisperSmall => 'Deskargatu Whisper Small';

  @override
  String get settingsTitle => 'Ezarpenak';

  @override
  String get appLanguageTitle => 'Aplikazioaren hizkuntza';

  @override
  String get appLanguageSystem => 'Sistemaren lehenetsia';

  @override
  String get autoCopyTitle => 'Kopiatu automatikoki';

  @override
  String get autoCopySubtitle =>
      'Jarri testua arbelean transkripzioa amaitu bezain laster';

  @override
  String get hapticsTitle => 'Erantzun haptikoa';

  @override
  String get minimizeToOverlay => 'Minimizatu eta erakutsi gainjartzea';

  @override
  String get overlaySetupTitle => 'Aktibatu erabilerraztasun-zerbitzua';

  @override
  String get overlaySetupBody =>
      'Botoia beste aplikazioen gainean erakusteko eta testua kurtsorearen lekuan txertatzeko, Talkpuppy-k bere erabilerraztasun-zerbitzua behar du. Idazten ari zaren eremua soilik irakurtzen du, eta testua txertatzeko soilik. Ez du pantailan beste ezer irakurtzen, ez du beste aplikazioetako ezer gordetzen eta ez du ezer inora bidaltzen.\n\nHurrengo pantailan, ireki «Talkpuppy» eta aktibatu.';

  @override
  String get overlaySetupShortcut =>
      'Aktibatu Talkpuppy-ren etengailua soilik eta utzi «Lasterbidea» desaktibatuta: botoia berez agertzen da.';

  @override
  String get shortcutHint =>
      'Talkpuppy-ren «Lasterbidea» aktibatuta dago; horregatik, Android-ek aplikazioaren ikonoa pantailaren ertzean finkatzen du. Ez duzu behar: botoi flotagarria berez agertzen da. Desaktibatu «Lasterbidea» Talkpuppy-ren erabilerraztasun-ezarpenetan.';

  @override
  String get shortcutHintAction => 'Ireki Talkpuppy-ren ezarpenak';

  @override
  String get overlayOpenAccessibility => 'Ireki erabilerraztasun-ezarpenak';

  @override
  String get overlayRestrictedHint =>
      'Etengailua grisez dago? Ireki Aplikazioari buruzko informazioa → ⋮ → «Eman ezarpen murriztuak erabiltzeko baimena» eta saiatu berriro.';

  @override
  String get defaultLanguageTitle => 'Grabazio berrien hizkuntza lehenetsia';

  @override
  String get defaultLanguageHint =>
      'Whisper eta Nemotron ereduek erabiltzen dute; Parakeet-ek beti hautematen du hizkuntza automatikoki.';

  @override
  String get licensesTitle => 'Lizentziak';

  @override
  String get licensesSubtitle => 'Erabilitako softwarea eta ereduak';

  @override
  String get licensesLegalese =>
      'Ahots-ezagutza sherpa-onnx, Parakeet (NVIDIA, CC BY 4.0), Nemotron (NVIDIA, OpenMDW 1.1) eta Whisper (OpenAI, MIT) bidez.';

  @override
  String get licensesIntro =>
      'Talkpuppy kode irekiko softwarean eta lizentzia irekiko hizketa-ereduetan oinarritzen da.';

  @override
  String get licensesSpeechModels => 'Hizketa-ereduak';

  @override
  String get licensesSoftware => 'Softwarea';

  @override
  String get licensesPackages => 'Flutter eta kode irekiko beste pakete batzuk';

  @override
  String get licensesShowAll => 'Erakutsi lizentzia-testu guztiak';

  @override
  String get deleteAllTitle => 'Ezabatu grabazio guztiak';

  @override
  String get deleteAllConfirmTitle => 'Grabazio guztiak ezabatu?';

  @override
  String get deleteAllConfirmBody =>
      'Transkripzio eta grabazio guztiak betiko ezabatuko dira.';

  @override
  String get errorMicPermission =>
      'Ez dago mikrofonorako sarbiderik. Eman baimena telefonoaren ezarpenetan.';

  @override
  String get errorMicBusy =>
      'Mikrofonoa erabiltzen ari dira orain, adibidez dei batek. Saiatu berriro deiaren ondoren.';

  @override
  String errorRecorderStart(String detail) {
    return 'Ezin izan da grabatzen hasi ($detail).';
  }

  @override
  String errorRecorderStop(String detail) {
    return 'Ezin izan da grabazioa gelditu ($detail).';
  }

  @override
  String errorTranscription(String detail) {
    return 'Ezin izan da transkribatu ($detail). Grabazioa gordeta dago eta berriro transkriba daiteke.';
  }

  @override
  String errorRetranscribe(String detail) {
    return 'Ezin izan da berriro transkribatu ($detail).';
  }

  @override
  String errorModelLoad(String model, String detail) {
    return 'Ezin izan da $model kargatu. Berriro gertatzen bada, ezabatu eredua eta deskargatu berriro. ($detail)';
  }

  @override
  String get errorNoModel => 'Ez dago eredurik kargatuta.';

  @override
  String downloadAlreadyRunning(String model) {
    return '$model deskargatzen ari da dagoeneko.';
  }

  @override
  String get downloadCancelled => 'Deskarga bertan behera utzi da.';

  @override
  String get downloadNetworkError =>
      'Ezin izan da deskargatu. Egiaztatu Interneteko konexioa eta saiatu berriro.';

  @override
  String get downloadNotModelFile =>
      'Zerbitzariak ez du eredu-fitxategirik itzuli (agian wifi-saioa hasteko orri bat). Egiaztatu sarea eta saiatu berriro.';

  @override
  String downloadCorrupt(String file) {
    return 'Deskargatutako $file fitxategia hondatuta dago. Saiatu berriro.';
  }

  @override
  String downloadNoSpace(String model) {
    return 'Ez dago leku nahikorik $model gordetzeko.';
  }
}
