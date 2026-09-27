/// Outcome of transcribing one clip.
enum ClipStatus { done, error }

/// One recorded-and-transcribed audio segment. A [Recording] can hold
/// several clips when the user used "weiter aufnehmen" (continue recording)
/// to append more speech to an existing entry.
class Clip {
  const Clip({
    required this.id,
    required this.wavFileName,
    required this.text,
    required this.language,
    required this.modelId,
    required this.durationMs,
    required this.createdAt,
    this.status = ClipStatus.done,
  });

  factory Clip.fromJson(Map<String, dynamic> json) {
    return Clip(
      id: json['id'] as String,
      wavFileName: json['wavFileName'] as String,
      text: json['text'] as String? ?? '',
      language: json['language'] as String? ?? '',
      modelId: json['modelId'] as String? ?? '',
      durationMs: json['durationMs'] as int? ?? 0,
      createdAt: DateTime.parse(json['createdAt'] as String),
      status: ClipStatus.values.firstWhere(
        (s) => s.name == json['status'],
        orElse: () => ClipStatus.done,
      ),
    );
  }

  final String id;

  /// File name (not a full path) of the WAV recording, stored next to
  /// `recordings.json` in the history directory.
  final String wavFileName;
  final String text;

  /// ISO-639-1 code the recognizer detected or was forced to use. Empty if
  /// unknown (e.g. an errored clip).
  final String language;
  final String modelId;
  final int durationMs;
  final DateTime createdAt;
  final ClipStatus status;

  Clip copyWith({
    String? text,
    String? language,
    String? modelId,
    ClipStatus? status,
  }) {
    return Clip(
      id: id,
      wavFileName: wavFileName,
      text: text ?? this.text,
      language: language ?? this.language,
      modelId: modelId ?? this.modelId,
      durationMs: durationMs,
      createdAt: createdAt,
      status: status ?? this.status,
    );
  }

  Map<String, dynamic> toJson() => {
    'id': id,
    'wavFileName': wavFileName,
    'text': text,
    'language': language,
    'modelId': modelId,
    'durationMs': durationMs,
    'createdAt': createdAt.toIso8601String(),
    'status': status.name,
  };
}

/// One history entry, possibly made up of several appended [Clip]s.
class Recording {
  Recording({
    required this.id,
    required this.createdAt,
    required this.updatedAt,
    required List<Clip> clips,
  }) : clips = List.of(clips);

  factory Recording.fromJson(Map<String, dynamic> json) {
    return Recording(
      id: json['id'] as String,
      createdAt: DateTime.parse(json['createdAt'] as String),
      updatedAt: DateTime.parse(json['updatedAt'] as String),
      clips: (json['clips'] as List<dynamic>)
          .map((c) => Clip.fromJson(c as Map<String, dynamic>))
          .toList(),
    );
  }

  final String id;
  final DateTime createdAt;
  DateTime updatedAt;
  final List<Clip> clips;

  /// All clip texts joined into one readable transcript.
  String get text => clips
      .map((c) => c.text.trim())
      .where((t) => t.isNotEmpty)
      .join('\n\n');

  int get totalDurationMs => clips.fold(0, (sum, c) => sum + c.durationMs);

  bool get hasError => clips.any((c) => c.status == ClipStatus.error);

  /// Language of the most recent clip, shown as a small badge in the UI.
  String get latestLanguage =>
      clips.isEmpty ? '' : clips.last.language;

  Map<String, dynamic> toJson() => {
    'id': id,
    'createdAt': createdAt.toIso8601String(),
    'updatedAt': updatedAt.toIso8601String(),
    'clips': clips.map((c) => c.toJson()).toList(),
  };
}
