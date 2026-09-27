import 'package:flutter/material.dart';

/// A record button that supports both interaction styles from the plan in
/// one gesture area:
///
/// * A quick tap toggles recording on, then off again on the next tap.
/// * Press and hold (~300ms) switches to push-to-talk: recording starts
///   once the hold threshold passes and stops the instant the finger lifts.
///
/// The button doesn't track "am I recording" itself — that's driven by
/// [isActive] from [AppController.phase], since a toggle-started recording
/// must survive a completely separate, later tap gesture.
class RecordButton extends StatefulWidget {
  const RecordButton({
    super.key,
    required this.isActive,
    required this.enabled,
    required this.onStart,
    required this.onStop,
    required this.icon,
    required this.label,
    this.amplitude = 0,
  });

  final bool isActive;
  final bool enabled;
  final VoidCallback onStart;
  final VoidCallback onStop;
  final IconData icon;
  final String label;

  /// 0..1 microphone level, used to pulse the ring while [isActive].
  final double amplitude;

  @override
  State<RecordButton> createState() => _RecordButtonState();
}

class _RecordButtonState extends State<RecordButton> {
  static const _holdThreshold = Duration(milliseconds: 300);

  bool _isPushToTalk = false;

  void _handleTapDown(TapDownDetails details) {
    if (!widget.enabled) return;
    _isPushToTalk = false;
    Future.delayed(_holdThreshold, () {
      if (!mounted) return;
      // Still pressed and not already recording from an earlier toggle-on?
      if (_pointerDown && !widget.isActive) {
        _isPushToTalk = true;
        widget.onStart();
      }
    });
    _pointerDown = true;
  }

  bool _pointerDown = false;

  void _handleTapUp(TapUpDetails details) => _handleRelease();

  void _handleTapCancel() => _handleRelease();

  void _handleRelease() {
    if (!_pointerDown) return;
    _pointerDown = false;
    if (_isPushToTalk) {
      _isPushToTalk = false;
      widget.onStop();
      return;
    }
    if (!widget.enabled) return;
    // A plain tap: toggle.
    if (widget.isActive) {
      widget.onStop();
    } else {
      widget.onStart();
    }
  }

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final size = 88.0 + widget.amplitude * 20;

    return GestureDetector(
      onTapDown: _handleTapDown,
      onTapUp: _handleTapUp,
      onTapCancel: _handleTapCancel,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          AnimatedContainer(
            duration: const Duration(milliseconds: 120),
            curve: Curves.easeOut,
            width: size,
            height: size,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: widget.isActive
                  ? scheme.error
                  : widget.enabled
                  ? scheme.primary
                  : scheme.surfaceContainerHighest,
              boxShadow: widget.isActive
                  ? [
                      BoxShadow(
                        color: scheme.error.withValues(alpha: 0.35),
                        blurRadius: 24,
                        spreadRadius: 4,
                      ),
                    ]
                  : null,
            ),
            child: Icon(
              widget.icon,
              size: 36,
              color: widget.enabled
                  ? (widget.isActive ? scheme.onError : scheme.onPrimary)
                  : scheme.onSurfaceVariant,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            widget.label,
            style: Theme.of(context).textTheme.labelLarge?.copyWith(
              color: widget.enabled
                  ? scheme.onSurface
                  : scheme.onSurfaceVariant,
            ),
          ),
        ],
      ),
    );
  }
}
