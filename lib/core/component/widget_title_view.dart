import 'package:flutter/material.dart';

import '../../res/app_colors.dart';
import '../package_loader/load_modules.dart';

class WidgetTitleView extends StatelessWidget {
  const WidgetTitleView({
    super.key,
    required this.title,
    this.isRequired = false,
  });

  final String title;
  final bool isRequired;

  @override
  Widget build(BuildContext context) {
    return RichText(
      text: TextSpan(
        text: title,
        style: GoogleFonts.poppins(
          color: AppColors.textColor,
          fontSize: 14,
        ),
        children: [
          if (isRequired)
            const TextSpan(
              text: " *",
              style: TextStyle(
                fontWeight: FontWeight.w400,
                color: AppColors.redColor,
              ),
            ),
        ],
      ),
    );
  }
}
