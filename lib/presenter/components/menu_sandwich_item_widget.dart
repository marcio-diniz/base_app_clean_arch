import 'package:base_app_clean_arch/core/design_system/tokens/custom_text_style.dart';
import 'package:flutter/material.dart';

class MenuSandwichItemWidget extends StatelessWidget {
  const MenuSandwichItemWidget({
    super.key,
    required this.title,
    required this.icon,
    required this.onTap,
  });

  final String title;
  final Widget icon;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsetsDirectional.fromSTEB(20.0, 0.0, 12.0, 4.0),
      child: InkWell(
        splashColor: Colors.transparent,
        focusColor: Colors.transparent,
        hoverColor: Colors.transparent,
        highlightColor: Colors.transparent,
        onTap: onTap,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 150),
          curve: Curves.easeInOut,
          width: double.infinity,
          decoration: BoxDecoration(borderRadius: BorderRadius.circular(8.0)),
          child: Padding(
            padding: const EdgeInsetsDirectional.fromSTEB(0.0, 8.0, 0.0, 8.0),
            child: Row(
              mainAxisSize: MainAxisSize.max,
              children: [
                SizedBox(width: 30, child: icon),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsetsDirectional.fromSTEB(
                      12.0,
                      0.0,
                      0.0,
                      0.0,
                    ),
                    child: Text(title, style: CustomTextStyle.bodyStyleText),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
