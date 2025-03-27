import 'package:events_jo/config/utils/global_colors.dart';
import 'package:events_jo/features/home/presentation/components/app_bar_button.dart';
import 'package:flutter/material.dart';

class SettingsSubAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final PreferredSize? bottom;

  const SettingsSubAppBar({
    super.key,
    this.title = '       ',
    this.bottom,
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      surfaceTintColor: Colors.transparent,
      backgroundColor: Colors.transparent,
      bottom: bottom,
      leading: AppBarButton(
        onPressed: () => Navigator.of(context).pop(),
        icon: Icons.arrow_back_ios_new_rounded,
        iconSize: 25,
      ),
      centerTitle: true,
      title: FittedBox(
        child: Text(
          title,
          style: TextStyle(
            color: GColors.black,
            fontSize: 25,
          ),
        ),
      ),
      leadingWidth: 90,
      toolbarHeight: 70,
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(
      bottom == null ? kToolbarHeight + 20 : kToolbarHeight + 60);
}
