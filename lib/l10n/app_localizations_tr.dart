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
      'Çok hızlı ve çok doğru, 25 Avrupa dili, dili otomatik algılar. En az 6 GB RAM\'e sahip telefonlar için önerilir.';

  @override
  String get modelDescWhisperSmall =>
      'Hız ve doğruluk arasında dengeli, 99 dil, dil sabitlenebilir. En az 4 GB RAM\'e sahip telefonlar için.';

  @override
  String get modelDescWhisperBase =>
      'Eski telefonlar için hafif, 99 dil, dil sabitlenebilir. En az 3 GB RAM\'e sahip telefonlar için.';

  @override
  String get modelDescWhisperTiny =>
      'En küçük ve en hızlı indirilen. 99 dil, dil sabitlenebilir. Neredeyse her telefonda çalışır.';

  @override
  String get languageLabel => 'Dil';

  @override
  String get auto => 'Otomatik';

  @override
  String get modelLabel => 'Model';

  @override
  String get whisperRequired => 'Sabit bir dil için Whisper modeli gerekir.';

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
  String get defaultLanguageTitle => 'Yeni kayıtlar için varsayılan dil';

  @override
  String get defaultLanguageHint =>
      'Yalnızca Whisper modelleri bunu kullanır; Parakeet dili her zaman otomatik algılar.';

  @override
  String get licensesTitle => 'Lisanslar';

  @override
  String get licensesSubtitle => 'Kullanılan yazılımlar ve modeller';

  @override
  String get licensesLegalese =>
      'sherpa-onnx, Parakeet (NVIDIA, CC BY 4.0) ve Whisper (OpenAI, MIT) ile konuşma tanıma.';

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
