// ignore: unused_import
import 'package:intl/intl.dart' as intl;

import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Latvian (`lv`).
class AppLocalizationsLv extends AppLocalizations {
  AppLocalizationsLv([String locale = 'lv']) : super(locale);

  @override
  String get logoSemantics => 'Talkpuppy logotips';

  @override
  String startupFailed(String error) {
    return 'Talkpuppy neizdevās palaist:\n$error';
  }

  @override
  String get settingsTooltip => 'Iestatījumi';

  @override
  String get switchModelTooltip => 'Mainīt modeli';

  @override
  String get manageModelsEllipsis => 'Pārvaldīt modeļus…';

  @override
  String get manageModels => 'Pārvaldīt modeļus';

  @override
  String get installModel => 'Instalēt modeli';

  @override
  String get noModel => 'Nav modeļa';

  @override
  String get ok => 'Labi';

  @override
  String get cancel => 'Atcelt';

  @override
  String get delete => 'Dzēst';

  @override
  String get copy => 'Kopēt';

  @override
  String get record => 'Ierakstīt';

  @override
  String get stopRecording => 'Apturēt';

  @override
  String get transcribing => 'Transkribē…';

  @override
  String get newRecording => 'Jauns ieraksts';

  @override
  String get continueRecording => 'Turpināt ierakstu';

  @override
  String get transcriptLabel => 'Teksts';

  @override
  String get emptyTranscript =>
      'Vēl nav ierakstu.\nPieskaries mikrofonam zemāk.';

  @override
  String get noTextRecognized => '(teksts netika atpazīts)';

  @override
  String get retranscribe => 'Atpazīt vēlreiz';

  @override
  String get today => 'Šodien';

  @override
  String get yesterday => 'Vakar';

  @override
  String get welcomeTitle => 'Laipni lūdzam Talkpuppy';

  @override
  String get welcomeBody =>
      'Izvēlies runas modeli transkripcijai. Tas darbojas tikai tavā ierīcē, internets nav vajadzīgs.';

  @override
  String get recommended => 'Ieteicams';

  @override
  String get preparing => 'Sagatavo…';

  @override
  String sizeMb(int size) {
    return '$size MB';
  }

  @override
  String downloadProgress(int received, int total) {
    return '$received MB / $total MB';
  }

  @override
  String get downloadAndStart => 'Lejupielādēt un sākt';

  @override
  String get download => 'Lejupielādēt';

  @override
  String downloadFailed(String error) {
    return 'Lejupielāde neizdevās: $error';
  }

  @override
  String get modelsTitle => 'Modeļi';

  @override
  String get deleteModelTitle => 'Dzēst modeli?';

  @override
  String deleteModelBody(String model, int size) {
    return '$model tiks izdzēsts no šīs ierīces ($size MB).';
  }

  @override
  String get modelDescParakeet =>
      'Ļoti precīzs un ātrs. Teksts parādās, kad aptur ierakstu. 25 Eiropas valodas, nosaka automātiski; valodu nevar fiksēt. Liela lejupielāde, tālruņiem ar vismaz 6 GB RAM.';

  @override
  String get modelDescWhisperSmall =>
      'Visvairāk valodu (99), nosaka automātiski vai var fiksēt. Laba precizitāte, bet lēnāks par Parakeet, un klusumā vai troksnī dažreiz var izdomāt vārdus. Tālruņiem ar vismaz 4 GB RAM.';

  @override
  String get modelDescWhisperBase =>
      'Neliela lejupielāde vecākiem tālruņiem. 99 valodas, nosaka automātiski vai var fiksēt. Manāmi mazāk precīzs nekā Whisper Small. Tālruņiem ar vismaz 3 GB RAM.';

  @override
  String get modelDescWhisperTiny =>
      'Mazākais un ātrākais, darbojas praktiski jebkurā tālrunī. 99 valodas, nosaka automātiski vai var fiksēt. Vismazāk precīzs, vislabāk piemērots īsām, skaidri izrunātām piezīmēm.';

  @override
  String get modelDescNemotron =>
      'Tiešraides priekšskatījums: teksts parādās jau runājot un ir gatavs, tiklīdz beidz. 28 valodas, nosaka automātiski vai var fiksēt. Parasti nedaudz mazāk precīzs nekā Parakeet. Liela lejupielāde, tālruņiem ar vismaz 6 GB RAM.';

  @override
  String get livePreviewLabel => 'Tiešraides priekšskatījums';

  @override
  String get livePreviewListening => 'Klausās…';

  @override
  String get languageLabel => 'Valoda';

  @override
  String get auto => 'Automātiski';

  @override
  String get modelLabel => 'Modelis';

  @override
  String get whisperRequired =>
      'Fiksētai valodai vajadzīgs Whisper vai Nemotron modelis.';

  @override
  String get downloadWhisperSmall => 'Lejupielādēt Whisper Small';

  @override
  String get settingsTitle => 'Iestatījumi';

  @override
  String get appLanguageTitle => 'Lietotnes valoda';

  @override
  String get appLanguageSystem => 'Sistēmas noklusējums';

  @override
  String get autoCopyTitle => 'Kopēt automātiski';

  @override
  String get autoCopySubtitle =>
      'Ievietot tekstu starpliktuvē uzreiz pēc transkripcijas';

  @override
  String get hapticsTitle => 'Haptiskā atgriezeniskā saite';

  @override
  String get minimizeToOverlay => 'Minimizēt un rādīt pārklājumu';

  @override
  String get overlaySetupTitle => 'Ieslēdz pieejamības pakalpojumu';

  @override
  String get overlaySetupBody =>
      'Lai poga varētu parādīties virs citām lietotnēm un teksts tiktu ievietots kursora vietā, Talkpuppy ir nepieciešams tās pieejamības pakalpojums. Tas lasa tikai lauku, kurā tu raksti, un tikai teksta ievietošanai. Tas ekrānā nelasa neko citu, nesaglabā neko no citām lietotnēm un nekur neko nesūta.\n\nNākamajā ekrānā atver “Talkpuppy” un ieslēdz to.';

  @override
  String get overlayOpenAccessibility => 'Atvērt pieejamības iestatījumus';

  @override
  String get overlayRestrictedHint =>
      'Slēdzis ir pelēks? Atver Lietotnes informācija → ⋮ → “Atļaut ierobežotos iestatījumus” un mēģini vēlreiz.';

  @override
  String get defaultLanguageTitle => 'Noklusējuma valoda jauniem ierakstiem';

  @override
  String get defaultLanguageHint =>
      'Izmanto Whisper un Nemotron; Parakeet vienmēr nosaka valodu automātiski.';

  @override
  String get licensesTitle => 'Licences';

  @override
  String get licensesSubtitle => 'Izmantotā programmatūra un modeļi';

  @override
  String get licensesLegalese =>
      'Runas atpazīšana ar sherpa-onnx, Parakeet (NVIDIA, CC BY 4.0), Nemotron (NVIDIA, OpenMDW 1.1) un Whisper (OpenAI, MIT).';

  @override
  String get licensesIntro =>
      'Talkpuppy balstās uz atvērtā koda programmatūru un runas modeļiem ar atvērtām licencēm.';

  @override
  String get licensesSpeechModels => 'Runas modeļi';

  @override
  String get licensesSoftware => 'Programmatūra';

  @override
  String get licensesPackages => 'Flutter un citas atvērtā koda pakotnes';

  @override
  String get licensesShowAll => 'Rādīt visus licenču tekstus';

  @override
  String get deleteAllTitle => 'Dzēst visus ierakstus';

  @override
  String get deleteAllConfirmTitle => 'Dzēst visus ierakstus?';

  @override
  String get deleteAllConfirmBody =>
      'Visi teksti un ieraksti tiks neatgriezeniski izdzēsti.';

  @override
  String get errorMicPermission =>
      'Nav piekļuves mikrofonam. Atļauj to tālruņa iestatījumos.';

  @override
  String errorRecorderStart(String detail) {
    return 'Neizdevās sākt ierakstu ($detail).';
  }

  @override
  String errorRecorderStop(String detail) {
    return 'Neizdevās apturēt ierakstu ($detail).';
  }

  @override
  String errorTranscription(String detail) {
    return 'Transkripcija neizdevās ($detail). Ieraksts ir saglabāts, un to var atpazīt vēlreiz.';
  }

  @override
  String errorRetranscribe(String detail) {
    return 'Atkārtota atpazīšana neizdevās ($detail).';
  }

  @override
  String errorModelLoad(String model, String detail) {
    return '$model neizdevās ielādēt. Ja tas atkārtojas, izdzēs modeli un lejupielādē to vēlreiz. ($detail)';
  }

  @override
  String get errorNoModel => 'Nav ielādēts neviens modelis.';

  @override
  String downloadAlreadyRunning(String model) {
    return '$model jau tiek lejupielādēts.';
  }

  @override
  String get downloadCancelled => 'Lejupielāde atcelta.';

  @override
  String get downloadNetworkError =>
      'Lejupielāde neizdevās. Pārbaudi interneta savienojumu un mēģini vēlreiz.';

  @override
  String get downloadNotModelFile =>
      'Serveris neatgrieza modeļa failu (iespējams, Wi-Fi pieteikšanās lapu). Pārbaudi tīklu un mēģini vēlreiz.';

  @override
  String downloadCorrupt(String file) {
    return 'Lejupielādētais fails $file ir bojāts. Mēģini vēlreiz.';
  }

  @override
  String downloadNoSpace(String model) {
    return 'Nepietiek vietas modelim $model.';
  }
}
