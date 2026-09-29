import 'package:flutter/widgets.dart';

import '../models/model_spec.dart';
import '../services/model_manager.dart';
import '../state/app_error.dart';
import 'app_localizations.dart';

extension L10nContext on BuildContext {
  AppLocalizations get l10n => AppLocalizations.of(this);
}

String appErrorText(AppLocalizations l, AppError e) => switch (e.kind) {
  AppErrorKind.micPermission => l.errorMicPermission,
  AppErrorKind.recorderStart => l.errorRecorderStart(e.detail),
  AppErrorKind.recorderStop => l.errorRecorderStop(e.detail),
  AppErrorKind.transcription => l.errorTranscription(e.detail),
  AppErrorKind.retranscribe => l.errorRetranscribe(e.detail),
  AppErrorKind.modelLoad => l.errorModelLoad(e.modelName, e.detail),
  AppErrorKind.noModel => l.errorNoModel,
};

/// Localized message for anything thrown by a model download.
String downloadErrorText(AppLocalizations l, Object error) {
  if (error is! ModelDownloadException) return l.downloadFailed('$error');
  return switch (error.kind) {
    DownloadErrorKind.alreadyRunning => l.downloadAlreadyRunning(error.modelName),
    DownloadErrorKind.cancelled => l.downloadCancelled,
    DownloadErrorKind.network => l.downloadNetworkError,
    DownloadErrorKind.notModelFile => l.downloadNotModelFile,
    DownloadErrorKind.corrupt => l.downloadCorrupt(error.fileName),
    DownloadErrorKind.noSpace => l.downloadNoSpace(error.modelName),
  };
}

String modelDescription(AppLocalizations l, ModelSpec model) =>
    switch (model.id) {
      'parakeet-tdt-0.6b-v3-int8' => l.modelDescParakeet,
      'nemotron-3.5-streaming-0.6b-1120ms-int8' => l.modelDescNemotron,
      'whisper-small-int8' => l.modelDescWhisperSmall,
      'whisper-base-int8' => l.modelDescWhisperBase,
      _ => l.modelDescWhisperTiny,
    };

int megabytes(int bytes) => (bytes / (1024 * 1024)).round();
