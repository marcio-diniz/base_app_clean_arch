import 'package:base_app_clean_arch/core/design_system/tokens/custom_color_theme.dart';
import 'package:base_app_clean_arch/core/design_system/tokens/custom_text_style.dart';
import 'package:flutter/material.dart';

class CustomCheckboxItem extends StatelessWidget {
  const CustomCheckboxItem({
    super.key,
    required this.description,
    required this.value,
    required this.onChanged,
    this.textStyle,
    this.padding = const EdgeInsets.only(bottom: 10),
  });
  final String description;
  final bool value;
  final Function() onChanged;
  final TextStyle? textStyle;
  final EdgeInsetsGeometry padding;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onChanged,
      child: Padding(
        padding: padding,
        child: Row(
          children: [
            Padding(
              padding: const EdgeInsets.only(right: 10),
              child: Visibility(
                visible: value,
                replacement: Icon(
                  Icons.circle_outlined,
                  color: CustomColorTheme.secondTextColor,
                ),
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    Icon(
                      Icons.circle,
                      color: CustomColorTheme.primaryColor,
                      size: 16,
                    ),
                    Icon(
                      Icons.circle_outlined,
                      color: CustomColorTheme.primaryColor,
                    ),
                  ],
                ),
              ),
            ),
            Expanded(
              child: Text(
                description,
                style: textStyle ?? CustomTextStyle.bodyStyleText,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
