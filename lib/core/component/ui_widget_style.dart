import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../res/app_colors.dart';

class UIWidgetStyle {
  static ButtonStyle buttonStyle

      (Color backgroundColor, Size? size, double? radius,
      {Color? foregroundColor}) =>
      ButtonStyle(
          shape: MaterialStateProperty.all(RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(radius ?? 0.0))),
          minimumSize: MaterialStateProperty.all(size ?? const Size(50, 50)),
          foregroundColor: MaterialStateProperty.all(foregroundColor),
          backgroundColor: MaterialStateProperty.all(backgroundColor));

  static ButtonStyle textButtonStyle(Color backgroundColor,
      Color? foregroundColor, Size? size, double? radius) =>
      TextButton.styleFrom(
          foregroundColor: foregroundColor,
          minimumSize: size ?? const Size(50, 50),
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(radius ?? 0.0))),
          backgroundColor: backgroundColor);

  static TextStyle hintTextStyle() {
    return GoogleFonts.poppins(
      textStyle: const TextStyle(
        color: AppColors.greyColor, // Set the color of the hint text
        fontSize: 14,
      ),
    );
  }

}
