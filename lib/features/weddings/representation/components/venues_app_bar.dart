import 'package:events_jo/config/extensions/build_context_extenstions.dart';
import 'package:events_jo/config/extensions/int_extensions.dart';
import 'package:events_jo/config/extensions/string_extensions.dart';
import 'package:events_jo/config/utils/constants.dart';
import 'package:events_jo/config/utils/custom_icons_icons.dart';
import 'package:events_jo/config/utils/global_colors.dart';
import 'package:events_jo/features/auth/domain/entities/app_user.dart';
import 'package:events_jo/features/home/presentation/components/app_bar_button.dart';
import 'package:flutter/material.dart';

class VenuesAppBar extends StatelessWidget implements PreferredSizeWidget {
  final AppUser? user;
  final String? venueName;

  const VenuesAppBar({
    super.key,
    required this.user,
    this.venueName,
  });

  @override
  Widget build(BuildContext context) {
    return PreferredSize(
      preferredSize: preferredSize,
      child: AppBar(
        surfaceTintColor: Colors.transparent,
        backgroundColor: Colors.transparent,
        centerTitle: true,
        leading: 0.width,
        toolbarHeight: 70,
        leadingWidth: 0,
        title: MediaQuery.of(context).size.width >= 260
            ? Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  AppBarButton(
                    onPressed: () => context.pop(),
                    icon: Icons.arrow_back_ios_new_rounded,
                    iconSize: kNormalIconSize,
                  ),
                  10.width,
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        //todo user name
                        venueName == null
                            ? 'Venue 123'
                            : '${venueName!.toCapitalized}',
                        style: TextStyle(
                          color: GColors.black,
                          fontSize: kSmallFontSize,
                        ),
                      ),
                      Text(
                        'Wedding Venue',
                        style: TextStyle(
                          color: GColors.black,
                          fontWeight: FontWeight.bold,
                          fontSize: kSmallFontSize,
                        ),
                      ),
                    ],
                  ),
                  const Spacer(),
                  AppBarButton(
                    onPressed: () => context.pop(),
                    icon: Icons.star_rate_rounded,
                    iconSize: kNormalIconSize,
                  ),
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
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight + 20);
}
