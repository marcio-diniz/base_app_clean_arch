import 'package:base_app_clean_arch/core/design_system/tokens/custom_color_theme.dart';
import 'package:base_app_clean_arch/core/design_system/tokens/custom_text_style.dart';
import 'package:flutter/material.dart';

String? currentSnackBarError;

class CustomSnackBar {
  static void showError({
    required BuildContext context,
    required String? title,
  }) async {
    if (currentSnackBarError == title) {
      return;
    }
    currentSnackBarError = title;
    ScaffoldMessenger.of(context)
        .showSnackBar(
          SnackBar(
            content: Text(
              title ?? 'Ocorreu um erro!',
              style: CustomTextStyle.snackBarStyleBoldText,
            ),
            duration: const Duration(milliseconds: 4000),
            backgroundColor: CustomColorTheme.error,
          ),
        )
        .closed
        .then((_) {
          currentSnackBarError = null;
        });
  }

  static void showSuccess({
    required BuildContext context,
    required String? title,
  }) async {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          title ?? 'Sucesso!',
          style: CustomTextStyle.snackBarStyleBoldText,
        ),
        duration: const Duration(milliseconds: 4000),
        backgroundColor: CustomColorTheme.success,
      ),
    );
  }
}
