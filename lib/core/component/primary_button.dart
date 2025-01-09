import 'package:memmatch/core/package_loader/load_modules.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart'; // Import Google Fonts package

class PrimaryButton extends StatelessWidget {
  const PrimaryButton({
    super.key,
    required this.title,
    required this.onPressed,
    this.isLoading,
    this.icon,
  });

  final String title;
  final VoidCallback onPressed;
  final bool? isLoading;
  final Icon? icon;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton.icon(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        textStyle: const TextStyle(
          color: Colors.white,
          fontFamily: 'Lato',
        ),
        backgroundColor: AppColors.primaryDark,
        minimumSize: Size(MediaQuery.of(context).size.width, 44),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
      ),
      icon: isLoading == true
          ? const CircularProgressIndicator(
              color: AppColors.white,
            )
          : (icon ?? const SizedBox.shrink()),
      label: Text(
        title,
        style: GoogleFonts.lato(
          textStyle: const TextStyle(
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}
