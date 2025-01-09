import 'package:flutter/material.dart';

class AppColors {
  //Hex Colors
  static const Color primaryColor = Color(0xFF364F9E);
  static const Color headingTextDarkGrey = Color(0xFF3D434A);
  static const Color white = Colors.white;
  static const Color black = Colors.black;
  static const Color blueColor = Color(0xFF293C78);
  static const Color disableGreyColor = Color(0xFFD7D7D7);
  static const Color greyColor = Color(0xFF9EA1A4);
  static const Color redColor = Color(0xFFFF204E);

  static var primaryDark = Color(0xFF203060);

  static Color appBarColor = getColor("#FFFFFF");

  static Color backgroundColorGrey = getColor("#CED0D1");

  static Color textColor = getColor("#6D7277");
  static Color secondaryTextColor = getColor("#9EA1A4");

  static Color primaryTextColor = getColor("#3D434A");

  static Color barBlueColor = getColor("#293C78");
  static Color freezedButtonColor = getColor("#8791ae");

  static Color lightGrayBackground = getColor("#F0F0F0");
  static Color extraLightGrayBackground = getColor("#EDEFF0");
  static Color lightBlueColor = getColor("#C8D0EC");

  static Color secondaryGray = getColor("#D9D9D9");

  static Color lightPinkColor = getColor("#F6D8BB");
  static Color greenColor = getColor("#2BAD3B");

  static int _getColorIntFromHex(String hexColor) {
    hexColor = hexColor.toUpperCase().replaceAll("#", "");
    if (hexColor.length == 6) {
      hexColor = "FF$hexColor";
    }
    return int.parse(hexColor, radix: 16);
  }

  static Color getColor(String colorHex) {
    return Color(_getColorIntFromHex(colorHex));
  }

  static MaterialColor createPrimarySwatch(Color color) {
    // You can adjust the number of shades (from 50 to 900) based on your preference
    Map<int, Color> colorMap = {
      50: color.withOpacity(0.1),
      100: color.withOpacity(0.2),
      200: color.withOpacity(0.3),
      300: color.withOpacity(0.4),
      400: color.withOpacity(0.5),
      500: color.withOpacity(0.6),
      600: color.withOpacity(0.7),
      700: color.withOpacity(0.8),
      800: color.withOpacity(0.9),
      900: color,
    };

    return MaterialColor(color.value, colorMap);
  }
}
