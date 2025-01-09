import 'package:memmatch/core/component/ui_constant.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class RoundedButton extends StatelessWidget {
  final String btnName;
  final Icon? icon;
  final Color? bgColor;
  final Color? fillColor;
  final Color? textColor;
  final TextStyle? textStyle;
  final VoidCallback? callBack;
  final double? width;
  final double? height;
  final TextAlign? textAlign;

  const RoundedButton(
      {super.key, // Added missing 'Key? key'
      required this.btnName,
      this.icon,
      this.bgColor = const Color.fromARGB(255, 5, 54, 132),
      this.fillColor,
      this.textColor,
      this.textStyle,
      this.callBack,
      this.width,
      this.height = 48, // Default height set to 48 if not provided
      this.textAlign}); // Initialize the superclass with the key parameter

  @override
  Widget build(BuildContext context) {
    double calculatedWidth = width ?? UIConstant(context: context).buttonWidth;

    return SizedBox(
      width: calculatedWidth,
      height: height,
      child: ElevatedButton(
        onPressed: callBack,
        style: ElevatedButton.styleFrom(
          backgroundColor: bgColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(5),
          ),
        ),
        child: icon != null
            ? Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  icon!,
                  const SizedBox(width: 8), // for space between icon and text
                  Text(
                    btnName,
                    style: GoogleFonts.lato().merge(
                      textStyle,
                    ),
                  ), // Update textStyle to use GoogleFonts.lato()
                ],
              )
            : Text(
                btnName,
                textAlign: textAlign,
                style: GoogleFonts.lato().merge(
                  textStyle,
                ),
              ), // Update textStyle to use GoogleFonts.lato()
      ),
    );
  }
}
