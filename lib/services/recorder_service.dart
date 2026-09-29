import 'dart:async';
import 'dart:io';
import 'dart:math' as math;
import 'dart:typed_data';

import 'package:record/record.dart';

/// Records microphone audio straight to a 16 kHz mono WAV file, which is
/// exactly what sherpa-onnx's `readWave` expects — no conversion step
/// needed between recording and transcription.
abstract class RecorderService {
  /// Amplitude updates (roughly -45..0 dBFS) while recording, used to drive
  /// the record button's pulsing ring.
  Stream<double> get amplitudeStream;

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
  _WavStreamWriter? _streamWriter;

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
    final writer = await _WavStreamWriter.open(path, onSamples);
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

/// Writes 16-bit PCM from the recorder's stream into a WAV file and passes
/// the same audio on as floats. Also derives the amplitude (dBFS) the file
/// recorder would otherwise report.
class _WavStreamWriter {
  _WavStreamWriter._(this._file, this._sink, this._onSamples);

  static const _sampleRate = 16000;
  static const _headerBytes = 44;

  final File _file;
  final IOSink _sink;
  final void Function(Float32List samples) _onSamples;
  final amplitude = StreamController<double>.broadcast();
  StreamSubscription<Uint8List>? _sub;
  final _done = Completer<void>();
  int _dataBytes = 0;

  /// A chunk may end in the middle of a 16-bit sample; its first byte waits
  /// here for the next chunk.
  int? _carry;

  static Future<_WavStreamWriter> open(
    String path,
    void Function(Float32List samples) onSamples,
  ) async {
    final file = File(path);
    final sink = file.openWrite();
    // Placeholder; the sizes are filled in by close().
    sink.add(Uint8List(_headerBytes));
    return _WavStreamWriter._(file, sink, onSamples);
  }

  void listen(Stream<Uint8List> pcm) {
    _sub = pcm.listen(
      _onChunk,
      onDone: () {
        if (!_done.isCompleted) _done.complete();
      },
      onError: (Object _) {
        if (!_done.isCompleted) _done.complete();
      },
    );
  }

  void _onChunk(Uint8List chunk) {
    var bytes = chunk;
    final carry = _carry;
    if (carry != null) {
      bytes = Uint8List(chunk.length + 1)
        ..[0] = carry
        ..setRange(1, chunk.length + 1, chunk);
      _carry = null;
    }
    if (bytes.length.isOdd) {
      _carry = bytes.last;
      bytes = Uint8List.sublistView(bytes, 0, bytes.length - 1);
    }
    if (bytes.isEmpty) return;

    _sink.add(bytes);
    _dataBytes += bytes.length;

    final pcm = ByteData.sublistView(bytes);
    final samples = Float32List(bytes.length ~/ 2);
    var peak = 0.0;
    for (var i = 0; i < samples.length; i++) {
      final v = pcm.getInt16(i * 2, Endian.little) / 32768.0;
      samples[i] = v;
      if (v.abs() > peak) peak = v.abs();
    }
    _onSamples(samples);
    amplitude.add(
      peak <= 0 ? -160 : 20 * math.log(peak) / math.ln10,
    );
  }

  Future<void> close() async {
    // The plugin closes the stream on stop/cancel; don't hang if it
    // doesn't.
    await _done.future.timeout(
      const Duration(seconds: 2),
      onTimeout: () {},
    );
    await _sub?.cancel();
    await _sink.close();
    await amplitude.close();
    await _writeHeader();
  }

  Future<void> _writeHeader() async {
    if (!await _file.exists()) return;
    final header = ByteData(_headerBytes);
    void ascii(int offset, String s) {
      for (var i = 0; i < s.length; i++) {
        header.setUint8(offset + i, s.codeUnitAt(i));
      }
    }

    ascii(0, 'RIFF');
    header.setUint32(4, 36 + _dataBytes, Endian.little);
    ascii(8, 'WAVE');
    ascii(12, 'fmt ');
    header.setUint32(16, 16, Endian.little); // fmt chunk size
    header.setUint16(20, 1, Endian.little); // PCM
    header.setUint16(22, 1, Endian.little); // mono
    header.setUint32(24, _sampleRate, Endian.little);
    header.setUint32(28, _sampleRate * 2, Endian.little); // byte rate
    header.setUint16(32, 2, Endian.little); // block align
    header.setUint16(34, 16, Endian.little); // bits per sample
    ascii(36, 'data');
    header.setUint32(40, _dataBytes, Endian.little);

    final raf = await _file.open(mode: FileMode.writeOnlyAppend);
    try {
      await raf.setPosition(0);
      await raf.writeFrom(header.buffer.asUint8List());
    } finally {
      await raf.close();
    }
  }
}
