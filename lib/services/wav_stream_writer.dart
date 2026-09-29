import 'dart:async';
import 'dart:io';
import 'dart:math' as math;
import 'dart:typed_data';

/// Writes 16-bit PCM from the recorder's stream into a WAV file and passes
/// the same audio on as floats. Also derives the amplitude (dBFS) the file
/// recorder would otherwise report.
class WavStreamWriter {
  WavStreamWriter._(this._file, this._sink, this._onSamples);

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

  static Future<WavStreamWriter> open(
    String path,
    void Function(Float32List samples) onSamples,
  ) async {
    final file = File(path);
    final sink = file.openWrite();
    // Placeholder; the sizes are filled in by close().
    sink.add(Uint8List(_headerBytes));
    return WavStreamWriter._(file, sink, onSamples);
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
    // Never listened (startStream failed): there's nothing to wait for.
    if (_sub == null && !_done.isCompleted) _done.complete();
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
