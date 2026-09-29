// ignore: unused_import
import 'package:intl/intl.dart' as intl;

import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Turkish (`tr`).
class AppLocalizationsTr extends AppLocalizations {
  AppLocalizationsTr([String locale = 'tr']) : super(locale);

  @override
  String get logoSemantics => 'Talkpuppy logosu';

  @override
  String startupFailed(String error) {
    return 'Talkpuppy başlatılamadı:\n$error';
  }

  @override
  String get settingsTooltip => 'Ayarlar';

  @override
  String get switchModelTooltip => 'Modeli değiştir';

  @override
  String get manageModelsEllipsis => 'Modelleri yönet…';

  @override
  String get manageModels => 'Modelleri yönet';

  @override
  String get installModel => 'Model yükle';

  @override
  String get noModel => 'Model yok';

  @override
  String get ok => 'Tamam';

  @override
  String get cancel => 'İptal';

  @override
  String get delete => 'Sil';

  @override
  String get copy => 'Kopyala';

  @override
  String get record => 'Kayıt yap';

  @override
  String get stopRecording => 'Durdur';

  @override
  String get transcribing => 'Yazıya dökülüyor…';

  @override
  String get newRecording => 'Yeni kayıt';

  @override
  String get continueRecording => 'Kayda devam et';

  @override
  String get transcriptLabel => 'Metin';

  @override
  String get emptyTranscript => 'Henüz kayıt yok.\nAşağıdaki mikrofona dokun.';

  @override
  String get noTextRecognized => '(metin tanınmadı)';

  @override
  String get retranscribe => 'Yeniden yazıya dök';

  @override
  String get today => 'Bugün';

  @override
  String get yesterday => 'Dün';

  @override
  String get welcomeTitle => 'Talkpuppy\'ye hoş geldin';

  @override
  String get welcomeBody =>
      'Yazıya dökme için bir konuşma modeli seç. Tamamen cihazında çalışır, internet gerekmez.';

  @override
  String get recommended => 'Önerilen';

  @override
  String get preparing => 'Hazırlanıyor…';

  @override
  String sizeMb(int size) {
    return '$size MB';
  }

  @override
  String downloadProgress(int received, int total) {
    return '$received MB / $total MB';
  }

  @override
  String get downloadAndStart => 'İndir ve başla';

  @override
  String get download => 'İndir';

  @override
  String downloadFailed(String error) {
    return 'İndirme başarısız: $error';
  }

  @override
  String get modelsTitle => 'Modeller';

  @override
  String get deleteModelTitle => 'Model silinsin mi?';

  @override
  String deleteModelBody(String model, int size) {
    return '$model bu cihazdan silinecek ($size MB).';
  }

  @override
  String get modelDescParakeet =>
      'Çok doğru ve hızlı. Metin, kaydı durdurduğunda görünür. 25 Avrupa dili, otomatik algılanır; dil sabitlenemez. Büyük indirme, en az 6 GB RAM\'e sahip telefonlar için.';

  @override
  String get modelDescWhisperSmall =>
      'En çok dil (99), otomatik algılanır veya sabitlenir. İyi doğruluk, ancak Parakeet\'ten daha yavaş; sessizlikte veya gürültüde ara sıra kelime uydurabilir. En az 4 GB RAM\'e sahip telefonlar için.';

  @override
  String get modelDescWhisperBase =>
      'Eski telefonlar için küçük indirme. 99 dil, otomatik algılanır veya sabitlenir. Whisper Small\'dan belirgin şekilde daha az doğru. En az 3 GB RAM\'e sahip telefonlar için.';

  @override
  String get modelDescWhisperTiny =>
      'En küçük ve en hızlı, neredeyse her telefonda çalışır. 99 dil, otomatik algılanır veya sabitlenir. En az doğru olanı, kısa ve net söylenmiş notlar için en iyisi.';

  @override
  String get modelDescNemotron =>
      'Canlı önizleme: metin sen konuşurken görünür ve durduğun anda hazırdır. 28 dil, otomatik algılanır veya sabitlenir. Genellikle Parakeet\'ten biraz daha az doğru. Büyük indirme, en az 6 GB RAM\'e sahip telefonlar için.';

  @override
  String get livePreviewLabel => 'Canlı önizleme';

  @override
  String get livePreviewListening => 'Dinleniyor…';

  @override
  String get languageLabel => 'Dil';

  @override
  String get auto => 'Otomatik';

  @override
  String get modelLabel => 'Model';

  @override
  String get whisperRequired =>
      'Sabit bir dil için Whisper veya Nemotron modeli gerekir.';

  @override
  String get downloadWhisperSmall => 'Whisper Small\'u indir';

  @override
  String get settingsTitle => 'Ayarlar';

  @override
  String get appLanguageTitle => 'Uygulama dili';

  @override
  String get appLanguageSystem => 'Sistem varsayılanı';

  @override
  String get autoCopyTitle => 'Otomatik kopyala';

  @override
  String get autoCopySubtitle =>
      'Metni yazıya dökme biter bitmez panoya kopyala';

  @override
  String get hapticsTitle => 'Dokunsal geri bildirim';

  @override
  String get minimizeToOverlay => 'Küçült ve katmanı göster';

  @override
  String get overlaySetupTitle => 'Erişilebilirlik hizmetini aç';

  @override
  String get overlaySetupBody =>
      'Düğmeyi diğer uygulamaların üzerinde göstermek ve metni imlecin olduğu yere eklemek için Talkpuppy\'nin kendi erişilebilirlik hizmetine ihtiyacı var. Yalnızca yazdığın alanı okur, o da sadece metni eklemek için. Ekrandaki başka hiçbir şeyi okumaz, diğer uygulamalardan hiçbir şey kaydetmez ve hiçbir yere bir şey göndermez.\n\nSonraki ekranda “Talkpuppy”yi aç ve etkinleştir.';

  @override
  String get overlaySetupShortcut =>
      'Yalnızca Talkpuppy anahtarını aç ve “Kısayol”u kapalı bırak: düğme kendiliğinden görünür.';

  @override
  String get shortcutHint =>
      'Talkpuppy için “Kısayol” açık, bu yüzden Android uygulama simgesini ekranın kenarına sabitliyor. Buna ihtiyacın yok: kayan düğme kendiliğinden görünür. Talkpuppy erişilebilirlik ayarlarında “Kısayol”u kapat.';

  @override
  String get shortcutHintAction => 'Talkpuppy ayarlarını aç';

  @override
  String get overlayOpenAccessibility => 'Erişilebilirlik ayarlarını aç';

  @override
  String get overlayRestrictedHint =>
      'Anahtar gri mi? Uygulama bilgileri → ⋮ → “Kısıtlanmış ayarlara izin ver” seçeneğine git ve tekrar dene.';

  @override
  String get defaultLanguageTitle => 'Yeni kayıtlar için varsayılan dil';

  @override
  String get defaultLanguageHint =>
      'Whisper ve Nemotron bunu kullanır; Parakeet dili her zaman otomatik algılar.';

  @override
  String get licensesTitle => 'Lisanslar';

  @override
  String get licensesSubtitle => 'Kullanılan yazılımlar ve modeller';

  @override
  String get licensesLegalese =>
      'sherpa-onnx, Parakeet (NVIDIA, CC BY 4.0), Nemotron (NVIDIA, OpenMDW 1.1) ve Whisper (OpenAI, MIT) ile konuşma tanıma.';

  @override
  String get licensesIntro =>
      'Talkpuppy, açık kaynaklı yazılımlar ve açık lisanslı konuşma modelleri üzerine kuruludur.';

  @override
  String get licensesSpeechModels => 'Konuşma modelleri';

  @override
  String get licensesSoftware => 'Yazılım';

  @override
  String get licensesPackages => 'Flutter ve diğer açık kaynaklı paketler';

  @override
  String get licensesShowAll => 'Tüm lisans metinlerini göster';

  @override
  String get deleteAllTitle => 'Tüm kayıtları sil';

  @override
  String get deleteAllConfirmTitle => 'Tüm kayıtlar silinsin mi?';

  @override
  String get deleteAllConfirmBody =>
      'Tüm metinler ve kayıtlar kalıcı olarak silinecek.';

  @override
  String get errorMicPermission =>
      'Mikrofon erişimi yok. Lütfen telefonunun ayarlarından izin ver.';

  @override
  String get errorMicBusy =>
      'Mikrofon şu anda kullanımda, örneğin bir telefon görüşmesi tarafından. Görüşmeden sonra tekrar dene.';

  @override
  String errorRecorderStart(String detail) {
    return 'Kayıt başlatılamadı ($detail).';
  }

  @override
  String errorRecorderStop(String detail) {
    return 'Kayıt durdurulamadı ($detail).';
  }

  @override
  String errorTranscription(String detail) {
    return 'Yazıya dökme başarısız ($detail). Kayıt saklandı ve yeniden yazıya dökülebilir.';
  }

  @override
  String errorRetranscribe(String detail) {
    return 'Yeniden yazıya dökme başarısız ($detail).';
  }

  @override
  String errorModelLoad(String model, String detail) {
    return '$model yüklenemedi. Bu tekrar olursa modeli silip yeniden indir. ($detail)';
  }

  @override
  String get errorNoModel => 'Yüklü model yok.';

  @override
  String downloadAlreadyRunning(String model) {
    return '$model zaten indiriliyor.';
  }

  @override
  String get downloadCancelled => 'İndirme iptal edildi.';

  @override
  String get downloadNetworkError =>
      'İndirme başarısız. Lütfen internet bağlantını kontrol edip tekrar dene.';

  @override
  String get downloadNotModelFile =>
      'Sunucu bir model dosyası döndürmedi (belki bir Wi-Fi giriş sayfası). Lütfen ağını kontrol edip tekrar dene.';

  @override
  String downloadCorrupt(String file) {
    return 'İndirilen $file dosyası bozuk. Lütfen tekrar dene.';
  }

  @override
  String downloadNoSpace(String model) {
    return '$model için yeterli depolama alanı yok.';
  }
}
