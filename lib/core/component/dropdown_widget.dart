import 'package:memmatch/core/component/error_text_view.dart';
import 'package:memmatch/core/component/ui_constant.dart';
import 'package:memmatch/core/component/ui_widget_style.dart';
import 'package:memmatch/core/component/widget_title_view.dart';
import 'package:flutter/material.dart';

import '../../res/app_colors.dart';

class CustomDropdown<T> extends StatelessWidget {
  final String? labelText;
  final List<T> items;
  final T? selectedValue;
  final ValueChanged<T?> onChanged;
  final bool isRequired;
  final String? errorText;
  final String Function(T value) displayText;
  final double? width;
  final double? height;

  const CustomDropdown({
    super.key,
    this.labelText,
    required this.items,
    required this.selectedValue,
    required this.onChanged,
    this.isRequired = false,
    this.errorText,
    required this.displayText,
    this.width,
    this.height,
  });

  @override
  Widget build(BuildContext context) {
    double calculatedWidth = width ?? UIConstant(context: context).buttonWidth;
    // ${labelText?.split(':')[0].split('(')[0].trim() ?? 'option'}
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (labelText != null) ...[
          WidgetTitleView(
            title: labelText!,
            isRequired: isRequired,
          ),
          const SizedBox(height: 8),
        ],
        Container(
          width: width == 0 ? null : calculatedWidth, // 0 means null
          height: height,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(5),
            border: Border.all(
              color: AppColors.secondaryTextColor,
              width: 1,
            ),
            color: Colors.white,
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: DropdownButtonHideUnderline(
              child: DropdownButtonFormField<T>(
                value: items.contains(selectedValue) ? selectedValue : null,
                isExpanded: true,
                hint: Text(
                  labelText == null
                      ? "Select"
                      : labelText!.toLowerCase().contains("select")
                          ? labelText!
                          : 'Select ',
                  style: UIWidgetStyle.hintTextStyle(),
                ),
                decoration: const InputDecoration(
                  border: InputBorder.none,
                  isDense: true,
                  contentPadding: EdgeInsets.symmetric(vertical: 15),
                ),
                icon: Icon(
                  Icons.keyboard_arrow_down,
                  color: AppColors.textColor,
                ),
                selectedItemBuilder: (context) {
                  return items
                      .map(
                        (item) => DropdownMenuItem<T>(
                          value: item,
                          child: Text(
                            displayText(item),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      )
                      .toList();
                },
                items: items
                    .map(
                      (item) => DropdownMenuItem<T>(
                        value: item,
                        child: Text(
                          displayText(item),
                        ),
                      ),
                    )
                    .toList(),
                onChanged: onChanged,
              ),
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
