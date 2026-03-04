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
    splashColor: Colors.transparent,
    cardColor: Palette.white,
    colorScheme: const ColorScheme.light(
      surface: Palette.primaryLight,
      onSurface: Palette.gray,
      primary: Palette.primaryLight,
      secondary: Palette.secondaryLight,
      primaryContainer: Palette.primaryLight,
      tertiary: Palette.cyan,
    ),
    // iconTheme: const IconThemeData(color: Palette.white),
  );

  static final dark = FlexThemeData.dark(
    colors: _skFlexSchemeData.dark,
  ).copyWith(
    highlightColor: Colors.transparent,
    splashColor: Colors.transparent,
    cardColor: Palette.white,
    colorScheme: const ColorScheme.dark(
      primary: Palette.primaryDark,
      secondary: Palette.secondaryDark,
      onSecondary: Palette.white,
      onSurface: Palette.onSurface,
    ),
    iconTheme: const IconThemeData(color: Palette.white),
  );
}
