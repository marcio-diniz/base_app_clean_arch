import 'package:base_app_clean_arch/core/design_system/tokens/custom_color_theme.dart';
import 'package:flutter/material.dart';

class CustomTextStyle {
  static TextStyle bigTitleStyleText = TextStyle(
    fontFamily: 'Rubik',
    color: CustomColorTheme.primaryDarkColor,
    fontSize: 28,
    fontWeight: FontWeight.w700,
  );

  static TextStyle titleStyleText = TextStyle(
    fontFamily: 'Rubik',
    fontSize: 20,
    fontWeight: FontWeight.w600,
    color: CustomColorTheme.primaryTextColor,
  );

  static TextStyle appBarStyleText = TextStyle(
    fontFamily: 'Rubik',
    fontSize: 20,
    fontWeight: FontWeight.w600,
    color: Colors.white,
  );

  static TextStyle titleButtonStyleText = TextStyle(
    fontFamily: 'Rubik',
    fontSize: 18,
    fontWeight: FontWeight.w600,
    color: Colors.white,
  );

  static TextStyle subTitleStyleText = TextStyle(
    fontFamily: 'Rubik',
    fontSize: 16,
    fontWeight: FontWeight.w500,
    color: CustomColorTheme.primaryTextColor,
  );

  static TextStyle subTitleSemiBoldStyleText = TextStyle(
    fontFamily: 'Rubik',
    fontSize: 16,
    fontWeight: FontWeight.w600,
    color: CustomColorTheme.primaryTextColor,
  );

  static TextStyle bodyStyleText = TextStyle(
    fontFamily: 'Rubik',
    color: CustomColorTheme.primaryTextColor,
  );

  static TextStyle bodyStyleOpactyText = TextStyle(
    fontFamily: 'Rubik',
    color: CustomColorTheme.secondTextColor,
  );

  static TextStyle bodyStyleBoldText = TextStyle(
    fontFamily: 'Rubik',
    color: CustomColorTheme.primaryTextColor,
    fontWeight: FontWeight.bold,
  );

  static TextStyle snackBarStyleBoldText = TextStyle(
    fontFamily: 'Rubik',
    color: Colors.white,
    fontWeight: FontWeight.w500,
  );
}
