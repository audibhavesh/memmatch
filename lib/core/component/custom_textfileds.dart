import 'package:memmatch/core/component/ui_constant.dart';
import 'package:memmatch/core/component/ui_widget_style.dart';
import 'package:memmatch/core/component/widget_title_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../res/app_colors.dart';
import 'error_text_view.dart';

class CustomTextField extends StatelessWidget {
  final TextEditingController controller;
  final TextInputType? keyboardType;
  final bool? isObscureText;
  final String? obscureCharacter;
  final String hintText;
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final double? width;
  final List<TextInputFormatter>? inputFormatters;
  final String? errorText;
  final int? maxLength;
  final double? height;
  final String labelText;
  final bool isRequired;
  final Function(String value)? onFieldSubmitted;
  final bool readOnly;
  final void Function()? onTap;
  final Function(String)? onChange;
  final String? Function(String?)? validator; // Add this line

  const CustomTextField({
    super.key,
    required this.controller,
    this.keyboardType = TextInputType.text,
    this.isObscureText = false,
    this.isRequired = false,
    this.obscureCharacter = '*',
    required this.hintText,
    this.prefixIcon,
    this.suffixIcon,
    this.width,
    this.inputFormatters,
    this.errorText,
    this.maxLength,
    this.height,
    required this.labelText,
    this.onFieldSubmitted,
    this.readOnly = false,
    this.onTap,
    this.onChange,
    this.validator,
  });

  @override
  Widget build(BuildContext context) {
    double calculatedWidth = width ?? UIConstant(context: context).buttonWidth;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (labelText.isNotEmpty)
          WidgetTitleView(
            title: labelText,
            isRequired: isRequired,
          ),
        if (labelText.isNotEmpty) const SizedBox(height: 8),
        Container(
          height: height,
          width: width == 0 ? null : calculatedWidth, // 0 means null
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(5),
            border: Border.all(color: AppColors.secondaryTextColor, width: 1),
            color: !readOnly ? Colors.white : AppColors.disableGreyColor,
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: TextFormField(
              readOnly: readOnly,
              controller: controller,
              keyboardType: keyboardType,
              obscureText: isObscureText ?? false,
              obscuringCharacter: obscureCharacter ?? '*',
              style: const TextStyle(
                color: Colors.black,
                fontSize: 14,
              ),
              decoration: InputDecoration(
                hintText: hintText,
                hintStyle: UIWidgetStyle.hintTextStyle(),
                prefixIcon: prefixIcon,
                suffixIcon: suffixIcon,
                border: InputBorder.none,
                isDense: true,
                contentPadding: const EdgeInsets.symmetric(vertical: 15),
                // Adjusts vertical padding to center hint text
                counterText: '',
              ),
              maxLength: maxLength,
              textAlignVertical: TextAlignVertical.center,
              inputFormatters: inputFormatters,
              onFieldSubmitted: (value) => onFieldSubmitted?.call(value),
              onTap: onTap,
              onChanged: onChange,
              validator: validator, // Add this line
            ),
          ),
        ),
        ErrorTextView(
          errorText: errorText,
        )
      ],
    );
  }
}

class CustomTextFieldUpdateProdect extends StatelessWidget {
  final TextEditingController controller;
  final TextInputType? keyboardType;
  final bool? isObscureText;
  final String? obscureCharacter;
  final String hintText;
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final double? width;
  final List<TextInputFormatter>? inputFormatters;
  final String? errorText;
  final int? maxLength;
  final double? height;
  final String labelText;
  final bool isRequired;
  final Function(String value)? onFieldSubmitted;
  final bool readOnly;
  final void Function()? onTap;
  final Function(String)? onChange;
  final String? Function(String?)? validator; // Add this line

  const CustomTextFieldUpdateProdect({
    super.key,
    required this.controller,
    this.keyboardType = TextInputType.text,
    this.isObscureText = false,
    this.isRequired = false,
    this.obscureCharacter = '*',
    required this.hintText,
    this.prefixIcon,
    this.suffixIcon,
    this.width,
    this.inputFormatters,
    this.errorText,
    this.maxLength,
    this.height,
    required this.labelText,
    this.onFieldSubmitted,
    this.readOnly = false,
    this.onTap,
    this.onChange,
    this.validator, // Add this line
  });

  @override
  Widget build(BuildContext context) {
    double calculatedWidth = width ?? UIConstant(context: context).buttonWidth;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (labelText.isNotEmpty)
          //   WidgetTitleView(
          //     title: labelText,
          //     isRequired: isRequired,
          //   ),
          // if (labelText.isNotEmpty) const SizedBox(height: 8),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Text(labelText,
                      style: GoogleFonts.poppins(
                        color: AppColors.textColor,
                        fontSize: 14,
                      )
                      // Add this line
                      ),
                  const Text(
                    "*",
                    style: TextStyle(
                      color: Colors.red,
                      fontSize: 14,
                    ),
                    // Add this line
                  ),
                  Container(
                    child: suffixIcon,
                  ),
                ],
              ),
              Container(
                height: height,
                width: width == 0 ? null : calculatedWidth, // 0 means null
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5),
                  border:
                      Border.all(color: AppColors.secondaryTextColor, width: 1),
                  color: !readOnly ? Colors.white : AppColors.disableGreyColor,
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: TextFormField(
                    readOnly: readOnly,
                    controller: controller,
                    keyboardType: keyboardType,
                    obscureText: isObscureText ?? false,
                    obscuringCharacter: obscureCharacter ?? '*',
                    style: const TextStyle(
                      color: Colors.black,
                      fontSize: 14,
                    ),
                    decoration: InputDecoration(
                      hintText: hintText,
                      hintStyle: GoogleFonts.poppins(
                        textStyle: const TextStyle(
                          color: AppColors
                              .greyColor, // Set the color of the hint text
                          fontSize: 14,
                        ),
                      ),
                      border: InputBorder.none,
                      isDense: true,
                      contentPadding: const EdgeInsets.symmetric(
                          vertical:
                              15), // Adjusts vertical padding to center hint text
                      counterText: '',
                    ),
                    maxLength: maxLength,
                    textAlignVertical: TextAlignVertical.center,
                    inputFormatters: inputFormatters,
                    onFieldSubmitted: (value) => onFieldSubmitted?.call(value),
                    onTap: onTap,
                    onChanged: onChange,
                    validator: validator, // Add this line
                  ),
                ),
              ),
            ],
          ),
        ErrorTextView(
          errorText: errorText,
        )
      ],
    );
  }
}
