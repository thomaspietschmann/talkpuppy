import 'dart:io';
import 'dart:isolate';

import 'package:crypto/crypto.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:path/path.dart' as p;
import 'package:flutter/services.dart';
import 'package:path_provider/path_provider.dart';

import '../models/catalog.dart';
import '../models/model_spec.dart';
import 'backup_exclusion.dart';

/// Combined download progress across all files of one model.
class DownloadProgress {
  const DownloadProgress({required this.receivedBytes, required this.totalBytes});

  final int receivedBytes;
  final int totalBytes;

  double get fraction => totalBytes == 0 ? 0 : receivedBytes / totalBytes;
}

enum DownloadErrorKind { alreadyRunning, cancelled, network, notModelFile, corrupt, noSpace }

/// A download failed in a way worth showing to the user; the UI turns
/// [kind] into a localized message.
class ModelDownloadException implements Exception {
  ModelDownloadException(this.kind, {this.modelName = '', this.fileName = ''});

  final DownloadErrorKind kind;
  final String modelName;
  final String fileName;

  @override
  String toString() => 'ModelDownloadException($kind, $modelName$fileName)';
}

/// Downloads, verifies and deletes on-device model files.
///
/// Each model lives at `<app support dir>/models/<modelId>/<localName>`.
/// Downloads are resumable: an interrupted file is kept as `<name>.part`
/// and continued (via an HTTP Range request) the next time it's requested.
/// A file is only moved into place once its size and SHA-256 match the
/// catalog.
class ModelManager extends ChangeNotifier {
  ModelManager(this._modelsRootDir);

  final Directory _modelsRootDir;
  final Map<String, CancelToken> _activeCancelTokens = {};
  Set<String> _downloadedIds = {};

  static const _progressInterval = Duration(milliseconds: 100);

  static Future<ModelManager> create() async {
    final supportDir = await getApplicationSupportDirectory();
    final dir = Directory(p.join(supportDir.path, 'models'));
    if (!await dir.exists()) {
      await dir.create(recursive: true);
    }
    // Models never go to iCloud: excluding the root up front also covers
    // partial downloads (`.part`) and every model directory created later.
    await excludeFromBackup(dir.path);
    final manager = ModelManager(dir);
    await manager._refreshDownloadedIds();
    return manager;
  }

  /// Synchronous, cached view of which models are downloaded — refreshed
  /// after every [download] and [delete] call. Prefer this in UI code over
  /// [downloadedModelIds] to avoid re-scanning the filesystem on rebuild.
  Set<String> get downloadedIds => Set.unmodifiable(_downloadedIds);

  bool isDownloading(ModelSpec model) =>
      _activeCancelTokens.containsKey(model.id);

  Future<void> _refreshDownloadedIds() async {
    _downloadedIds = await downloadedModelIds();
  }

  String modelDir(ModelSpec model) => p.join(_modelsRootDir.path, model.id);

  /// True when every file exists with its exact expected size. (The hash
  /// was verified when the file was moved into place; re-hashing hundreds
  /// of MB on every start isn't worth it, since only someone who can
  /// already write the app's private storage could swap a file.)
  Future<bool> isDownloaded(ModelSpec model) async {
    for (final f in model.files) {
      final file = File(p.join(modelDir(model), f.localName));
      if (!await file.exists() || await file.length() != f.sizeBytes) {
        return false;
      }
    }
    return true;
  }

  Future<Set<String>> downloadedModelIds() async {
    final result = <String>{};
    for (final model in kModelCatalog) {
      if (await isDownloaded(model)) {
        result.add(model.id);
      }
    }
    return result;
  }

  /// Downloads all of [model]'s files, resuming partial downloads and
  /// skipping files that are already in place. Reports combined progress
  /// (throttled to ~10 Hz) across all of the model's files.
  Future<void> download(
    ModelSpec model, {
    required void Function(DownloadProgress progress) onProgress,
  }) async {
    if (isDownloading(model)) {
      throw ModelDownloadException(
        DownloadErrorKind.alreadyRunning,
        modelName: model.displayName,
      );
    }
    final cancelToken = CancelToken();
    _activeCancelTokens[model.id] = cancelToken;
    notifyListeners();

    final dir = Directory(modelDir(model));
    final receivedPerFile = List<int>.filled(model.files.length, 0);
    final totalBytes = model.totalSizeBytes;
    var lastReport = DateTime.fromMillisecondsSinceEpoch(0);

    void reportProgress({bool force = false}) {
      final now = DateTime.now();
      if (!force && now.difference(lastReport) < _progressInterval) return;
      lastReport = now;
      final received = receivedPerFile.fold<int>(0, (a, b) => a + b);
      onProgress(
        DownloadProgress(receivedBytes: received, totalBytes: totalBytes),
      );
    }

    final dio = Dio();
    try {
      if (!await dir.exists()) {
        await dir.create(recursive: true);
      }
      await _ensureFreeSpace(dir.path, model);
      for (var i = 0; i < model.files.length; i++) {
        final fileSpec = model.files[i];
        final target = File(p.join(dir.path, fileSpec.localName));
        if (await target.exists() &&
            await target.length() == fileSpec.sizeBytes) {
          receivedPerFile[i] = fileSpec.sizeBytes;
          reportProgress(force: true);
          continue;
        }
        await _downloadFile(
          dio: dio,
          url: '${model.baseUrl}${fileSpec.remoteName}',
          target: target,
          spec: fileSpec,
          cancelToken: cancelToken,
          onBytesReceived: (received) {
            receivedPerFile[i] = received;
            reportProgress();
          },
        );
      }
      reportProgress(force: true);
      await excludeFromBackup(dir.path);
    } on DioException catch (e) {
      if (CancelToken.isCancel(e)) {
        throw ModelDownloadException(DownloadErrorKind.cancelled);
      }
      throw ModelDownloadException(DownloadErrorKind.network);
    } on FileSystemException catch (e) {
      if (e.osError?.errorCode == _enospc) {
        throw ModelDownloadException(
          DownloadErrorKind.noSpace,
          modelName: model.displayName,
        );
      }
      rethrow;
    } finally {
      dio.close();
      _activeCancelTokens.remove(model.id);
      await _refreshDownloadedIds();
      notifyListeners();
    }
  }

  void cancelDownload(ModelSpec model) {
    _activeCancelTokens[model.id]?.cancel('cancelled by user');
  }

  Future<void> delete(ModelSpec model) async {
    cancelDownload(model);
    final dir = Directory(modelDir(model));
    if (await dir.exists()) {
      await dir.delete(recursive: true);
    }
    await _refreshDownloadedIds();
    notifyListeners();
  }

  /// ENOSPC ("No space left on device") on both Android and iOS.
  static const _enospc = 28;

  static const _deviceInfoChannel = MethodChannel('talkpuppy/device_info');

  Future<void> _ensureFreeSpace(String dirPath, ModelSpec model) async {
    // Best effort: if the lookup fails we just try the download, and a
    // full disk surfaces as ENOSPC instead.
    final int? available;
    try {
      available = await _deviceInfoChannel.invokeMethod<int>(
        'freeDiskBytes',
        {'path': dirPath},
      );
    } catch (_) {
      return;
    }
    if (available != null &&
        available < model.totalSizeBytes + 50 * 1024 * 1024) {
      throw ModelDownloadException(
        DownloadErrorKind.noSpace,
        modelName: model.displayName,
      );
    }
  }

  Future<void> _downloadFile({
    required Dio dio,
    required String url,
    required File target,
    required ModelFileSpec spec,
    required CancelToken cancelToken,
    required void Function(int receivedBytes) onBytesReceived,
  }) async {
    final partFile = File('${target.path}.part');
    var startBytes = await partFile.exists() ? await partFile.length() : 0;
    if (startBytes >= spec.sizeBytes) {
      // Either complete-but-unverified or garbage; re-verify from scratch
      // rather than asking the server for a range past the end (416).
      await partFile.delete();
      startBytes = 0;
    }

    Response<ResponseBody> response;
    try {
      response = await dio.get<ResponseBody>(
        url,
        options: Options(
          responseType: ResponseType.stream,
          headers: startBytes > 0 ? {'range': 'bytes=$startBytes-'} : null,
          followRedirects: true,
        ),
        cancelToken: cancelToken,
      );
    } on DioException catch (e) {
      if (e.response?.statusCode == 416 && startBytes > 0) {
        await partFile.delete();
        return _downloadFile(
          dio: dio,
          url: url,
          target: target,
          spec: spec,
          cancelToken: cancelToken,
          onBytesReceived: onBytesReceived,
        );
      }
      rethrow;
    }

    // Integrity is covered by the hash, but don't let a redirect downgrade
    // the transfer to plain HTTP either.
    if (response.realUri.scheme != 'https') {
      throw ModelDownloadException(DownloadErrorKind.notModelFile);
    }

    final status = response.statusCode ?? 0;
    final contentType = response.headers.value('content-type') ?? '';
    if ((status != 200 && status != 206) || contentType.contains('text/html')) {
      // Typical for captive portals: a login page instead of the file.
      throw ModelDownloadException(DownloadErrorKind.notModelFile);
    }
    // Server ignored our range request and sent the full file: start over.
    if (startBytes > 0 && status != 206) {
      startBytes = 0;
    }

    final sink = partFile.openWrite(
      mode: startBytes > 0 ? FileMode.append : FileMode.write,
    );
    var received = startBytes;
    onBytesReceived(received);
    try {
      await for (final chunk in response.data!.stream) {
        sink.add(chunk);
        received += chunk.length;
        onBytesReceived(received);
      }
    } catch (_) {
      // Keep the original error; a failing close (e.g. disk full) would
      // otherwise replace it.
      await sink.close().catchError((_) {});
      rethrow;
    }
    // Write errors such as ENOSPC surface here.
    await sink.close();

    final actualSize = await partFile.length();
    final actualHash = actualSize == spec.sizeBytes
        ? await _sha256Of(partFile.path)
        : null;
    if (actualHash != spec.sha256) {
      await partFile.delete();
      throw ModelDownloadException(
        DownloadErrorKind.corrupt,
        fileName: spec.remoteName,
      );
    }
    await partFile.rename(target.path);
  }

  /// Hashes a (possibly several hundred MB) file off the UI isolate.
  static Future<String> _sha256Of(String path) {
    return Isolate.run(() async {
      final digest = await sha256.bind(File(path).openRead()).first;
      return digest.toString();
    });
  }
}
