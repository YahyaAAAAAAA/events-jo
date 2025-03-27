import 'package:events_jo/config/utils/constants.dart';
import 'package:events_jo/config/utils/custom_icons_icons.dart';
import 'package:events_jo/config/utils/global_colors.dart';
import 'package:events_jo/features/admin/presentation/pages/admin_page_for_courts.dart';
import 'package:events_jo/features/admin/presentation/pages/admin_page_for_farms.dart';
import 'package:events_jo/features/admin/presentation/pages/admin_page_for_venues.dart';
import 'package:events_jo/features/home/presentation/pages/home_page_for_admins.dart';
import 'package:flutter/material.dart';

class GlobalNavigationBarForAdmins extends StatefulWidget {
  const GlobalNavigationBarForAdmins({
    super.key,
  });

  @override
  State<GlobalNavigationBarForAdmins> createState() =>
      _GlobalNavigationBarForAdminsState();
}

class _GlobalNavigationBarForAdminsState
    extends State<GlobalNavigationBarForAdmins> {
  // Current nav bar page
  int selectedPage = 0;

  // Nav bar items
  late final List<Widget> screens;

  @override
  void initState() {
    super.initState();

    screens = [
      // First nav item
      const HomePageForAdmins(),
      // Second nav item
      const AdminPageForVenues(),
      // Third nav item
      const AdminPageForFarms(),
      // Fourth nav item
      const AdminPageForCourts(),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: false,
      bottomNavigationBar: NavigationBar(
        backgroundColor: GColors.navBar,
        selectedIndex: selectedPage,
        animationDuration: const Duration(milliseconds: 300),
        indicatorColor: GColors.royalBlue.withValues(alpha: 0),
        indicatorShape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(kOuterRadius),
        ),
        labelTextStyle: WidgetStatePropertyAll(TextStyle(
          color: GColors.black,
          fontFamily: 'Abel',
        )),
        destinations: [
          NavigationDestination(
            selectedIcon: Icon(
              CustomIcons.home,
              color: GColors.royalBlue,
            ),
            icon: const Icon(
              CustomIcons.home,
            ),
            label: 'Home',
          ),
          NavigationDestination(
            selectedIcon: Icon(
              CustomIcons.wedding,
              color: GColors.royalBlue,
            ),
            icon: const Icon(
              CustomIcons.wedding,
            ),
            label: 'Venues',
          ),
          NavigationDestination(
            selectedIcon: Icon(
              CustomIcons.farm,
              color: GColors.royalBlue,
            ),
            icon: const Icon(
              CustomIcons.farm,
            ),
            label: 'Farms',
          ),
          NavigationDestination(
            selectedIcon: Icon(
              CustomIcons.football,
              color: GColors.royalBlue,
            ),
            icon: const Icon(
              CustomIcons.football,
            ),
            label: 'Courts',
          ),
        ],
        onDestinationSelected: (value) => setState(() => selectedPage = value),
      ),
      body: screens[selectedPage],
    );
  }
}
