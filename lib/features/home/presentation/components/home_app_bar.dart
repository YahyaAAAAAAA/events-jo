import 'package:events_jo/config/extensions/int_extensions.dart';
import 'package:events_jo/config/extensions/string_extensions.dart';
import 'package:events_jo/config/utils/constants.dart';
import 'package:events_jo/config/utils/custom_icons_icons.dart';
import 'package:events_jo/config/utils/global_colors.dart';
import 'package:events_jo/features/home/presentation/components/app_bar_button.dart';
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
                    AppBarButton(
                      onPressed: onPressed,
                      icon: Icons.person_outline,
                      iconSize: kNormalIconSize,
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
                    AppBarButton(
                      onPressed: () {},
                      icon: CustomIcons.menu,
                      iconSize: kSmallIconSize,
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
