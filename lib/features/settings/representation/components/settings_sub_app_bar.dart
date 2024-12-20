import 'package:events_jo/config/utils/global_colors.dart';
import 'package:events_jo/features/home/presentation/components/app_bar_button.dart';
import 'package:flutter/material.dart';

class SettingsSubAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;

  const SettingsSubAppBar({
    super.key,
    this.title = '       ',
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      surfaceTintColor: Colors.transparent,
      backgroundColor: Colors.transparent,
      leading: AppBarButton(
        onPressed: () => Navigator.of(context).pop(),
        icon: Icons.arrow_back_ios_new_rounded,
        size: 25,
      ),
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
  Size get preferredSize => const Size.fromHeight(kToolbarHeight + 20);
}
