import 'package:base_app_clean_arch/core/design_system/tokens/custom_color_theme.dart';
import 'package:flutter/material.dart';

class CustomLoadRestart extends StatelessWidget {
  const CustomLoadRestart({super.key, required this.isLoading});
  final bool isLoading;

  @override
  Widget build(BuildContext context) {
    return Visibility(
      visible: isLoading,
      child: LinearProgressIndicator(
        color: CustomColorTheme.primaryColor,
        backgroundColor: CustomColorTheme.backgroundColor,
      ),
    );
  }
}
