import 'package:flutter/material.dart';

/// A record button using a simple tap-to-toggle interaction: tap once to
/// start, tap again to stop. (Push-to-talk/hold was tried and removed —
/// it confused more than it helped.)
class RecordButton extends StatelessWidget {
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

  void _handleTap() {
    if (!enabled) return;
    if (isActive) {
      onStop();
    } else {
      onStart();
    }
  }

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final size = 88.0 + amplitude * 20;

    return GestureDetector(
      onTap: _handleTap,
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
              color: isActive
                  ? scheme.error
                  : enabled
                  ? scheme.primary
                  : scheme.surfaceContainerHighest,
              boxShadow: isActive
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
              icon,
              size: 36,
              color: enabled
                  ? (isActive ? scheme.onError : scheme.onPrimary)
                  : scheme.onSurfaceVariant,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            label,
            style: Theme.of(context).textTheme.labelLarge?.copyWith(
              color: enabled ? scheme.onSurface : scheme.onSurfaceVariant,
            ),
          ),
        ],
      ),
    );
  }
}
