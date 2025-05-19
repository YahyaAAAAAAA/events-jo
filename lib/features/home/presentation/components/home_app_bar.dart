import 'package:custom_pop_up_menu/custom_pop_up_menu.dart';
import 'package:events_jo/config/extensions/build_context_extenstions.dart';
import 'package:events_jo/config/extensions/int_extensions.dart';
import 'package:events_jo/config/extensions/string_extensions.dart';
import 'package:events_jo/config/utils/constants.dart';
import 'package:events_jo/config/utils/custom_icons_icons.dart';
import 'package:events_jo/config/utils/global_colors.dart';
import 'package:events_jo/features/home/presentation/components/app_bar_button.dart';
import 'package:events_jo/features/support/representation/components/problem_report_dialog.dart';
import 'package:flutter/material.dart';

class HomeAppBar extends StatelessWidget implements PreferredSizeWidget {
  final void Function()? onOwnerButtonTap;
  final void Function()? onChatsPressed;
  final void Function()? onPressed;
  final String title;
  final bool isOwner;
  final PreferredSize? bottom;

  const HomeAppBar({
    super.key,
    required this.isOwner,
    this.onPressed,
    this.title = '       ',
    this.onOwnerButtonTap,
    this.onChatsPressed,
    this.bottom,
  });

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: PreferredSize(
        preferredSize: preferredSize,
        child: AppBar(
          surfaceTintColor: Colors.transparent,
          backgroundColor: Colors.transparent,
          centerTitle: true,
          title: MediaQuery.of(context).size.width >= 300
              ? Row(
                  children: [
                    CustomPopupMenu(
                      pressType: PressType.singleClick,
                      arrowColor: GColors.white,
                      menuBuilder: () {
                        return IconButton(
                          onPressed: onPressed,
                          icon: Text(
                            'Logout',
                            style: TextStyle(
                              color: GColors.black,
                              fontSize: kSmallFontSize,
                            ),
                          ),
                        );
                      },
                      child: AppBarButton(
                        onPressed: null,
                        icon: Icons.person_outline,
                        iconColor: GColors.black,
                        iconSize: kNormalIconSize,
                      ),
                    ),
                    10.width,
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          //todo user name
                          'Hello ${title.toCapitalized}',
                          style: TextStyle(
                            color: GColors.black,
                            fontSize: kSmallFontSize,
                          ),
                        ),
                        Text(
                          DateTime.now().hour < 12
                              ? 'Good Morning!'
                              : 'Good Night!',
                          style: TextStyle(
                            color: GColors.black,
                            fontWeight: FontWeight.bold,
                            fontSize: kSmallFontSize,
                          ),
                        ),
                      ],
                    ),
                    const Spacer(),
                    isOwner
                        ? AppBarButton(
                            onPressed: onOwnerButtonTap,
                            icon: Icons.person_4_outlined,
                            iconSize: kSmallIconSize + 5,
                            iconColor: GColors.white,
                            style: ButtonStyle(
                              backgroundColor:
                                  WidgetStatePropertyAll(GColors.royalBlue),
                            ),
                          )
                        : 0.width,
                    isOwner ? 5.width : 0.width,
                    onChatsPressed != null
                        ? AppBarButton(
                            onPressed: onChatsPressed,
                            icon: Icons.message_outlined,
                            iconSize: kSmallIconSize + 3,
                          )
                        : 0.width,
                    5.width,
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
                        icon: CustomIcons.menu,
                        iconColor: GColors.black,
                        iconSize: kSmallIconSize,
                      ),
                    ),
                    5.width,
                  ],
                )
              : 0.width,
          toolbarHeight: 70,
          bottom: bottom,
        ),
      ),
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(
      bottom == null ? kToolbarHeight + 20 : kToolbarHeight + 60);
}
