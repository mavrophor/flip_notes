import 'package:flutter/material.dart';

ThemeData getThemeData(Color colorseed, Brightness brightness) {
  return ThemeData.from(
    colorScheme: ColorScheme.fromSeed(
      seedColor: colorseed,
      brightness: brightness,
    ),
  );
}

const kDefaultColorSeed = Colors.blue;

final themeDefault = ThemeData.from(
  colorScheme: ColorScheme.fromSeed(
    seedColor: kDefaultColorSeed,
    brightness: Brightness.light,
  ),
);

final themeDefaultDark = ThemeData.from(
  colorScheme: ColorScheme.fromSeed(
    seedColor: kDefaultColorSeed,
    brightness: Brightness.dark,
  ),
);
