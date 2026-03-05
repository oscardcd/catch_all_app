import 'package:flex_color_scheme/flex_color_scheme.dart';
import 'package:flutter/material.dart';
import 'package:catch_all_app/core/core.dart';

class CATheme {
  const CATheme._();

  static const FlexSchemeData _skFlexSchemeData = FlexSchemeData(
    name: 'Catch All App Theme',
    description: 'Catch All App Theme with custom primary and secondary colors',
    light: FlexSchemeColor(
      primary: Palette.primaryLight,
      secondary: Palette.secondaryLight,
    ),
    dark: FlexSchemeColor(
      primary: Palette.primaryDark,
      secondary: Palette.secondaryDark,
    ),
  );

  static final light = FlexThemeData.light(
    colors: _skFlexSchemeData.light,
  ).copyWith(
    scaffoldBackgroundColor: Palette.softBlue,
    splashColor: Colors.transparent,
    cardColor: Palette.pokemonRed.withValues(alpha: 0.5),
    colorScheme: const ColorScheme.light(
      surface: Palette.black,
      onSurface: Palette.white,
      primary: Palette.primaryLight,
      secondary: Palette.secondaryLight,
      primaryContainer: Palette.primaryLight,
      tertiary: Palette.cyan,
    ),
  );

  static final dark = FlexThemeData.dark(
    colors: _skFlexSchemeData.dark,
  ).copyWith(
    scaffoldBackgroundColor: const Color(0xFF0D1117),
    highlightColor: Colors.transparent,
    splashColor: Colors.transparent,
    cardColor: Palette.secondaryDark.withValues(alpha: 0.5),
    textTheme: const TextTheme(
      bodyLarge: TextStyle(color: Palette.black),
    ),
    colorScheme: const ColorScheme.dark(
      surface: Color(0xFF161B22),
      onSurface: Palette.white,
      primary: Palette.primaryDark,
      secondary: Palette.secondaryDark,
      onSecondary: Palette.white,
    ),
    iconTheme: const IconThemeData(color: Palette.white),
  );
}
