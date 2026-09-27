import 'dart:convert';
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:path/path.dart' as p;
import 'package:path_provider/path_provider.dart';

import '../models/recording.dart';
import 'backup_exclusion.dart';

/// Persists [Recording]s (their JSON index and WAV files) to disk and keeps
/// an in-memory, newest-first list for the UI.
///
/// Takes a plain [Directory] rather than resolving one itself so tests can
/// point it at a temp directory without touching platform channels.
class HistoryStore extends ChangeNotifier {
  HistoryStore(this._dir);

  final Directory _dir;
  List<Recording> _recordings = [];

  List<Recording> get recordings => List.unmodifiable(_recordings);

  File get _indexFile => File(p.join(_dir.path, 'recordings.json'));

  static Future<HistoryStore> create() async {
    final supportDir = await getApplicationSupportDirectory();
    final dir = Directory(p.join(supportDir.path, 'history'));
    if (!await dir.exists()) {
      await dir.create(recursive: true);
    }
    // Recordings and transcripts are private; keep them out of iCloud.
    await excludeFromBackup(dir.path);
    final store = HistoryStore(dir);
    await store.load();
    return store;
  }

  /// (Re-)reads `recordings.json` from disk. A missing or corrupt index is
  /// treated as an empty history rather than a crash.
  Future<void> load() async {
    if (!await _dir.exists()) {
      await _dir.create(recursive: true);
    }
    if (!await _indexFile.exists()) {
      _recordings = [];
      return;
    }
    try {
      final raw = await _indexFile.readAsString();
      final list = jsonDecode(raw) as List<dynamic>;
      _recordings = list
          .map((e) => Recording.fromJson(e as Map<String, dynamic>))
          .toList();
      _sortNewestFirst();
    } catch (_) {
      // Corrupt index (e.g. interrupted write) -> start clean rather than
      // blocking the app.
      _recordings = [];
    }
  }

  void _sortNewestFirst() =>
      _recordings.sort((a, b) => b.updatedAt.compareTo(a.updatedAt));

  Future<void> _persist() async {
    if (!await _dir.exists()) {
      await _dir.create(recursive: true);
    }
    final raw = jsonEncode(_recordings.map((r) => r.toJson()).toList());
    // Write-then-rename so a crash mid-write can't leave a truncated index
    // (which load() would treat as empty history).
    final tmp = File('${_indexFile.path}.tmp');
    await tmp.writeAsString(raw, flush: true);
    await tmp.rename(_indexFile.path);
  }

  /// Absolute path a WAV file with [fileName] should live at.
  String wavPathFor(String fileName) => p.join(_dir.path, fileName);

  /// Makes sure the history directory exists. Recording writes its WAV
  /// file straight into it, before there's any [Recording] to persist, so
  /// this must run before the recorder is asked to start.
  Future<void> ensureDirExists() async {
    if (!await _dir.exists()) {
      await _dir.create(recursive: true);
    }
  }

  int _wavNameCounter = 0;

  /// A fresh, collision-free WAV file name for a new clip. Combines a
  /// timestamp with a counter since two calls in immediate succession could
  /// otherwise land in the same microsecond.
  String newWavFileName() {
    final ts = DateTime.now().microsecondsSinceEpoch;
    _wavNameCounter++;
    return '$ts-$_wavNameCounter.wav';
  }

  Future<void> addRecording(Recording recording) async {
    _recordings.add(recording);
    _sortNewestFirst();
    notifyListeners();
    await _persist();
  }

  /// Call after mutating a [Recording] already held by this store (e.g.
  /// appending a clip or updating a clip's text) to re-sort and persist.
  Future<void> persistChange() async {
    _sortNewestFirst();
    notifyListeners();
    await _persist();
  }

  Recording? byId(String id) {
    for (final r in _recordings) {
      if (r.id == id) return r;
    }
    return null;
  }

  Future<void> deleteRecording(String id) async {
    final idx = _recordings.indexWhere((r) => r.id == id);
    if (idx == -1) return;
    final rec = _recordings.removeAt(idx);
    notifyListeners();
    await _deleteWavFiles(rec);
    await _persist();
  }

  Future<void> deleteAll() async {
    final all = List.of(_recordings);
    _recordings.clear();
    notifyListeners();
    for (final rec in all) {
      await _deleteWavFiles(rec);
    }
    await _persist();
  }

  /// Deletes recordings last updated before `now - maxAge`, plus any WAV
  /// file in the history directory that no recording references and that is
  /// itself older than the cutoff (left behind by a crash or a lost index) —
  /// the retention promise covers all audio, not just indexed audio.
  /// Returns how many recordings were removed.
  Future<int> purgeOlderThan(Duration maxAge, {DateTime? now}) async {
    final cutoff = (now ?? DateTime.now()).subtract(maxAge);
    final toRemove = _recordings
        .where((r) => r.updatedAt.isBefore(cutoff))
        .toList();
    for (final rec in toRemove) {
      _recordings.remove(rec);
      await _deleteWavFiles(rec);
    }
    if (toRemove.isNotEmpty) {
      notifyListeners();
      await _persist();
    }
    await _deleteOrphanedWavs(olderThan: cutoff);
    return toRemove.length;
  }

  Future<void> _deleteOrphanedWavs({required DateTime olderThan}) async {
    if (!await _dir.exists()) return;
    final referenced = {
      for (final r in _recordings)
        for (final c in r.clips) c.wavFileName,
    };
    await for (final entity in _dir.list()) {
      if (entity is! File || !entity.path.endsWith('.wav')) continue;
      if (referenced.contains(p.basename(entity.path))) continue;
      // Age check also protects a recording that's in progress right now.
      if ((await entity.lastModified()).isBefore(olderThan)) {
        await entity.delete();
      }
    }
  }

  Future<void> _deleteWavFiles(Recording rec) async {
    for (final clip in rec.clips) {
      final f = File(wavPathFor(clip.wavFileName));
      if (await f.exists()) {
        await f.delete();
      }
    }
  }
}
