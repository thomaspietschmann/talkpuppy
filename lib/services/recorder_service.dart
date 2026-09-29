import 'dart:async';
import 'dart:typed_data';

import 'package:record/record.dart';

import 'wav_stream_writer.dart';

/// Records microphone audio straight to a 16 kHz mono WAV file, which is
/// exactly what sherpa-onnx's `readWave` expects — no conversion step
/// needed between recording and transcription.
abstract class RecorderService {
  /// Amplitude updates (roughly -45..0 dBFS) while recording, used to drive
  /// the record button's pulsing ring.
  Stream<double> get amplitudeStream;

  /// Fires when the system interrupts the recording (incoming call,
  /// alarm, Siri, another app taking audio focus). The platform pauses the
  /// microphone by itself; the app never pauses on its own, so any pause
  /// is an interruption.
  Stream<void> get interruptions;

  Future<bool> hasPermission();

  /// Starts recording to [path]. With [onSamples], the audio is also
  /// handed out while recording (16 kHz mono floats in -1..1, roughly every
  /// 100 ms) — used for the streaming model's live preview.
  Future<void> start(
    String path, {
    void Function(Float32List samples)? onSamples,
  });

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

  /// Set while recording in stream mode (see [start]'s `onSamples`).
  WavStreamWriter? _streamWriter;

  static const _fileConfig = RecordConfig(
    encoder: AudioEncoder.wav,
    sampleRate: 16000,
    numChannels: 1,
  );

  static const _streamConfig = RecordConfig(
    encoder: AudioEncoder.pcm16bits,
    sampleRate: 16000,
    numChannels: 1,
  );

  @override
  Stream<double> get amplitudeStream {
    final writer = _streamWriter;
    if (writer != null) return writer.amplitude.stream;
    return _recorder
        .onAmplitudeChanged(const Duration(milliseconds: 100))
        .map((a) => a.current);
  }

  @override
  Stream<void> get interruptions => _recorder
      .onStateChanged()
      .where((state) => state == RecordState.pause)
      .map((_) {});

  @override
  Future<bool> hasPermission() => _recorder.hasPermission();

  @override
  Future<void> start(
    String path, {
    void Function(Float32List samples)? onSamples,
  }) async {
    _startedAt = DateTime.now();
    if (onSamples == null) {
      await _recorder.start(_fileConfig, path: path);
      return;
    }
    // The plugin can either write a file or hand out PCM, not both — so in
    // stream mode we write the WAV file ourselves.
    final writer = await WavStreamWriter.open(path, onSamples);
    _streamWriter = writer;
    try {
      writer.listen(await _recorder.startStream(_streamConfig));
    } catch (_) {
      _streamWriter = null;
      await writer.close();
      rethrow;
    }
  }

  @override
  Future<Duration> stop() async {
    await _recorder.stop();
    await _closeStreamWriter();
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
    await _closeStreamWriter();
  }

  Future<void> _closeStreamWriter() async {
    final writer = _streamWriter;
    _streamWriter = null;
    await writer?.close();
  }

  @override
  Future<bool> isRecording() => _recorder.isRecording();

  @override
  Future<void> dispose() async {
    await _closeStreamWriter();
    await _recorder.dispose();
  }
}
