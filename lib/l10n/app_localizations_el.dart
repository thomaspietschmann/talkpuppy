// ignore: unused_import
import 'package:intl/intl.dart' as intl;

import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Modern Greek (`el`).
class AppLocalizationsEl extends AppLocalizations {
  AppLocalizationsEl([String locale = 'el']) : super(locale);

  @override
  String get logoSemantics => 'Λογότυπο Talkpuppy';

  @override
  String startupFailed(String error) {
    return 'Το Talkpuppy δεν μπόρεσε να ξεκινήσει:\n$error';
  }

  @override
  String get settingsTooltip => 'Ρυθμίσεις';

  @override
  String get switchModelTooltip => 'Αλλαγή μοντέλου';

  @override
  String get manageModelsEllipsis => 'Διαχείριση μοντέλων…';

  @override
  String get manageModels => 'Διαχείριση μοντέλων';

  @override
  String get installModel => 'Εγκατάσταση μοντέλου';

  @override
  String get noModel => 'Κανένα μοντέλο';

  @override
  String get ok => 'OK';

  @override
  String get cancel => 'Ακύρωση';

  @override
  String get delete => 'Διαγραφή';

  @override
  String get copy => 'Αντιγραφή';

  @override
  String get record => 'Εγγραφή';

  @override
  String get stopRecording => 'Διακοπή';

  @override
  String get transcribing => 'Απομαγνητοφώνηση…';

  @override
  String get newRecording => 'Νέα εγγραφή';

  @override
  String get continueRecording => 'Συνέχεια εγγραφής';

  @override
  String get transcriptLabel => 'Κείμενο';

  @override
  String get emptyTranscript =>
      'Δεν υπάρχει εγγραφή ακόμα.\nΠάτα το μικρόφωνο παρακάτω.';

  @override
  String get noTextRecognized => '(δεν αναγνωρίστηκε κείμενο)';

  @override
  String get retranscribe => 'Εκ νέου απομαγνητοφώνηση';

  @override
  String get today => 'Σήμερα';

  @override
  String get yesterday => 'Χθες';

  @override
  String get welcomeTitle => 'Καλώς ήρθες στο Talkpuppy';

  @override
  String get welcomeBody =>
      'Διάλεξε ένα μοντέλο ομιλίας για απομαγνητοφώνηση. Λειτουργεί εξ ολοκλήρου στη συσκευή σου, χωρίς internet.';

  @override
  String get recommended => 'Προτείνεται';

  @override
  String get preparing => 'Προετοιμασία…';

  @override
  String sizeMb(int size) {
    return '$size MB';
  }

  @override
  String downloadProgress(int received, int total) {
    return '$received MB / $total MB';
  }

  @override
  String get downloadAndStart => 'Λήψη και έναρξη';

  @override
  String get download => 'Λήψη';

  @override
  String downloadFailed(String error) {
    return 'Η λήψη απέτυχε: $error';
  }

  @override
  String get modelsTitle => 'Μοντέλα';

  @override
  String get deleteModelTitle => 'Διαγραφή μοντέλου;';

  @override
  String deleteModelBody(String model, int size) {
    return 'Το $model θα διαγραφεί από αυτή τη συσκευή ($size MB).';
  }

  @override
  String get modelDescParakeet =>
      'Πολύ ακριβές και γρήγορο. Το κείμενο εμφανίζεται μόλις σταματήσεις την εγγραφή. 25 ευρωπαϊκές γλώσσες, με αυτόματη αναγνώριση· η γλώσσα δεν μπορεί να οριστεί σταθερά. Μεγάλη λήψη, για κινητά με τουλάχιστον 6 GB RAM.';

  @override
  String get modelDescWhisperSmall =>
      'Οι περισσότερες γλώσσες (99), με αυτόματη αναγνώριση ή σταθερή επιλογή. Καλή ακρίβεια, αλλά πιο αργό από το Parakeet, και σε σιωπή ή θόρυβο μπορεί περιστασιακά να επινοήσει λέξεις. Για κινητά με τουλάχιστον 4 GB RAM.';

  @override
  String get modelDescWhisperBase =>
      'Μικρή λήψη για παλαιότερα κινητά. 99 γλώσσες, με αυτόματη αναγνώριση ή σταθερή επιλογή. Αισθητά λιγότερο ακριβές από το Whisper Small. Για κινητά με τουλάχιστον 3 GB RAM.';

  @override
  String get modelDescWhisperTiny =>
      'Το μικρότερο και ταχύτερο, τρέχει σχεδόν σε κάθε κινητό. 99 γλώσσες, με αυτόματη αναγνώριση ή σταθερή επιλογή. Το λιγότερο ακριβές, ιδανικό για σύντομες, καθαρά εκφωνημένες σημειώσεις.';

  @override
  String get modelDescNemotron =>
      'Ζωντανή προεπισκόπηση: το κείμενο εμφανίζεται καθώς μιλάς και είναι έτοιμο μόλις σταματήσεις. 28 γλώσσες, με αυτόματη αναγνώριση ή σταθερή επιλογή. Συνήθως λίγο λιγότερο ακριβές από το Parakeet. Μεγάλη λήψη, για κινητά με τουλάχιστον 6 GB RAM.';

  @override
  String get livePreviewLabel => 'Ζωντανή προεπισκόπηση';

  @override
  String get livePreviewListening => 'Ακούει…';

  @override
  String get languageLabel => 'Γλώσσα';

  @override
  String get auto => 'Αυτόματα';

  @override
  String get modelLabel => 'Μοντέλο';

  @override
  String get whisperRequired =>
      'Για σταθερή γλώσσα χρειάζεται μοντέλο Whisper ή Nemotron.';

  @override
  String get downloadWhisperSmall => 'Λήψη Whisper Small';

  @override
  String get settingsTitle => 'Ρυθμίσεις';

  @override
  String get appLanguageTitle => 'Γλώσσα εφαρμογής';

  @override
  String get appLanguageSystem => 'Προεπιλογή συστήματος';

  @override
  String get autoCopyTitle => 'Αυτόματη αντιγραφή';

  @override
  String get autoCopySubtitle =>
      'Αντιγραφή του κειμένου στο πρόχειρο αμέσως μετά την απομαγνητοφώνηση';

  @override
  String get hapticsTitle => 'Απτική απόκριση';

  @override
  String get minimizeToOverlay => 'Ελαχιστοποίηση και εμφάνιση επικάλυψης';

  @override
  String get overlaySetupTitle => 'Ενεργοποίησε την υπηρεσία προσβασιμότητας';

  @override
  String get overlaySetupBody =>
      'Για να εμφανίζει το κουμπί πάνω από άλλες εφαρμογές και να εισάγει το κείμενο στη θέση του κέρσορα, το Talkpuppy χρειάζεται την υπηρεσία προσβασιμότητάς του. Διαβάζει μόνο το πεδίο όπου πληκτρολογείς και μόνο για να εισάγει το κείμενο. Δεν διαβάζει τίποτα άλλο στην οθόνη, δεν αποθηκεύει τίποτα από άλλες εφαρμογές και δεν στέλνει τίποτα πουθενά.\n\nΣτην επόμενη οθόνη, άνοιξε το «Talkpuppy» και ενεργοποίησέ το.';

  @override
  String get overlaySetupShortcut =>
      'Ενεργοποίησε μόνο τον διακόπτη του Talkpuppy και άφησε τη «Συντόμευση» απενεργοποιημένη: το κουμπί εμφανίζεται από μόνο του.';

  @override
  String get shortcutHint =>
      'Η «Συντόμευση» του Talkpuppy είναι ενεργή, γι\' αυτό το Android καρφιτσώνει το εικονίδιο της εφαρμογής στην άκρη της οθόνης. Δεν τη χρειάζεσαι: το αιωρούμενο κουμπί εμφανίζεται από μόνο του. Απενεργοποίησε τη «Συντόμευση» στις ρυθμίσεις προσβασιμότητας του Talkpuppy.';

  @override
  String get shortcutHintAction => 'Άνοιγμα ρυθμίσεων Talkpuppy';

  @override
  String get overlayOpenAccessibility => 'Άνοιγμα ρυθμίσεων προσβασιμότητας';

  @override
  String get overlayRestrictedHint =>
      'Ο διακόπτης είναι γκρι; Άνοιξε Πληροφορίες εφαρμογής → ⋮ → «Να επιτρέπονται οι περιορισμένες ρυθμίσεις» και δοκίμασε ξανά.';

  @override
  String get defaultLanguageTitle => 'Προεπιλεγμένη γλώσσα για νέες εγγραφές';

  @override
  String get defaultLanguageHint =>
      'Ισχύει για τα Whisper και Nemotron· το Parakeet αναγνωρίζει πάντα αυτόματα τη γλώσσα.';

  @override
  String get licensesTitle => 'Άδειες χρήσης';

  @override
  String get licensesSubtitle => 'Λογισμικό και μοντέλα που χρησιμοποιούνται';

  @override
  String get licensesLegalese =>
      'Αναγνώριση ομιλίας με sherpa-onnx, Parakeet (NVIDIA, CC BY 4.0), Nemotron (NVIDIA, OpenMDW 1.1) και Whisper (OpenAI, MIT).';

  @override
  String get licensesIntro =>
      'Το Talkpuppy βασίζεται σε λογισμικό ανοιχτού κώδικα και σε μοντέλα ομιλίας με ανοιχτές άδειες.';

  @override
  String get licensesSpeechModels => 'Μοντέλα ομιλίας';

  @override
  String get licensesSoftware => 'Λογισμικό';

  @override
  String get licensesPackages => 'Flutter και άλλα πακέτα ανοιχτού κώδικα';

  @override
  String get licensesShowAll => 'Εμφάνιση όλων των κειμένων αδειών';

  @override
  String get deleteAllTitle => 'Διαγραφή όλων των εγγραφών';

  @override
  String get deleteAllConfirmTitle => 'Διαγραφή όλων των εγγραφών;';

  @override
  String get deleteAllConfirmBody =>
      'Όλα τα κείμενα και οι εγγραφές θα διαγραφούν οριστικά.';

  @override
  String get errorMicPermission =>
      'Δεν υπάρχει πρόσβαση στο μικρόφωνο. Επίτρεψέ την στις ρυθμίσεις του κινητού σου.';

  @override
  String get errorMicBusy =>
      'Το μικρόφωνο χρησιμοποιείται αυτή τη στιγμή, για παράδειγμα από μια κλήση. Δοκίμασε ξανά μετά την κλήση.';

  @override
  String errorRecorderStart(String detail) {
    return 'Δεν ήταν δυνατή η έναρξη της εγγραφής ($detail).';
  }

  @override
  String errorRecorderStop(String detail) {
    return 'Δεν ήταν δυνατή η διακοπή της εγγραφής ($detail).';
  }

  @override
  String errorTranscription(String detail) {
    return 'Η απομαγνητοφώνηση απέτυχε ($detail). Η εγγραφή έχει αποθηκευτεί και μπορεί να απομαγνητοφωνηθεί ξανά.';
  }

  @override
  String errorRetranscribe(String detail) {
    return 'Η εκ νέου απομαγνητοφώνηση απέτυχε ($detail).';
  }

  @override
  String errorModelLoad(String model, String detail) {
    return 'Δεν ήταν δυνατή η φόρτωση του $model. Αν συνεχίσει να συμβαίνει, διάγραψε το μοντέλο και κατέβασέ το ξανά. ($detail)';
  }

  @override
  String get errorNoModel => 'Δεν έχει φορτωθεί μοντέλο.';

  @override
  String downloadAlreadyRunning(String model) {
    return 'Το $model κατεβαίνει ήδη.';
  }

  @override
  String get downloadCancelled => 'Η λήψη ακυρώθηκε.';

  @override
  String get downloadNetworkError =>
      'Η λήψη απέτυχε. Έλεγξε τη σύνδεσή σου στο internet και δοκίμασε ξανά.';

  @override
  String get downloadNotModelFile =>
      'Ο διακομιστής δεν επέστρεψε αρχείο μοντέλου (ίσως σελίδα σύνδεσης Wi-Fi). Έλεγξε το δίκτυό σου και δοκίμασε ξανά.';

  @override
  String downloadCorrupt(String file) {
    return 'Το αρχείο $file που κατέβηκε είναι κατεστραμμένο. Δοκίμασε ξανά.';
  }

  @override
  String downloadNoSpace(String model) {
    return 'Δεν υπάρχει αρκετός χώρος για το $model.';
  }
}
