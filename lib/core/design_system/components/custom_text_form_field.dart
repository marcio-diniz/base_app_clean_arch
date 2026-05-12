import 'package:base_app_clean_arch/core/design_system/tokens/custom_color_theme.dart';
import 'package:base_app_clean_arch/core/design_system/tokens/custom_text_style.dart';
import 'package:flutter/material.dart';

class CustomTextFormField extends TextFormField {
  CustomTextFormField({
    super.key,
    required this.context,
    super.controller,
    super.onChanged,
    super.validator,
    this.labelText,
    this.hintText,
    this.backgroundColor,
    this.suffixIcon,
    this.textStyle,
    super.inputFormatters,
    super.obscureText,
    super.autofillHints,
    super.keyboardType,
    super.maxLines,
    super.minLines,
  }) : super(
         decoration: InputDecoration(
           labelText: labelText,
           labelStyle: CustomTextStyle.bodyStyleText,
           filled: true,
           fillColor: backgroundColor ?? CustomColorTheme.backgroundColor,
           isDense: true,
           hintText: hintText,
           hintStyle: const TextStyle(fontSize: 14),
           contentPadding: const EdgeInsets.symmetric(
             horizontal: 20,
             vertical: 15,
           ),
           border: OutlineInputBorder(
             borderRadius: BorderRadius.circular(10),
             borderSide: BorderSide.none,
           ),
           focusColor: Colors.red,
           hoverColor: Colors.blue,
           suffixIcon: suffixIcon,
         ),
         style: textStyle ?? CustomTextStyle.bodyStyleText,
       );
  final BuildContext context;
  final String? labelText;
  final String? hintText;
  final Color? backgroundColor;
  final Widget? suffixIcon;
  final TextStyle? textStyle;
}
