import 'package:flutter/material.dart';

/// The Talkpuppy mascot, kept in one widget so the in-app mark always uses
/// the same generated PNG and sizing rules.
class BrandMark extends StatelessWidget {
  const BrandMark({super.key, this.size = 48, this.showBackdrop = false});

  final double size;
  final bool showBackdrop;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final image = Image.asset(
      'assets/branding/talkpuppy_logo.png',
      width: size,
      height: size,
      fit: BoxFit.contain,
      semanticLabel: 'Talkpuppy Logo',
    );

    if (!showBackdrop) return image;

    return Container(
      width: size,
      height: size,
      padding: EdgeInsets.all(size * 0.06),
      decoration: BoxDecoration(
        color: scheme.surfaceContainerHighest,
        shape: BoxShape.circle,
        boxShadow: [
          BoxShadow(
            color: scheme.primary.withValues(alpha: 0.20),
            blurRadius: size * 0.18,
            offset: Offset(0, size * 0.06),
          ),
        ],
      ),
      child: image,
    );
  }
}
