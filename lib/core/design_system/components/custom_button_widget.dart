import 'package:base_app_clean_arch/core/design_system/tokens/custom_color_theme.dart';
import 'package:base_app_clean_arch/core/design_system/tokens/custom_text_style.dart';
import 'package:flutter/material.dart';

class CustomButtonWidget extends StatelessWidget {
  const CustomButtonWidget({
    super.key,
    required this.onTap,
    required this.height,
    required this.padding,
    this.title,
    this.loading,
    this.width,
    this.fontSize = 16,
    this.color,
    this.suffixIcon,
  });
  final Function() onTap;
  final String? title;
  final double height;
  final double? width;
  final double fontSize;
  final EdgeInsets? padding;
  final bool? loading;
  final Color? color;
  final Widget? suffixIcon;

  const CustomButtonWidget.verySmall({
    super.key,
    required this.onTap,
    this.height = 30,
    this.padding = const EdgeInsets.symmetric(horizontal: 10),
    this.title,
    this.width,
    this.fontSize = 14,
    this.loading,
    this.color,
    this.suffixIcon,
  });

  const CustomButtonWidget.small({
    super.key,
    required this.onTap,
    this.height = 35,
    this.padding = const EdgeInsets.symmetric(horizontal: 15),
    this.title,
    this.width,
    this.fontSize = 16,
    this.loading,
    this.color,
    this.suffixIcon,
  });

  const CustomButtonWidget.medium({
    super.key,
    required this.onTap,
    this.height = 40,
    this.padding,
    this.title,
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
          color: color ?? CustomColorTheme.primaryDarkColor,
          borderRadius: BorderRadius.circular(10.0),
        ),
        child: Visibility(
          visible: loading == true,
          replacement: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              if (title != null)
                Text(title!, style: CustomTextStyle.titleButtonStyleText),
              if (title != null && suffixIcon != null)
                const SizedBox(width: 10),
              if (suffixIcon != null) suffixIcon!,
            ],
          ),
          child: const Center(
            child: SizedBox(
              width: 25,
              height: 25,
              child: CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
