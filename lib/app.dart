import 'package:dynamic_color/dynamic_color.dart';
import 'package:flutter/material.dart';

import 'ui/home_screen.dart';

/// Root widget. Uses Material 3 with dynamic color on Android when
/// available, falling back to a calm, single-accent seed theme everywhere
/// else (including iOS).
class TalkpuppyApp extends StatelessWidget {
  const TalkpuppyApp({super.key});

  static const _seedColor = Color(0xFF3A6EA5);

  @override
  Widget build(BuildContext context) {
    return DynamicColorBuilder(
      builder: (lightDynamic, darkDynamic) {
        final lightScheme =
            lightDynamic?.harmonized() ??
            ColorScheme.fromSeed(
              seedColor: _seedColor,
              brightness: Brightness.light,
            );
        final darkScheme =
            darkDynamic?.harmonized() ??
            ColorScheme.fromSeed(
              seedColor: _seedColor,
              brightness: Brightness.dark,
            );

        return MaterialApp(
          title: 'Talkpuppy',
          debugShowCheckedModeBanner: false,
          themeMode: ThemeMode.system,
          theme: _buildTheme(lightScheme),
          darkTheme: _buildTheme(darkScheme),
          home: const HomeScreen(),
        );
      },
    );
  }

  ThemeData _buildTheme(ColorScheme scheme) {
    return ThemeData(
      useMaterial3: true,
      colorScheme: scheme,
      scaffoldBackgroundColor: scheme.surface,
      appBarTheme: AppBarTheme(
        backgroundColor: scheme.surface,
        surfaceTintColor: scheme.surfaceTint,
        elevation: 0,
        centerTitle: false,
      ),
      textTheme: Typography.material2021(
        colorScheme: scheme,
      ).englishLike.apply(fontSizeFactor: 1.0),
      cardTheme: CardThemeData(
        elevation: 0,
        color: scheme.surfaceContainerLow,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
      ),
      filledButtonTheme: FilledButtonThemeData(
        style: FilledButton.styleFrom(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
        ),
      ),
      snackBarTheme: SnackBarThemeData(
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
      ),
    );
  }
}
