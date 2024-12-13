import 'package:events_jo/config/packages/google%20navigation%20bar/gbutton.dart';
import 'package:events_jo/config/packages/google%20navigation%20bar/gnav.dart';
import 'package:events_jo/config/utils/custom_icons_icons.dart';
import 'package:events_jo/config/utils/global_colors.dart';
import 'package:events_jo/features/admin/presentation/pages/admin_page_for_courts.dart';
import 'package:events_jo/features/admin/presentation/pages/admin_page_for_farms.dart';
import 'package:events_jo/features/admin/presentation/pages/admin_page_for_venues.dart';
import 'package:events_jo/features/auth/domain/entities/app_user.dart';
import 'package:events_jo/features/home/presentation/pages/home_page_for_admins.dart';
import 'package:flutter/material.dart';

class GlobalNavigationBarForAdmins extends StatefulWidget {
  //request user from gate
  final AppUser? user;

  const GlobalNavigationBarForAdmins({
    super.key,
    required this.user,
  });

  @override
  State<GlobalNavigationBarForAdmins> createState() =>
      _GlobalNavigationBarForAdminsState();
}

class _GlobalNavigationBarForAdminsState
    extends State<GlobalNavigationBarForAdmins> {
  late final AppUser? user;

  //current nav bar page
  int selecetedPage = 0;

  //nav bar items
  late final List<Widget> screens;

  @override
  void initState() {
    super.initState();

    user = widget.user;

    screens = [
      //first nav item
      HomePageForAdmins(user: user),
      //second nav item
      AdminPageForVenues(user: user),
      //third nav item
      const AdminPageForFarms(),
      //forth nav item
      const AdminPageForCourts(),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: false,
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.only(
          left: 15,
          right: 15,
          bottom: 15,
        ),
        child: MediaQuery.of(context).size.width > 320
            ? GNav(
                backgroundColor: GColors.navBar,
                tabBorderRadius: 12,
                duration: const Duration(milliseconds: 300),
                color: GColors.cyanShade6,
                activeColor: GColors.cyanShade6,
                rippleColor: GColors.white.withOpacity(0.2),
                iconSize: 24,
                tabBackgroundColor: Colors.transparent,
                tabActiveBorder: Border(
                  left: BorderSide(
                    color: GColors.cyanShade6,
                    width: 5,
                  ),
                  right: BorderSide(
                    color: GColors.cyanShade6,
                    width: 5,
                  ),
                ),
                textStyle: TextStyle(
                  fontSize: 15,
                  color: GColors.cyanShade6,
                  fontWeight: FontWeight.bold,
                ),
                selectedIndex: selecetedPage,
                tabMargin: const EdgeInsets.all(5),
                padding: const EdgeInsets.all(20),
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                tabs: const [
                  GButton(
                    icon: CustomIcons.home,
                    text: ' Home',
                  ),
                  GButton(
                    icon: CustomIcons.wedding,
                    text: ' Venues',
                  ),
                  GButton(
                    icon: CustomIcons.farm,
                    text: ' Farms',
                  ),
                  GButton(
                    icon: CustomIcons.football,
                    text: ' Courts',
                  ),
                ],
                onTabChange: (value) => setState(() => selecetedPage = value),
              )
            : const SizedBox(),
      ),
      body: screens[selecetedPage],
    );
  }
}
