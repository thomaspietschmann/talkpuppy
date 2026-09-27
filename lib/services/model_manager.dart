import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:path/path.dart' as p;
import 'package:path_provider/path_provider.dart';

import '../models/catalog.dart';
import '../models/model_spec.dart';

/// Combined download progress across all files of one model.
class DownloadProgress {
  const DownloadProgress({required this.receivedBytes, required this.totalBytes});

  final int receivedBytes;
  final int totalBytes;

  double get fraction => totalBytes == 0 ? 0 : receivedBytes / totalBytes;
}

/// Downloads, verifies presence of, and deletes on-device model files.
///
/// Each model lives at `<app support dir>/models/<modelId>/<localName>`.
/// Downloads are resumable: an interrupted file is kept as `<name>.part`
/// and continued (via an HTTP Range request) the next time it's requested.
class ModelManager extends ChangeNotifier {
  ModelManager(this._modelsRootDir);

  final Directory _modelsRootDir;
  final Map<String, CancelToken> _activeCancelTokens = {};
  Set<String> _downloadedIds = {};

  static const _backupChannel = MethodChannel('talkpuppy/ios_backup');

  static Future<ModelManager> create() async {
    final supportDir = await getApplicationSupportDirectory();
    final dir = Directory(p.join(supportDir.path, 'models'));
    if (!await dir.exists()) {
      await dir.create(recursive: true);
    }
    final manager = ModelManager(dir);
    await manager._refreshDownloadedIds();
    return manager;
  }

  /// Synchronous, cached view of which models are downloaded — refreshed
  /// after every [download] and [delete] call. Prefer this in UI code over
  /// [downloadedModelIds] to avoid re-scanning the filesystem on rebuild.
  Set<String> get downloadedIds => Set.unmodifiable(_downloadedIds);

  Future<void> _refreshDownloadedIds() async {
    _downloadedIds = await downloadedModelIds();
  }

  String modelDir(ModelSpec model) => p.join(_modelsRootDir.path, model.id);

  Future<bool> isDownloaded(ModelSpec model) async {
    for (final f in model.files) {
      if (!await File(p.join(modelDir(model), f.localName)).exists()) {
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
  /// skipping files that already exist. Reports combined progress across
  /// all of the model's files.
  Future<void> download(
    ModelSpec model, {
    required void Function(DownloadProgress progress) onProgress,
  }) async {
    final dir = Directory(modelDir(model));
    if (!await dir.exists()) {
      await dir.create(recursive: true);
    }

    final cancelToken = CancelToken();
    _activeCancelTokens[model.id] = cancelToken;

    final receivedPerFile = List<int>.filled(model.files.length, 0);
    final totalBytes = model.totalSizeBytes;

    void reportProgress() {
      final received = receivedPerFile.fold<int>(0, (a, b) => a + b);
      onProgress(
        DownloadProgress(receivedBytes: received, totalBytes: totalBytes),
      );
    }

    try {
      for (var i = 0; i < model.files.length; i++) {
        final fileSpec = model.files[i];
        final targetPath = p.join(dir.path, fileSpec.localName);
        if (await File(targetPath).exists()) {
          receivedPerFile[i] = fileSpec.sizeBytes;
          reportProgress();
          continue;
        }
        await _downloadFile(
          url: '${model.baseUrl}${fileSpec.remoteName}',
          targetPath: targetPath,
          cancelToken: cancelToken,
          onBytesReceived: (received) {
            receivedPerFile[i] = received;
            reportProgress();
          },
        );
      }
      if (Platform.isIOS) {
        await _excludeFromICloudBackup(dir.path);
      }
    } finally {
      _activeCancelTokens.remove(model.id);
    }
    await _refreshDownloadedIds();
    notifyListeners();
  }

  void cancelDownload(ModelSpec model) {
    _activeCancelTokens[model.id]?.cancel('cancelled by user');
  }

  Future<void> delete(ModelSpec model) async {
    final dir = Directory(modelDir(model));
    if (await dir.exists()) {
      await dir.delete(recursive: true);
    }
    await _refreshDownloadedIds();
    notifyListeners();
  }

  Future<void> _downloadFile({
    required String url,
    required String targetPath,
    required CancelToken cancelToken,
    required void Function(int receivedBytes) onBytesReceived,
  }) async {
    final partFile = File('$targetPath.part');
    var startBytes = await partFile.exists() ? await partFile.length() : 0;

    final dio = Dio();
    final response = await dio.get<ResponseBody>(
      url,
      options: Options(
        responseType: ResponseType.stream,
        headers: startBytes > 0 ? {'range': 'bytes=$startBytes-'} : null,
        followRedirects: true,
      ),
      cancelToken: cancelToken,
    );

    // If we asked for a range but the server ignored it (sent 200 with the
    // full body instead of 206 with the remainder), start this file over.
    if (startBytes > 0 && response.statusCode != 206) {
      startBytes = 0;
    }

    final sink = partFile.openWrite(
      mode: startBytes > 0 ? FileMode.append : FileMode.write,
    );
    var received = startBytes;
    onBytesReceived(received);
    await for (final chunk in response.data!.stream) {
      sink.add(chunk);
      received += chunk.length;
      onBytesReceived(received);
    }
    await sink.flush();
    await sink.close();

    await partFile.rename(targetPath);
  }

  Future<void> _excludeFromICloudBackup(String path) async {
    try {
      await _backupChannel.invokeMethod('excludeFromBackup', {'path': path});
    } catch (_) {
      // Best-effort: a failed exclusion just means the model counts
      // against the user's iCloud backup quota, nothing breaks.
    }
  }
}
