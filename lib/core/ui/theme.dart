// lib/core/theme.dart
import 'dart:ui';
import 'package:flutter/material.dart';

class MaterialTheme {
  final TextTheme textTheme;
  const MaterialTheme(this.textTheme);

  // Acento ROJO del mock
  static const Color brandRed = Color(0xFFEA3E3A);

  // Fondo NEGRO degradado
  static const Color darkBgTop = Color(0xFF0B0C10);
  static const Color darkBgBottom = Color(0xFF171923);

  static const LinearGradient darkLinearGradient = LinearGradient(
    colors: [darkBgTop, darkBgBottom],
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
  );

  // ===================== LIGHT (lo dejamos disponible) =====================
  static ColorScheme lightScheme() {
    return const ColorScheme(
      brightness: Brightness.light,
      primary: brandRed,
      surfaceTint: brandRed,
      onPrimary: Color(0xFFFFFFFF),
      primaryContainer: Color(0xFFFFD6D3),
      onPrimaryContainer: Color(0xFF5F1614),
      secondary: Color(0xFF6A6F79),
      onSecondary: Color(0xFFFFFFFF),
      secondaryContainer: Color(0xFFE3E6EC),
      onSecondaryContainer: Color(0xFF2F333A),
      tertiary: Color(0xFF8A6A6D),
      onTertiary: Color(0xFFFFFFFF),
      tertiaryContainer: Color(0xFFF6DADB),
      onTertiaryContainer: Color(0xFF4A2E31),
      error: Color(0xFFBA1A1A),
      onError: Color(0xFFFFFFFF),
      errorContainer: Color(0xFFFFDAD6),
      onErrorContainer: Color(0xFF93000A),
      surface: Color(0xFFFAFAFA),
      onSurface: Color(0xFF191C20),
      onSurfaceVariant: Color(0xFF474A50),
      outline: Color(0xFF7A7D84),
      outlineVariant: Color(0xFFC6C8CF),
      shadow: Color(0xFF000000),
      scrim: Color(0xFF000000),
      inverseSurface: Color(0xFF2E3036),
      inversePrimary: Color(0xFFFFA39E),
      primaryFixed: Color(0xFFFFD6D3),
      onPrimaryFixed: Color(0xFF3A0B0A),
      primaryFixedDim: Color(0xFFFFA39E),
      onPrimaryFixedVariant: Color(0xFF5F1614),
      secondaryFixed: Color(0xFFE3E6EC),
      onSecondaryFixed: Color(0xFF12161B),
      secondaryFixedDim: Color(0xFFC7CBD2),
      onSecondaryFixedVariant: Color(0xFF2F333A),
      tertiaryFixed: Color(0xFFF6DADB),
      onTertiaryFixed: Color(0xFF220E10),
      tertiaryFixedDim: Color(0xFFDABEC0),
      onTertiaryFixedVariant: Color(0xFF4A2E31),
      surfaceDim: Color(0xFFE2E3E6),
      surfaceBright: Color(0xFFFFFFFF),
      surfaceContainerLowest: Color(0xFFFFFFFF),
      surfaceContainerLow: Color(0xFFF3F3F6),
      surfaceContainer: Color(0xFFEEEEF1),
      surfaceContainerHigh: Color.fromARGB(255, 43, 43, 56),
      surfaceContainerHighest: Color(0xFFE2E3E6),
    );
  }
  ThemeData light() => theme(lightScheme());

  static ColorScheme lightMediumContrastScheme() {
    return const ColorScheme(
      brightness: Brightness.light,
      primary: Color(0xFFC7312B),
      surfaceTint: brandRed,
      onPrimary: Color(0xFFFFFFFF),
      primaryContainer: Color(0xFFF06A65),
      onPrimaryContainer: Color(0xFFFFFFFF),
      secondary: Color(0xFF3A3F49),
      onSecondary: Color(0xFFFFFFFF),
      secondaryContainer: Color(0xFF787E89),
      onSecondaryContainer: Color(0xFFFFFFFF),
      tertiary: Color(0xFF5B3D40),
      onTertiary: Color(0xFFFFFFFF),
      tertiaryContainer: Color(0xFF9A7A7D),
      onTertiaryContainer: Color(0xFFFFFFFF),
      error: Color(0xFF740006),
      onError: Color(0xFFFFFFFF),
      errorContainer: Color(0xFFCF2C27),
      onErrorContainer: Color(0xFFFFFFFF),
      surface: Color(0xFFFFFFFF),
      onSurface: Color(0xFF101215),
      onSurfaceVariant: Color(0xFF34373D),
      outline: Color(0xFF50535A),
      outlineVariant: Color(0xFF6C6F76),
      shadow: Color(0xFF000000),
      scrim: Color(0xFF000000),
      inverseSurface: Color(0xFF2E3036),
      inversePrimary: Color(0xFFFFA39E),
      primaryFixed: Color(0xFFF06A65),
      onPrimaryFixed: Color(0xFFFFFFFF),
      primaryFixedDim: Color(0xFFD84E49),
      onPrimaryFixedVariant: Color(0xFFFFFFFF),
      secondaryFixed: Color(0xFF787E89),
      onSecondaryFixed: Color(0xFFFFFFFF),
      secondaryFixedDim: Color(0xFF60656F),
      onSecondaryFixedVariant: Color(0xFFFFFFFF),
      tertiaryFixed: Color(0xFF9A7A7D),
      onTertiaryFixed: Color(0xFFFFFFFF),
      tertiaryFixedDim: Color(0xFF7E6063),
      onTertiaryFixedVariant: Color(0xFFFFFFFF),
      surfaceDim: Color(0xFFD0D1D5),
      surfaceBright: Color(0xFFFFFFFF),
      surfaceContainerLowest: Color(0xFFFFFFFF),
      surfaceContainerLow: Color(0xFFF4F4F7),
      surfaceContainer: Color(0xFFE9EAED),
      surfaceContainerHigh: Color(0xFFDEDFE2),
      surfaceContainerHighest: Color(0xFFD3D4D8),
    );
  }
  ThemeData lightMediumContrast() => theme(lightMediumContrastScheme());

  static ColorScheme lightHighContrastScheme() {
    return const ColorScheme(
      brightness: Brightness.light,
      primary: Color(0xFFB71C17),
      surfaceTint: brandRed,
      onPrimary: Color(0xFFFFFFFF),
      primaryContainer: Color(0xFFD13E38),
      onPrimaryContainer: Color(0xFFFFFFFF),
      secondary: Color(0xFF2E333B),
      onSecondary: Color(0xFFFFFFFF),
      secondaryContainer: Color(0xFF505660),
      onSecondaryContainer: Color(0xFFFFFFFF),
      tertiary: Color(0xFF4B2E31),
      onTertiary: Color(0xFFFFFFFF),
      tertiaryContainer: Color(0xFF6C4D50),
      onTertiaryContainer: Color(0xFFFFFFFF),
      error: Color(0xFF600004),
      onError: Color(0xFFFFFFFF),
      errorContainer: Color(0xFF98000A),
      onErrorContainer: Color(0xFFFFFFFF),
      surface: Color(0xFFFFFFFF),
      onSurface: Color(0xFF000000),
      onSurfaceVariant: Color(0xFF000000),
      outline: Color(0xFF2B2E34),
      outlineVariant: Color(0xFF4A4D53),
      shadow: Color(0xFF000000),
      scrim: Color(0xFF000000),
      inverseSurface: Color(0xFF2E3036),
      inversePrimary: Color(0xFFFF938D),
      primaryFixed: Color(0xFFD13E38),
      onPrimaryFixed: Color(0xFFFFFFFF),
      primaryFixedDim: Color(0xFFB42822),
      onPrimaryFixedVariant: Color(0xFFFFFFFF),
      secondaryFixed: Color(0xFF505660),
      onSecondaryFixed: Color(0xFFFFFFFF),
      secondaryFixedDim: Color(0xFF3A3F49),
      onSecondaryFixedVariant: Color(0xFFFFFFFF),
      tertiaryFixed: Color(0xFF6C4D50),
      onTertiaryFixed: Color(0xFFFFFFFF),
      tertiaryFixedDim: Color(0xFF53383B),
      onTertiaryFixedVariant: Color(0xFFFFFFFF),
      surfaceDim: Color(0xFFC4C5C9),
      surfaceBright: Color(0xFFFFFFFF),
      surfaceContainerLowest: Color(0xFFFFFFFF),
      surfaceContainerLow: Color(0xFFF0F0F3),
      surfaceContainer: Color(0xFFE2E3E6),
      surfaceContainerHigh: Color(0xFFD4D5D9),
      surfaceContainerHighest: Color(0xFFC6C7CB),
    );
  }
  ThemeData lightHighContrast() => theme(lightHighContrastScheme());

  // ===================== DARK (HOME: negro + rojo) =====================
  static ColorScheme darkScheme() {
    return const ColorScheme(
      brightness: Brightness.dark,
      primary: brandRed,                 // ROJO como acento principal
      surfaceTint: brandRed,
      onPrimary: Color(0xFFFFFFFF),
      primaryContainer: Color(0xFF4A1C1B), // rojo muy oscuro p/containers
      onPrimaryContainer: Color(0xFFFFE7E6),

      secondary: Color(0xFFB9BDC7),      // gris para controles
      onSecondary: Color(0xFF262A31),
      secondaryContainer: Color(0xFF343A43),
      onSecondaryContainer: Color(0xFFDCE0E8),

      tertiary: Color(0xFFD7B3B6),       // rojo pálido (chips/badges)
      onTertiary: Color(0xFF3A1F22),
      tertiaryContainer: Color(0xFF593439),
      onTertiaryContainer: Color(0xFFFFE3E6),

      error: Color(0xFFFFB4AB),
      onError: Color(0xFF690005),
      errorContainer: Color(0xFF93000A),
      onErrorContainer: Color(0xFFFFDAD6),

      surface: Color(0xFF111318),        // base negro
      onSurface: Color(0xFFEDEDF1),      // textos blancos/gris claro
      onSurfaceVariant: Color(0xFFC4C6D0),
      outline: Color(0xFF8E9099),
      outlineVariant: Color(0xFF44474E),
      shadow: Color(0xFF000000),
      scrim: Color(0xFF000000),

      inverseSurface: Color(0xFFE2E2E9),
      inversePrimary: brandRed,

      primaryFixed: Color(0xFFFFC2BD),
      onPrimaryFixed: Color(0xFF2E0908),
      primaryFixedDim: Color(0xFFFF9A94),
      onPrimaryFixedVariant: Color(0xFFFFE7E6),

      secondaryFixed: Color(0xFFD3D7E0),
      onSecondaryFixed: Color(0xFF13171C),
      secondaryFixedDim: Color(0xFFBEC3CC),
      onSecondaryFixedVariant: Color(0xFFDCE0E8),

      tertiaryFixed: Color(0xFFF2D4D7),
      onTertiaryFixed: Color(0xFF1F0D10),
      tertiaryFixedDim: Color(0xFFDBBBC0),
      onTertiaryFixedVariant: Color(0xFFFFE3E6),

      surfaceDim: Color(0xFF0F1014),
      surfaceBright: Color(0xFF2F3136),
      surfaceContainerLowest: Color(0xFF0B0C10),
      surfaceContainerLow: Color(0xFF191C20),
      surfaceContainer: Color(0xFF1D2024),
      surfaceContainerHigh: Color(0xFF282B30),
      surfaceContainerHighest: Color(0xFF33363B),
    );
  }
  ThemeData dark() => theme(darkScheme());

  static ColorScheme darkMediumContrastScheme() {
    return const ColorScheme(
      brightness: Brightness.dark,
      primary: Color(0xFFFFC2BD),
      surfaceTint: brandRed,
      onPrimary: Color(0xFF2A0706),
      primaryContainer: Color(0xFFB0514C),
      onPrimaryContainer: Color(0xFF000000),
      secondary: Color(0xFFD9DCE4),
      onSecondary: Color(0xFF10141A),
      secondaryContainer: Color(0xFF8C919B),
      onSecondaryContainer: Color(0xFF000000),
      tertiary: Color(0xFFF0D0D3),
      onTertiary: Color(0xFF1B0A0D),
      tertiaryContainer: Color(0xFFB3868B),
      onTertiaryContainer: Color(0xFF000000),
      error: Color(0xFFFFD2CC),
      onError: Color(0xFF540003),
      errorContainer: Color(0xFFFF5449),
      onErrorContainer: Color(0xFF000000),
      surface: Color(0xFF111318),
      onSurface: Color(0xFFFFFFFF),
      onSurfaceVariant: Color(0xFFE0E2EA),
      outline: Color(0xFFB1B4BD),
      outlineVariant: Color(0xFF8E9099),
      shadow: Color(0xFF000000),
      scrim: Color(0xFF000000),
      inverseSurface: Color(0xFFE2E2E9),
      inversePrimary: brandRed,
      primaryFixed: Color(0xFFFFC2BD),
      onPrimaryFixed: Color(0xFF1E0403),
      primaryFixedDim: Color(0xFFFF9A94),
      onPrimaryFixedVariant: Color(0xFF4A1C1B),
      secondaryFixed: Color(0xFFD9DCE4),
      onSecondaryFixed: Color(0xFF080C11),
      secondaryFixedDim: Color(0xFFBEC3CC),
      onSecondaryFixedVariant: Color(0xFF2E333B),
      tertiaryFixed: Color(0xFFF0D0D3),
      onTertiaryFixed: Color(0xFF130709),
      tertiaryFixedDim: Color(0xFFDBBBC0),
      onTertiaryFixedVariant: Color(0xFF4F2D31),
      surfaceDim: Color(0xFF111318),
      surfaceBright: Color(0xFF3B3E44),
      surfaceContainerLowest: Color(0xFF06070B),
      surfaceContainerLow: Color(0xFF1A1D22),
      surfaceContainer: Color(0xFF25282D),
      surfaceContainerHigh: Color(0xFF2F3338),
      surfaceContainerHighest: Color(0xFF3A3E43),
    );
  }
  ThemeData darkMediumContrast() => theme(darkMediumContrastScheme());

  static ColorScheme darkHighContrastScheme() {
    return const ColorScheme(
      brightness: Brightness.dark,
      primary: Color(0xFFFFECEB),
      surfaceTint: brandRed,
      onPrimary: Color(0xFF000000),
      primaryContainer: Color(0xFFFFB6B1),
      onPrimaryContainer: Color(0xFF160202),
      secondary: Color(0xFFF0F2F6),
      onSecondary: Color(0xFF000000),
      secondaryContainer: Color(0xFFC8CDD6),
      onSecondaryContainer: Color(0xFF05080D),
      tertiary: Color(0xFFFFEAEC),
      onTertiary: Color(0xFF000000),
      tertiaryContainer: Color(0xFFE2C3C7),
      onTertiaryContainer: Color(0xFF0F0406),
      error: Color(0xFFFFECE9),
      onError: Color(0xFF000000),
      errorContainer: Color(0xFFFFAEA4),
      onErrorContainer: Color(0xFF220001),
      surface: Color(0xFF111318),
      onSurface: Color(0xFFFFFFFF),
      onSurfaceVariant: Color(0xFFFFFFFF),
      outline: Color(0xFFFFECEB),
      outlineVariant: Color(0xFFCFCFD5),
      shadow: Color(0xFF000000),
      scrim: Color(0xFF000000),
      inverseSurface: Color(0xFFE2E2E9),
      inversePrimary: brandRed,
      primaryFixed: Color(0xFFFFCFCB),
      onPrimaryFixed: Color(0xFF000000),
      primaryFixedDim: Color(0xFFFFA39E),
      onPrimaryFixedVariant: Color(0xFF1E0403),
      secondaryFixed: Color(0xFFDFE3EA),
      onSecondaryFixed: Color(0xFF000000),
      secondaryFixedDim: Color(0xFFC7CBD2),
      onSecondaryFixedVariant: Color(0xFF0D1116),
      tertiaryFixed: Color(0xFFF6DBDE),
      onTertiaryFixed: Color(0xFF000000),
      tertiaryFixedDim: Color(0xFFDABEC0),
      onTertiaryFixedVariant: Color(0xFF130709),
      surfaceDim: Color(0xFF111318),
      surfaceBright: Color(0xFF4A4D52),
      surfaceContainerLowest: Color(0xFF000000),
      surfaceContainerLow: Color(0xFF1D2024),
      surfaceContainer: Color(0xFF2E3136),
      surfaceContainerHigh: Color(0xFF393C41),
      surfaceContainerHighest: Color(0xFF45484D),
    );
  }
  ThemeData darkHighContrast() => theme(darkHighContrastScheme());

  // ===================== THEME (misma estructura) =====================
  ThemeData theme(ColorScheme scheme) {
    final base = ThemeData(
      useMaterial3: true,
      brightness: scheme.brightness,
      colorScheme: scheme,
      textTheme: textTheme.apply(
        bodyColor: scheme.onSurface,
        displayColor: scheme.onSurface,
      ),
      scaffoldBackgroundColor: Colors.transparent, // muestra el degradado
      canvasColor: scheme.surface,
    );

    return base.copyWith(
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        // (solo cambio de color — sin tocar estructura)
        fillColor: scheme.surfaceContainerHigh.withOpacity(0.6),
        hintStyle: TextStyle(color: scheme.onSurfaceVariant),
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: BorderSide(color: scheme.outlineVariant.withOpacity(0.25)),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: BorderSide(color: scheme.outlineVariant.withOpacity(0.25)),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: const BorderRadius.all(Radius.circular(16)),
          borderSide: BorderSide(color: scheme.onSurfaceVariant, width: 1.2),
        ),
      ),
      filledButtonTheme: FilledButtonThemeData(
        style: FilledButton.styleFrom(
          backgroundColor: brandRed,
          foregroundColor: Colors.white,
          shape: const StadiumBorder(),
          textStyle: const TextStyle(fontWeight: FontWeight.w600),
          minimumSize: const Size(double.infinity, 52),
        ),
      ),
      textButtonTheme: TextButtonThemeData(
        style: TextButton.styleFrom(
          foregroundColor: Colors.white70,
        ),
      ),
    );
  }

  List<ExtendedColor> get extendedColors => [];
}

// Fondo con degradado/blur (misma estructura)
class DarkBlurBackground extends StatelessWidget {
  final Widget child;
  const DarkBlurBackground({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: const BoxDecoration(gradient: MaterialTheme.darkLinearGradient),
      child: Stack(
        children: [
          const Positioned(left: -80, top: -60, child: _BlurSpot(radius: 220, opacity: 0.22)),
          const Positioned(right: -60, top: 200, child: _BlurSpot(radius: 180, opacity: 0.18)),
          const Positioned(left: -40, bottom: -40, child: _BlurSpot(radius: 200, opacity: 0.16)),
          child,
        ],
      ),
    );
  }
}

class _BlurSpot extends StatelessWidget {
  final double radius;
  final double opacity;
  const _BlurSpot({required this.radius, required this.opacity});

  @override
  Widget build(BuildContext context) {
    return ImageFiltered(
      imageFilter: ImageFilter.blur(sigmaX: 80, sigmaY: 80),
      child: Container(
        width: radius,
        height: radius,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          gradient: RadialGradient(
            colors: [Colors.white.withOpacity(opacity), Colors.transparent],
          ),
        ),
      ),
    );
  }
}

// Clases auxiliares (sin cambios)
class ExtendedColor {
  final Color seed, value;
  final ColorFamily light;
  final ColorFamily lightHighContrast;
  final ColorFamily lightMediumContrast;
  final ColorFamily dark;
  final ColorFamily darkHighContrast;
  final ColorFamily darkMediumContrast;

  const ExtendedColor({
    required this.seed,
    required this.value,
    required this.light,
    required this.lightHighContrast,
    required this.lightMediumContrast,
    required this.dark,
    required this.darkHighContrast,
    required this.darkMediumContrast,
  });
}

class ColorFamily {
  const ColorFamily({
    required this.color,
    required this.onColor,
    required this.colorContainer,
    required this.onColorContainer,
  });

  final Color color;
  final Color onColor;
  final Color colorContainer;
  final Color onColorContainer;
}
