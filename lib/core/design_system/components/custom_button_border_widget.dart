import 'package:base_app_clean_arch/core/design_system/tokens/custom_color_theme.dart';
import 'package:base_app_clean_arch/core/design_system/tokens/custom_text_style.dart';
import 'package:flutter/material.dart';

class CustomButtonBorderWidget extends StatelessWidget {
  const CustomButtonBorderWidget({
    super.key,
    required this.onTap,
    required this.title,
    required this.height,
    required this.padding,
    this.loading,
    this.width,
    this.fontSize = 16,
    this.color,
    this.suffixIcon,
  });
  final Function() onTap;
  final String title;
  final double height;
  final double? width;
  final double? fontSize;
  final EdgeInsets? padding;
  final bool? loading;
  final Color? color;
  final Widget? suffixIcon;

  const CustomButtonBorderWidget.verySmall({
    super.key,
    required this.onTap,
    required this.title,
    this.height = 30,
    this.padding = const EdgeInsets.symmetric(horizontal: 10),
    this.width,
    this.fontSize = 14,
    this.loading,
    this.color,
    this.suffixIcon,
  });

  const CustomButtonBorderWidget.small({
    super.key,
    required this.onTap,
    required this.title,
    this.height = 35,
    this.padding = const EdgeInsets.symmetric(horizontal: 15),
    this.width,
    this.fontSize = 16,
    this.loading,
    this.color,
    this.suffixIcon,
  });

  const CustomButtonBorderWidget.medium({
    super.key,
    required this.onTap,
    required this.title,
    this.height = 40,
    this.padding,
    this.width,
    this.fontSize = 16,
    this.loading,
    this.color,
    this.suffixIcon,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        height: height,
        width: width,
        padding: padding,
        decoration: BoxDecoration(
          border: Border.all(color: color ?? CustomColorTheme.primaryColor),
          borderRadius: BorderRadius.circular(10.0),
        ),
        child: Visibility(
          visible: loading == true,
          replacement: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                title,
                style: CustomTextStyle.bodyStyleText.copyWith(color: color),
              ),
              if (suffixIcon != null)
                Padding(
                  padding: const EdgeInsets.only(left: 10),
                  child: suffixIcon,
                ),
            ],
          ),
          child: Center(
            child: SizedBox(
              width: 25,
              height: 25,
              child: CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation<Color>(
                  color ?? CustomColorTheme.primaryColor,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
