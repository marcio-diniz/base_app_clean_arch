import 'package:base_app_clean_arch/core/design_system/tokens/custom_color_theme.dart';
import 'package:base_app_clean_arch/core/design_system/tokens/custom_text_style.dart';
import 'package:flutter/material.dart';

class CustomBottomSheet {
  static Future<bool> showBottomSheet({
    required BuildContext context,
    required List<Widget> children,
    String? title,
  }) async {
    return await showModalBottomSheet(
          context: context,
          backgroundColor: Colors.transparent,
          builder: (alertDialogContext) {
            final height = MediaQuery.of(context).size.height;

            return Container(
              decoration: BoxDecoration(
                color: CustomColorTheme.backgroundColor,
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(30),
                  topRight: Radius.circular(30),
                ),
              ),
              constraints: BoxConstraints(maxHeight: height * 0.7),
              padding: const EdgeInsets.all(20),
              child: SafeArea(
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      if (title != null)
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(bottom: 20),
                              child: Text(
                                title,
                                style: CustomTextStyle.bodyStyleText,
                              ),
                            ),
                          ],
                        ),
                      ListView.separated(
                        itemBuilder: (context, index) => children[index],
                        separatorBuilder: (context, index) => const Divider(),
                        itemCount: children.length,
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        ) ??
        false;
  }
}
