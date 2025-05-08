import 'package:events_jo/config/utils/constants.dart';
import 'package:events_jo/config/utils/custom_icons_icons.dart';
import 'package:events_jo/config/utils/global_colors.dart';
import 'package:events_jo/features/admin/presentation/pages/admin_page_for_events.dart';
import 'package:events_jo/features/admin/presentation/pages/admin_page_for_orders.dart';
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
      const HomePageForAdmins(),
      const AdminPageForOrders(),
      const AdminPageForEvents(),
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
              color: GColors.cyanShade6,
            ),
            icon: const Icon(
              CustomIcons.home,
            ),
            label: 'Home',
          ),
          NavigationDestination(
            selectedIcon: Icon(
              CustomIcons.list,
              color: GColors.cyanShade6,
            ),
            icon: const Icon(
              CustomIcons.list,
            ),
            label: 'Bookings',
          ),
          NavigationDestination(
            selectedIcon: Icon(
              Icons.person_4_rounded,
              color: GColors.cyanShade6,
              size: kNormalIconSize + 5,
            ),
            icon: const Icon(
              Icons.person_4_rounded,
              size: kNormalIconSize + 5,
            ),
            label: 'Events',
          ),
        ],
        onDestinationSelected: (value) => setState(() => selectedPage = value),
      ),
      body: AnimatedSwitcher(
          duration: const Duration(milliseconds: 500),
          transitionBuilder: (child, animation) {
            return FadeTransition(opacity: animation, child: child);
          },
          child: screens[selectedPage]),
    );
  }
}
