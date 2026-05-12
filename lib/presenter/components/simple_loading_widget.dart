import 'package:base_app_clean_arch/core/design_system/tokens/custom_color_theme.dart';
import 'package:flutter/material.dart';

class SimpleLoadingWidget extends StatelessWidget {
  const SimpleLoadingWidget({super.key, this.color, this.size = 35});

  final Color? color;
  final double size;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SizedBox(
        height: size,
        width: size,
        child: CircularProgressIndicator(
          color: color ?? CustomColorTheme.primaryColor,
        ),
      ),
    );
  }
}
