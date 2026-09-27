import 'package:flutter/material.dart';

import 'l10n/locales.dart';
import 'state/controller_scope.dart';
import 'ui/home_screen.dart';

/// Root widget. Uses a fixed Talkpuppy brand system so the experience is
/// recognisable on every platform instead of changing with device wallpaper.
class TalkpuppyApp extends StatelessWidget {
  const TalkpuppyApp({super.key});

  static const _ink = Color(0xFF15131F);
  static const _magenta = Color(0xFFEC2D78);
  static const _cyan = Color(0xFF00C7D9);
  static const _gold = Color(0xFFFFC857);

  @override
  Widget build(BuildContext context) {
    final lightScheme = _buildScheme(Brightness.light);
    final darkScheme = _buildScheme(Brightness.dark);
    final settings = ControllerScope.of(context).settings;

    return ListenableBuilder(
      listenable: settings,
      builder: (context, _) {
        final chosen = settings.appLanguage;
        return MaterialApp(
          title: 'Talkpuppy',
          debugShowCheckedModeBanner: false,
          themeMode: ThemeMode.system,
          theme: _buildTheme(lightScheme),
          darkTheme: _buildTheme(darkScheme),
          // Null follows the system; the resolution callback then maps the
          // device languages onto the ones the app ships.
          locale: chosen == null ? null : Locale(chosen),
          supportedLocales: [for (final code in kAppLanguages.keys) Locale(code)],
          localizationsDelegates: kLocalizationsDelegates,
          localeListResolutionCallback: (deviceLocales, _) =>
              resolveAppLocale(deviceLocales),
          home: const HomeScreen(),
        );
      },
    );
  }

  ColorScheme _buildScheme(Brightness brightness) {
    final isDark = brightness == Brightness.dark;
    final base = ColorScheme.fromSeed(
      seedColor: _magenta,
      brightness: brightness,
    );

    return base.copyWith(
      primary: _magenta,
      onPrimary: Colors.white,
      primaryContainer: isDark
          ? const Color(0xFF64163D)
          : const Color(0xFFFFD8E7),
      onPrimaryContainer: isDark
          ? const Color(0xFFFFB0CF)
          : const Color(0xFF4C0929),
      secondary: _cyan,
      onSecondary: _ink,
      secondaryContainer: isDark
          ? const Color(0xFF004D59)
          : const Color(0xFFB4F4F7),
      onSecondaryContainer: isDark
          ? const Color(0xFF8EF5F7)
          : const Color(0xFF00363D),
      tertiary: _gold,
      onTertiary: _ink,
      surface: isDark ? const Color(0xFF110F19) : const Color(0xFFFFF8FC),
      onSurface: isDark ? const Color(0xFFF5ECF4) : const Color(0xFF211923),
      surfaceContainerLowest: isDark ? const Color(0xFF0C0A11) : Colors.white,
      surfaceContainerLow: isDark
          ? const Color(0xFF191520)
          : const Color(0xFFFFF0F7),
      surfaceContainer: isDark
          ? const Color(0xFF201B29)
          : const Color(0xFFFCE7F1),
      surfaceContainerHigh: isDark
          ? const Color(0xFF2A2434)
          : const Color(0xFFF8DDEB),
      surfaceContainerHighest: isDark
          ? const Color(0xFF352E40)
          : const Color(0xFFF2D1E1),
      outline: isDark ? const Color(0xFF9C8997) : const Color(0xFF806875),
      outlineVariant: isDark
          ? const Color(0xFF51434E)
          : const Color(0xFFDCC3CF),
    );
  }

  ThemeData _buildTheme(ColorScheme scheme) {
    return ThemeData(
      useMaterial3: true,
      colorScheme: scheme,
      scaffoldBackgroundColor: scheme.surface,
      appBarTheme: AppBarTheme(
        backgroundColor: scheme.surface,
        foregroundColor: scheme.onSurface,
        surfaceTintColor: Colors.transparent,
        elevation: 0,
        centerTitle: false,
        titleTextStyle: TextStyle(
          color: scheme.onSurface,
          fontSize: 20,
          fontWeight: FontWeight.w800,
          letterSpacing: -0.2,
        ),
      ),
      cardTheme: CardThemeData(
        elevation: 0,
        color: scheme.surfaceContainerLow,
        surfaceTintColor: Colors.transparent,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      ),
      chipTheme: ChipThemeData(
        backgroundColor: scheme.secondaryContainer,
        side: BorderSide.none,
        labelStyle: TextStyle(
          color: scheme.onSecondaryContainer,
          fontWeight: FontWeight.w700,
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
      progressIndicatorTheme: ProgressIndicatorThemeData(
        color: scheme.secondary,
        circularTrackColor: scheme.secondaryContainer,
        linearTrackColor: scheme.surfaceContainerHighest,
      ),
      bottomSheetTheme: BottomSheetThemeData(
        backgroundColor: scheme.surface,
        surfaceTintColor: Colors.transparent,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(top: Radius.circular(28)),
        ),
      ),
      snackBarTheme: SnackBarThemeData(
        behavior: SnackBarBehavior.floating,
        backgroundColor: scheme.inverseSurface,
        contentTextStyle: TextStyle(color: scheme.onInverseSurface),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      ),
    );
  }
}
