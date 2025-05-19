import 'package:custom_pop_up_menu/custom_pop_up_menu.dart';
import 'package:events_jo/config/extensions/build_context_extenstions.dart';
import 'package:events_jo/config/extensions/int_extensions.dart';
import 'package:events_jo/config/utils/constants.dart';
import 'package:events_jo/config/utils/global_colors.dart';
import 'package:events_jo/features/home/presentation/components/app_bar_button.dart';
import 'package:events_jo/features/support/representation/components/problem_report_dialog.dart';
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
      leading: 0.width,
      centerTitle: true,
      title: Row(
        children: [
          Row(
            spacing: 10,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              AppBarButton(
                onPressed: () => context.pop(),
                icon: Icons.arrow_back_ios_new_rounded,
                iconSize: kSmallIconSize,
              ),
              Text(
                title,
                style: TextStyle(
                  color: GColors.black,
                  fontSize: kNormalFontSize,
                ),
              ),
            ],
          ),
          const Spacer(),
          CustomPopupMenu(
            pressType: PressType.singleClick,
            arrowColor: GColors.white,
            menuBuilder: () {
              return IconButton(
                onPressed: () => context.dialog(
                  pageBuilder: (p0, _, __) => ProblemReportDialog(
                    onPressed: null,
                    controller: TextEditingController(),
                  ),
                ),
                icon: Text(
                  'Report Problem',
                  style: TextStyle(
                    color: GColors.black,
                    fontSize: kSmallFontSize,
                  ),
                ),
              );
            },
            child: AppBarButton(
              onPressed: null,
              icon: Icons.report_gmailerrorred_rounded,
              iconColor: GColors.black,
              iconSize: kSmallIconSize + 5,
            ),
          ),
          5.width,
        ],
      ),
      leadingWidth: 0,
      toolbarHeight: 70,
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(
      bottom == null ? kToolbarHeight + 20 : kToolbarHeight + 60);
}
