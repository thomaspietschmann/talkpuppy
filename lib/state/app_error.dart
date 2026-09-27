/// What went wrong, independent of the UI language. The UI turns this into
/// a localized message (see `l10n/l10n_text.dart`).
enum AppErrorKind {
  micPermission,
  recorderStart,
  recorderStop,
  transcription,
  retranscribe,
  modelLoad,
  noModel,
}

class AppError {
  const AppError(this.kind, {this.detail = '', this.modelName = ''});

  final AppErrorKind kind;

  /// Technical detail (usually an exception message), shown in parentheses.
  final String detail;

  /// Display name of the model involved, for [AppErrorKind.modelLoad].
  final String modelName;

  @override
  String toString() => 'AppError($kind, $modelName, $detail)';
}
