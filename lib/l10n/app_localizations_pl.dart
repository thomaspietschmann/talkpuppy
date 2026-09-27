// ignore: unused_import
import 'package:intl/intl.dart' as intl;

import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Polish (`pl`).
class AppLocalizationsPl extends AppLocalizations {
  AppLocalizationsPl([String locale = 'pl']) : super(locale);

  @override
  String get logoSemantics => 'Logo Talkpuppy';

  @override
  String startupFailed(String error) {
    return 'Nie udało się uruchomić Talkpuppy:\n$error';
  }

  @override
  String get settingsTooltip => 'Ustawienia';

  @override
  String get switchModelTooltip => 'Zmień model';

  @override
  String get manageModelsEllipsis => 'Zarządzaj modelami…';

  @override
  String get manageModels => 'Zarządzaj modelami';

  @override
  String get installModel => 'Zainstaluj model';

  @override
  String get noModel => 'Brak modelu';

  @override
  String get ok => 'OK';

  @override
  String get cancel => 'Anuluj';

  @override
  String get delete => 'Usuń';

  @override
  String get copy => 'Kopiuj';

  @override
  String get record => 'Nagrywaj';

  @override
  String get stopRecording => 'Zatrzymaj';

  @override
  String get transcribing => 'Transkrypcja…';

  @override
  String get newRecording => 'Nowe nagranie';

  @override
  String get continueRecording => 'Nagrywaj dalej';

  @override
  String get transcriptLabel => 'Transkrypcja';

  @override
  String get emptyTranscript => 'Brak nagrań.\nDotknij mikrofonu poniżej.';

  @override
  String get noTextRecognized => '(nie rozpoznano tekstu)';

  @override
  String get retranscribe => 'Transkrybuj ponownie';

  @override
  String get today => 'Dzisiaj';

  @override
  String get yesterday => 'Wczoraj';

  @override
  String get welcomeTitle => 'Witaj w Talkpuppy';

  @override
  String get welcomeBody =>
      'Wybierz model mowy do transkrypcji. Działa w całości na twoim urządzeniu, bez internetu.';

  @override
  String get recommended => 'Polecany';

  @override
  String get preparing => 'Przygotowywanie…';

  @override
  String sizeMb(int size) {
    return '$size MB';
  }

  @override
  String downloadProgress(int received, int total) {
    return '$received MB / $total MB';
  }

  @override
  String get downloadAndStart => 'Pobierz i zacznij';

  @override
  String get download => 'Pobierz';

  @override
  String downloadFailed(String error) {
    return 'Pobieranie nie powiodło się: $error';
  }

  @override
  String get modelsTitle => 'Modele';

  @override
  String get deleteModelTitle => 'Usunąć model?';

  @override
  String deleteModelBody(String model, int size) {
    return '$model zostanie usunięty z tego urządzenia ($size MB).';
  }

  @override
  String get modelDescParakeet =>
      'Bardzo szybki i bardzo dokładny, 25 języków europejskich, sam rozpoznaje język. Polecany dla telefonów z co najmniej 6 GB RAM.';

  @override
  String get modelDescWhisperSmall =>
      'Kompromis między szybkością a dokładnością, 99 języków, język można ustawić na stałe. Dla telefonów z co najmniej 4 GB RAM.';

  @override
  String get modelDescWhisperBase =>
      'Lekki model dla starszych telefonów, 99 języków, język można ustawić na stałe. Dla telefonów z co najmniej 3 GB RAM.';

  @override
  String get modelDescWhisperTiny =>
      'Minimalny i najszybszy do pobrania. 99 języków, język można ustawić na stałe. Działa praktycznie na każdym telefonie.';

  @override
  String get languageLabel => 'Język';

  @override
  String get auto => 'Auto';

  @override
  String get modelLabel => 'Model';

  @override
  String get whisperRequired => 'Stały język wymaga modelu Whisper.';

  @override
  String get downloadWhisperSmall => 'Pobierz Whisper Small';

  @override
  String get settingsTitle => 'Ustawienia';

  @override
  String get appLanguageTitle => 'Język aplikacji';

  @override
  String get appLanguageSystem => 'Domyślny systemowy';

  @override
  String get autoCopyTitle => 'Kopiuj automatycznie';

  @override
  String get autoCopySubtitle =>
      'Umieść tekst w schowku od razu po transkrypcji';

  @override
  String get hapticsTitle => 'Reakcje haptyczne';

  @override
  String get defaultLanguageTitle => 'Domyślny język nowych nagrań';

  @override
  String get defaultLanguageHint =>
      'Używają go tylko modele Whisper; Parakeet zawsze rozpoznaje język automatycznie.';

  @override
  String get licensesTitle => 'Licencje';

  @override
  String get licensesSubtitle => 'Użyte oprogramowanie i modele';

  @override
  String get licensesLegalese =>
      'Rozpoznawanie mowy dzięki sherpa-onnx, Parakeet (NVIDIA, CC BY 4.0) i Whisper (OpenAI, MIT).';

  @override
  String get deleteAllTitle => 'Usuń wszystkie nagrania';

  @override
  String get deleteAllConfirmTitle => 'Usunąć wszystkie nagrania?';

  @override
  String get deleteAllConfirmBody =>
      'Wszystkie transkrypcje i nagrania zostaną trwale usunięte.';

  @override
  String get errorMicPermission =>
      'Brak dostępu do mikrofonu. Zezwól na niego w ustawieniach telefonu.';

  @override
  String errorRecorderStart(String detail) {
    return 'Nie udało się rozpocząć nagrywania ($detail).';
  }

  @override
  String errorRecorderStop(String detail) {
    return 'Nie udało się zatrzymać nagrywania ($detail).';
  }

  @override
  String errorTranscription(String detail) {
    return 'Transkrypcja nie powiodła się ($detail). Nagranie zostało zapisane i można je transkrybować ponownie.';
  }

  @override
  String errorRetranscribe(String detail) {
    return 'Ponowna transkrypcja nie powiodła się ($detail).';
  }

  @override
  String errorModelLoad(String model, String detail) {
    return 'Nie udało się wczytać modelu $model. Jeśli to się powtarza, usuń model i pobierz go ponownie. ($detail)';
  }

  @override
  String get errorNoModel => 'Nie wczytano modelu.';

  @override
  String downloadAlreadyRunning(String model) {
    return '$model jest już pobierany.';
  }

  @override
  String get downloadCancelled => 'Pobieranie anulowane.';

  @override
  String get downloadNetworkError =>
      'Pobieranie nie powiodło się. Sprawdź połączenie z internetem i spróbuj ponownie.';

  @override
  String get downloadNotModelFile =>
      'Serwer nie zwrócił pliku modelu (może to strona logowania do Wi-Fi). Sprawdź sieć i spróbuj ponownie.';

  @override
  String downloadCorrupt(String file) {
    return 'Pobrany plik $file jest uszkodzony. Spróbuj ponownie.';
  }

  @override
  String downloadNoSpace(String model) {
    return 'Za mało miejsca na $model.';
  }
}
