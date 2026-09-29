import 'dart:async';
import 'dart:io';
import 'dart:typed_data';

import 'package:flutter_test/flutter_test.dart';
import 'package:talkpuppy/services/wav_stream_writer.dart';

void main() {
  late Directory tempDir;

  setUp(() {
    tempDir = Directory.systemTemp.createTempSync('talkpuppy_wav_test_');
  });

  tearDown(() => tempDir.deleteSync(recursive: true));

  Uint8List pcm(List<int> samples) {
    final data = ByteData(samples.length * 2);
    for (var i = 0; i < samples.length; i++) {
      data.setInt16(i * 2, samples[i], Endian.little);
    }
    return data.buffer.asUint8List();
  }

  test('writes a valid 16 kHz mono WAV and passes the samples on', () async {
    final path = '${tempDir.path}/a.wav';
    final received = <double>[];
    final writer = await WavStreamWriter.open(path, received.addAll);
    final amplitudes = <double>[];
    writer.amplitude.stream.listen(amplitudes.add);

    final controller = StreamController<Uint8List>();
    writer.listen(controller.stream);
    final bytes = pcm([0, 16384, -32768, 32767]);
    // Split in the middle of a sample to exercise the byte carry.
    controller.add(Uint8List.sublistView(bytes, 0, 3));
    controller.add(Uint8List.sublistView(bytes, 3));
    await controller.close();
    await writer.close();

    final file = await File(path).readAsBytes();
    final header = ByteData.sublistView(file, 0, 44);
    String ascii(int offset) =>
        String.fromCharCodes(file.sublist(offset, offset + 4));
    expect(ascii(0), 'RIFF');
    expect(header.getUint32(4, Endian.little), 36 + 8);
    expect(ascii(8), 'WAVE');
    expect(ascii(12), 'fmt ');
    expect(header.getUint16(20, Endian.little), 1); // PCM
    expect(header.getUint16(22, Endian.little), 1); // mono
    expect(header.getUint32(24, Endian.little), 16000);
    expect(header.getUint32(28, Endian.little), 32000);
    expect(header.getUint16(32, Endian.little), 2);
    expect(header.getUint16(34, Endian.little), 16);
    expect(ascii(36), 'data');
    expect(header.getUint32(40, Endian.little), 8);
    expect(file.sublist(44), bytes);

    expect(received, [0.0, 0.5, -1.0, 32767 / 32768]);
    // The first chunk only holds the silent sample (its odd byte waits for
    // the next chunk); the second peaks at full scale.
    expect(amplitudes, [-160, closeTo(0, 0.01)]);
  });

  test('drops a trailing half sample', () async {
    final path = '${tempDir.path}/b.wav';
    final writer = await WavStreamWriter.open(path, (_) {});
    final controller = StreamController<Uint8List>();
    writer.listen(controller.stream);
    controller.add(Uint8List.fromList([1, 0, 2]));
    await controller.close();
    await writer.close();

    final file = await File(path).readAsBytes();
    expect(file.length, 44 + 2);
    expect(ByteData.sublistView(file).getUint32(40, Endian.little), 2);
  });

  test('closing without a stream does not wait for it', () async {
    final writer = await WavStreamWriter.open('${tempDir.path}/c.wav', (_) {});
    final watch = Stopwatch()..start();
    await writer.close();
    expect(watch.elapsed, lessThan(const Duration(milliseconds: 500)));
  });
}
