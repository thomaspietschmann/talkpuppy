import 'package:record/record.dart';

/// Records microphone audio straight to a 16 kHz mono WAV file, which is
/// exactly what sherpa-onnx's `readWave` expects — no conversion step
/// needed between recording and transcription.
abstract class RecorderService {
  /// Amplitude updates (roughly -45..0 dBFS) while recording, used to drive
  /// the record button's pulsing ring.
  Stream<double> get amplitudeStream;

  Future<bool> hasPermission();

  Future<void> start(String path);

  /// Stops recording and returns how long it lasted.
  Future<Duration> stop();

  /// Stops and discards the current recording (e.g. on error).
  Future<void> cancel();

  Future<bool> isRecording();

  Future<void> dispose();
}

class MicRecorderService implements RecorderService {
  MicRecorderService() : _recorder = AudioRecorder();

  final AudioRecorder _recorder;
  DateTime? _startedAt;

  static const _config = RecordConfig(
    encoder: AudioEncoder.wav,
    sampleRate: 16000,
    numChannels: 1,
  );

  @override
  Stream<double> get amplitudeStream => _recorder
      .onAmplitudeChanged(const Duration(milliseconds: 100))
      .map((a) => a.current);

  @override
  Future<bool> hasPermission() => _recorder.hasPermission();

  @override
  Future<void> start(String path) async {
    _startedAt = DateTime.now();
    await _recorder.start(_config, path: path);
  }

  @override
  Future<Duration> stop() async {
    await _recorder.stop();
    final startedAt = _startedAt;
    _startedAt = null;
    return startedAt == null
        ? Duration.zero
        : DateTime.now().difference(startedAt);
  }

  @override
  Future<void> cancel() async {
    _startedAt = null;
    await _recorder.cancel();
  }

  @override
  Future<bool> isRecording() => _recorder.isRecording();

  @override
  Future<void> dispose() => _recorder.dispose();
}
