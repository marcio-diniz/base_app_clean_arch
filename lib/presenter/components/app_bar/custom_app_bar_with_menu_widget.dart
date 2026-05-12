import 'package:base_app_clean_arch/core/design_system/tokens/custom_color_theme.dart';
import 'package:base_app_clean_arch/core/design_system/tokens/custom_text_style.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class CustomAppBarWithMenu extends StatelessWidget
    implements PreferredSizeWidget {
  final String title;
  final GlobalKey<ScaffoldState> scaffoldKey;

  const CustomAppBarWithMenu({
    super.key,
    required this.title,
    required this.scaffoldKey,
  });

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: CustomColorTheme.primaryDarkColor,
      automaticallyImplyLeading: true,
      title: Text(title, style: CustomTextStyle.appBarStyleText),
      leading: InkWell(
        key: const Key('home_page_drawer'),
        borderRadius: BorderRadius.circular(20),
        child: Center(
          child: FaIcon(
            FontAwesomeIcons.bars,
            color: CustomColorTheme.backgroundColor,
            size: 24,
          ),
        ),
        onTap: () async {
          scaffoldKey.currentState!.openDrawer();
        },
      ),
    );
  }
}
