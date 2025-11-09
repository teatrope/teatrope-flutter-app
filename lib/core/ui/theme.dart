// lib/core/theme.dart
import 'dart:ui';
import 'package:flutter/material.dart';

class MaterialTheme {
  final TextTheme textTheme;
  const MaterialTheme(this.textTheme);

  static const Color brandRed = Color(0xFFEA3E3A); 
  static const Color darkBgTop = Color(0xFF0B0C10);
  static const Color darkBgBottom = Color(0xFF171923);

  static const LinearGradient darkLinearGradient = LinearGradient(
    colors: [darkBgTop, darkBgBottom],
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
  );

  static ColorScheme lightScheme() { 
    return const ColorScheme(
      brightness: Brightness.light,
      primary: Color(0xff8f4c38),
      surfaceTint: Color(0xff8f4c38),
      onPrimary: Color(0xffffffff),
      primaryContainer: Color(0xffffdbd1),
      onPrimaryContainer: Color(0xff723523),
      secondary: Color(0xff8f4c37),
      onSecondary: Color(0xffffffff),
      secondaryContainer: Color(0xffffdbd0),
      onSecondaryContainer: Color(0xff723522),
      tertiary: Color(0xff8f4a4b),
      onTertiary: Color(0xffffffff),
      tertiaryContainer: Color(0xffffdad9),
      onTertiaryContainer: Color(0xff733335),
      error: Color(0xffba1a1a),
      onError: Color(0xffffffff),
      errorContainer: Color(0xffffdad6),
      onErrorContainer: Color(0xff93000a),
      surface: Color(0xfffff8f6),
      onSurface: Color(0xff231917),
      onSurfaceVariant: Color(0xff53433f),
      outline: Color(0xff85736e),
      outlineVariant: Color(0xffd8c2bc),
      shadow: Color(0xff000000),
      scrim: Color(0xff000000),
      inverseSurface: Color(0xff392e2b),
      inversePrimary: Color(0xffffb5a0),
      primaryFixed: Color(0xffffdbd1),
      onPrimaryFixed: Color(0xff3a0b01),
      primaryFixedDim: Color(0xffffb5a0),
      onPrimaryFixedVariant: Color(0xff723523),
      secondaryFixed: Color(0xffffdbd0),
      onSecondaryFixed: Color(0xff3a0b00),
      secondaryFixedDim: Color(0xffffb59f),
      onSecondaryFixedVariant: Color(0xff723522),
      tertiaryFixed: Color(0xffffdad9),
      onTertiaryFixed: Color(0xff3b080d),
      tertiaryFixedDim: Color(0xffffb3b3),
      onTertiaryFixedVariant: Color(0xff733335),
      surfaceDim: Color(0xffe8d6d2),
      surfaceBright: Color(0xfffff8f6),
      surfaceContainerLowest: Color(0xffffffff),
      surfaceContainerLow: Color(0xfffff1ed),
      surfaceContainer: Color(0xfffceae5),
      surfaceContainerHigh: Color(0xfff7e4e0),
      surfaceContainerHighest: Color(0xfff1dfda),
    );
  }
  ThemeData light() => theme(lightScheme());

  static ColorScheme lightMediumContrastScheme() { 
    return const ColorScheme(
      brightness: Brightness.light,
      primary: Color(0xff5d2514),
      surfaceTint: Color(0xff8f4c38),
      onPrimary: Color(0xffffffff),
      primaryContainer: Color(0xffa15a45),
      onPrimaryContainer: Color(0xffffffff),
      secondary: Color(0xff5d2513),
      onSecondary: Color(0xffffffff),
      secondaryContainer: Color(0xffa15a44),
      onSecondaryContainer: Color(0xffffffff),
      tertiary: Color(0xff5e2325),
      onTertiary: Color(0xffffffff),
      tertiaryContainer: Color(0xffa15859),
      onTertiaryContainer: Color(0xffffffff),
      error: Color(0xff740006),
      onError: Color(0xffffffff),
      errorContainer: Color(0xffcf2c27),
      onErrorContainer: Color(0xffffffff),
      surface: Color(0xfffff8f6),
      onSurface: Color(0xff180f0d),
      onSurfaceVariant: Color(0xff41332f),
      outline: Color(0xff5f4f4b),
      outlineVariant: Color(0xff7b6964),
      shadow: Color(0xff000000),
      scrim: Color(0xff000000),
      inverseSurface: Color(0xff392e2b),
      inversePrimary: Color(0xffffb5a0),
      primaryFixed: Color(0xffa15a45),
      onPrimaryFixed: Color(0xffffffff),
      primaryFixedDim: Color(0xff84422f),
      onPrimaryFixedVariant: Color(0xffffffff),
      secondaryFixed: Color(0xffa15a44),
      onSecondaryFixed: Color(0xffffffff),
      secondaryFixedDim: Color(0xff83422e),
      onSecondaryFixedVariant: Color(0xffffffff),
      tertiaryFixed: Color(0xffa15859),
      onTertiaryFixed: Color(0xffffffff),
      tertiaryFixedDim: Color(0xff844042),
      onTertiaryFixedVariant: Color(0xffffffff),
      surfaceDim: Color(0xffd4c3be),
      surfaceBright: Color(0xfffff8f6),
      surfaceContainerLowest: Color(0xffffffff),
      surfaceContainerLow: Color(0xfffff1ed),
      surfaceContainer: Color(0xfff7e4e0),
      surfaceContainerHigh: Color(0xffebd9d4),
      surfaceContainerHighest: Color(0xffdfcec9),
    );
  }
  ThemeData lightMediumContrast() => theme(lightMediumContrastScheme());

  static ColorScheme lightHighContrastScheme() { 
    return const ColorScheme(
      brightness: Brightness.light,
      primary: Color(0xff501b0b),
      surfaceTint: Color(0xff8f4c38),
      onPrimary: Color(0xffffffff),
      primaryContainer: Color(0xff753725),
      onPrimaryContainer: Color(0xffffffff),
      secondary: Color(0xff501b0a),
      onSecondary: Color(0xffffffff),
      secondaryContainer: Color(0xff753724),
      onSecondaryContainer: Color(0xffffffff),
      tertiary: Color(0xff51191c),
      onTertiary: Color(0xffffffff),
      tertiaryContainer: Color(0xff763537),
      onTertiaryContainer: Color(0xffffffff),
      error: Color(0xff600004),
      onError: Color(0xffffffff),
      errorContainer: Color(0xff98000a),
      onErrorContainer: Color(0xffffffff),
      surface: Color(0xfffff8f6),
      onSurface: Color(0xff000000),
      onSurfaceVariant: Color(0xff000000),
      outline: Color(0xff372925),
      outlineVariant: Color(0xff554641),
      shadow: Color(0xff000000),
      scrim: Color(0xff000000),
      inverseSurface: Color(0xff392e2b),
      inversePrimary: Color(0xffffb5a0),
      primaryFixed: Color(0xff753725),
      onPrimaryFixed: Color(0xffffffff),
      primaryFixedDim: Color(0xff592111),
      onPrimaryFixedVariant: Color(0xffffffff),
      secondaryFixed: Color(0xff753724),
      onSecondaryFixed: Color(0xffffffff),
      secondaryFixedDim: Color(0xff592210),
      onSecondaryFixedVariant: Color(0xffffffff),
      tertiaryFixed: Color(0xff763537),
      onTertiaryFixed: Color(0xffffffff),
      tertiaryFixedDim: Color(0xff591f22),
      onTertiaryFixedVariant: Color(0xffffffff),
      surfaceDim: Color(0xffc6b5b1),
      surfaceBright: Color(0xfffff8f6),
      surfaceContainerLowest: Color(0xffffffff),
      surfaceContainerLow: Color(0xffffede8),
      surfaceContainer: Color(0xfff1dfda),
      surfaceContainerHigh: Color(0xffe2d1cc),
      surfaceContainerHighest: Color(0xffd4c3be),
    );
  }
  ThemeData lightHighContrast() => theme(lightHighContrastScheme());

  static ColorScheme darkScheme() { 
    return const ColorScheme(
      brightness: Brightness.dark,
      primary: Color(0xffffb5a0),
      surfaceTint: Color(0xffffb5a0),
      onPrimary: Color(0xff561f0f),
      primaryContainer: Color(0xff723523),
      onPrimaryContainer: Color(0xffffdbd1),
      secondary: Color(0xffffb59f),
      onSecondary: Color(0xff561f0e),
      secondaryContainer: Color(0xff723522),
      onSecondaryContainer: Color(0xffffdbd0),
      tertiary: Color(0xffffb3b3),
      onTertiary: Color(0xff561d20),
      tertiaryContainer: Color(0xff733335),
      onTertiaryContainer: Color(0xffffdad9),
      error: Color(0xffffb4ab),
      onError: Color(0xff690005),
      errorContainer: Color(0xff93000a),
      onErrorContainer: Color(0xffffdad6),
      surface: Color(0xff1a110f),
      onSurface: Color(0xfff1dfda),
      onSurfaceVariant: Color(0xffd8c2bc),
      outline: Color(0xffa08c87),
      outlineVariant: Color(0xff53433f),
      shadow: Color(0xff000000),
      scrim: Color(0xff000000),
      inverseSurface: Color(0xfff1dfda),
      inversePrimary: Color(0xff8f4c38),
      primaryFixed: Color(0xffffdbd1),
      onPrimaryFixed: Color(0xff3a0b01),
      primaryFixedDim: Color(0xffffb5a0),
      onPrimaryFixedVariant: Color(0xff723523),
      secondaryFixed: Color(0xffffdbd0),
      onSecondaryFixed: Color(0xff3a0b00),
      secondaryFixedDim: Color(0xffffb59f),
      onSecondaryFixedVariant: Color(0xff723522),
      tertiaryFixed: Color(0xffffdad9),
      onTertiaryFixed: Color(0xff3b080d),
      tertiaryFixedDim: Color(0xffffb3b3),
      onTertiaryFixedVariant: Color(0xff733335),
      surfaceDim: Color(0xff1a110f),
      surfaceBright: Color(0xff423734),
      surfaceContainerLowest: Color(0xff140c0a),
      surfaceContainerLow: Color(0xff231917),
      surfaceContainer: Color(0xff271d1b),
      surfaceContainerHigh: Color(0xff322825),
      surfaceContainerHighest: Color(0xff3d322f),
    );
  }
  ThemeData dark() => theme(darkScheme());

  static ColorScheme darkMediumContrastScheme() { 
    return const ColorScheme(
      brightness: Brightness.dark,
      primary: Color(0xffffd2c6),
      surfaceTint: Color(0xffffb5a0),
      onPrimary: Color(0xff481506),
      primaryContainer: Color(0xffcb7c65),
      onPrimaryContainer: Color(0xff000000),
      secondary: Color(0xffffd3c6),
      onSecondary: Color(0xff471505),
      secondaryContainer: Color(0xffcb7c64),
      onSecondaryContainer: Color(0xff000000),
      tertiary: Color(0xffffd1d1),
      onTertiary: Color(0xff481216),
      tertiaryContainer: Color(0xffcb7a7b),
      onTertiaryContainer: Color(0xff000000),
      error: Color(0xffffd2cc),
      onError: Color(0xff540003),
      errorContainer: Color(0xffff5449),
      onErrorContainer: Color(0xff000000),
      surface: Color(0xff1a110f),
      onSurface: Color(0xffffffff),
      onSurfaceVariant: Color(0xffeed7d1),
      outline: Color(0xffc2ada8),
      outlineVariant: Color(0xffa08c87),
      shadow: Color(0xff000000),
      scrim: Color(0xff000000),
      inverseSurface: Color(0xfff1dfda),
      inversePrimary: Color(0xff743624),
      primaryFixed: Color(0xffffdbd1),
      onPrimaryFixed: Color(0xff280500),
      primaryFixedDim: Color(0xffffb5a0),
      onPrimaryFixedVariant: Color(0xff5d2514),
      secondaryFixed: Color(0xffffdbd0),
      onSecondaryFixed: Color(0xff280500),
      secondaryFixedDim: Color(0xffffb59f),
      onSecondaryFixedVariant: Color(0xff5d2513),
      tertiaryFixed: Color(0xffffdad9),
      onTertiaryFixed: Color(0xff2c0105),
      tertiaryFixedDim: Color(0xffffb3b3),
      onTertiaryFixedVariant: Color(0xff5e2325),
      surfaceDim: Color(0xff1a110f),
      surfaceBright: Color(0xff4e423f),
      surfaceContainerLowest: Color(0xff0d0604),
      surfaceContainerLow: Color(0xff251b19),
      surfaceContainer: Color(0xff302623),
      surfaceContainerHigh: Color(0xff3b302d),
      surfaceContainerHighest: Color(0xff463b38),
    );
  }
  ThemeData darkMediumContrast() => theme(darkMediumContrastScheme());

  static ColorScheme darkHighContrastScheme() { 
    return const ColorScheme(
      brightness: Brightness.dark,
      primary: Color(0xffffece7),
      surfaceTint: Color(0xffffb5a0),
      onPrimary: Color(0xff000000),
      primaryContainer: Color(0xffffaf98),
      onPrimaryContainer: Color(0xff1e0300),
      secondary: Color(0xffffece7),
      onSecondary: Color(0xff000000),
      secondaryContainer: Color(0xffffaf97),
      onSecondaryContainer: Color(0xff1e0300),
      tertiary: Color(0xffffeceb),
      onTertiary: Color(0xff000000),
      tertiaryContainer: Color(0xffffadad),
      onTertiaryContainer: Color(0xff220003),
      error: Color(0xffffece9),
      onError: Color(0xff000000),
      errorContainer: Color(0xffffaea4),
      onErrorContainer: Color(0xff220001),
      surface: Color(0xff1a110f),
      onSurface: Color(0xffffffff),
      onSurfaceVariant: Color(0xffffffff),
      outline: Color(0xffffece7),
      outlineVariant: Color(0xffd4beb8),
      shadow: Color(0xff000000),
      scrim: Color(0xff000000),
      inverseSurface: Color(0xfff1dfda),
      inversePrimary: Color(0xff743624),
      primaryFixed: Color(0xffffdbd1),
      onPrimaryFixed: Color(0xff000000),
      primaryFixedDim: Color(0xffffb5a0),
      onPrimaryFixedVariant: Color(0xff280500),
      secondaryFixed: Color(0xffffdbd0),
      onSecondaryFixed: Color(0xff000000),
      secondaryFixedDim: Color(0xffffb59f),
      onSecondaryFixedVariant: Color(0xff280500),
      tertiaryFixed: Color(0xffffdad9),
      onTertiaryFixed: Color(0xff000000),
      tertiaryFixedDim: Color(0xffffb3b3),
      onTertiaryFixedVariant: Color(0xff2c0105),
      surfaceDim: Color(0xff1a110f),
      surfaceBright: Color(0xff5a4d4a),
      surfaceContainerLowest: Color(0xff000000),
      surfaceContainerLow: Color(0xff271d1b),
      surfaceContainer: Color(0xff392e2b),
      surfaceContainerHigh: Color(0xff443936),
      surfaceContainerHighest: Color(0xff504441),
    );
  }
  ThemeData darkHighContrast() => theme(darkHighContrastScheme());

  ThemeData theme(ColorScheme scheme) {
    final base = ThemeData(
      useMaterial3: true,
      brightness: scheme.brightness,
      colorScheme: scheme,
      textTheme: textTheme.apply(
        bodyColor: scheme.onSurface,
        displayColor: scheme.onSurface,
      ),
      scaffoldBackgroundColor: Colors.transparent,
      canvasColor: scheme.surface,
    );

    return base.copyWith(
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: Colors.white.withOpacity(0.08),
        hintStyle: const TextStyle(color: Colors.white70),
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: BorderSide(color: Colors.white.withOpacity(0.25)),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: BorderSide(color: Colors.white.withOpacity(0.25)),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: const BorderSide(color: Colors.white70, width: 1.2),
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

class DarkBlurBackground extends StatelessWidget {
  final Widget child;
  const DarkBlurBackground({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: const BoxDecoration(gradient: MaterialTheme.darkLinearGradient),
      child: Stack(
        children: [
          Positioned(
            left: -80,
            top: -60,
            child: _BlurSpot(radius: 220, opacity: 0.22),
          ),
          Positioned(
            right: -60,
            top: 200,
            child: _BlurSpot(radius: 180, opacity: 0.18),
          ),
          Positioned(
            left: -40,
            bottom: -40,
            child: _BlurSpot(radius: 200, opacity: 0.16),
          ),
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
            colors: [
              Colors.white.withOpacity(opacity),
              Colors.transparent,
            ],
          ),
        ),
      ),
    );
  }
}

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
