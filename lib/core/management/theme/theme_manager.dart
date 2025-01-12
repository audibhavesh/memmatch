import 'package:flutter/material.dart';
import 'package:memmatch/core/management/theme/color_schemes.dart';
import 'package:memmatch/core/management/theme/util.dart';

enum AppTheme { Light, Dark }

class ThemeManager {
  static ThemeMode mode = ThemeMode.light;

  static BuildContext? context;
  static final appThemeData = {
    AppTheme.Light:
        MaterialTheme(createTextTheme(context!, "Poppins", "Poppins")).light(),
    AppTheme.Dark:
        MaterialTheme(createTextTheme(context!, "Poppins", "Poppins")).dark()
  };
}
