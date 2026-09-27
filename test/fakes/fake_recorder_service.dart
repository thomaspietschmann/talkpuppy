import 'dart:async';
import 'dart:io';

import 'package:talkpuppy/services/recorder_service.dart';

/// A [RecorderService] that writes a fixed byte pattern instead of touching
/// the microphone, and reports a duration you control — so tests can
/// exercise the "clip too short, discard" path deterministically.
class FakeRecorderService implements RecorderService {
  Duration nextDuration = const Duration(seconds: 2);
  bool permissionGranted = true;
  String? lastStartedPath;
  bool recording = false;
  void Function()? onStart;

  final _amplitudeController = StreamController<double>.broadcast();

  @override
  Stream<double> get amplitudeStream => _amplitudeController.stream;

  @override
  Future<bool> hasPermission() async => permissionGranted;

  @override
  Future<void> start(String path) async {
    onStart?.call();
    lastStartedPath = path;
    recording = true;
    await File(path).writeAsBytes([0, 1, 2, 3]);
  }

  @override
  Future<Duration> stop() async {
    recording = false;
    return nextDuration;
  }

  @override
  Future<void> cancel() async {
    recording = false;
  }

  @override
  Future<bool> isRecording() async => recording;

  @override
  Future<void> dispose() async {
    await _amplitudeController.close();
  }
}
