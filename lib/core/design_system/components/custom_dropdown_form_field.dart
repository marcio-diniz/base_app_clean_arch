import 'package:base_app_clean_arch/core/design_system/tokens/custom_color_theme.dart';
import 'package:base_app_clean_arch/core/design_system/tokens/custom_text_style.dart';
import 'package:flutter/material.dart';

class CustomDropdownFormField<T> extends StatelessWidget {
  const CustomDropdownFormField({
    super.key,
    required this.context,
    required this.items,
    required this.onChanged,
    this.value,
    this.validator,
    this.labelText,
    this.hintText,
    this.backgroundColor,
  });

  final BuildContext context;
  final List<DropdownMenuItem<T>> items;
  final T? value;
  final String? labelText;
  final String? hintText;
  final void Function(T?) onChanged;
  final String? Function(T?)? validator;
  final Color? backgroundColor;

  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField<T>(
      value: value,
      onChanged: onChanged,
      validator: validator,
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
      ),
      items: items,
    );
  }
}
