import 'package:flutter/material.dart';
import 'package:stream_lab/presentation/core/constants.dart';
import 'package:stream_lab/presentation/core/extensions/color_extension.dart';

class AppTheme {
  static ThemeData light() {
    return ThemeData(
      colorScheme: const ColorScheme.light().copyWith(primary: kPrimaryColor),
      primarySwatch: kPrimaryColor?.toMaterialColor(),
      scaffoldBackgroundColor: kDefaultBackgroundColor,
      appBarTheme: AppBarTheme(
        backgroundColor: Colors.white,
        foregroundColor: kPrimaryColor,
        titleTextStyle: const TextStyle(
          fontSize: 24,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}
