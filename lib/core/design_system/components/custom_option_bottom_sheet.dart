import 'package:base_app_clean_arch/core/design_system/tokens/custom_text_style.dart';
import 'package:flutter/material.dart';

class CustomOptionBottomSheet extends StatelessWidget {
  const CustomOptionBottomSheet({
    super.key,
    required this.title,
    required this.icon,
    required this.onTap,
  });

  final String title;
  final Widget icon;
  final Function() onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.of(context).pop();
        onTap();
      },
      child: Padding(
        padding: const EdgeInsets.only(bottom: 5, top: 5),
        child: Row(
          children: [
            Padding(padding: const EdgeInsets.only(right: 10), child: icon),
            Expanded(child: Text(title, style: CustomTextStyle.bodyStyleText)),
          ],
        ),
      ),
    );
  }
}
