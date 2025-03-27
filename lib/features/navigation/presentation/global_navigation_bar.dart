import 'package:events_jo/config/utils/constants.dart';
import 'package:events_jo/config/utils/custom_icons_icons.dart';
import 'package:events_jo/config/utils/global_colors.dart';
import 'package:events_jo/features/home/presentation/pages/home_page.dart';
import 'package:events_jo/features/settings/representation/pages/settings_page.dart';
import 'package:flutter/material.dart';

class GlobalNavigationBar extends StatefulWidget {
  const GlobalNavigationBar({
    super.key,
  });

  @override
  State<GlobalNavigationBar> createState() => _GlobalNavigationBarState();
}

class _GlobalNavigationBarState extends State<GlobalNavigationBar> {
  //current nav bar page
  int selecetedPage = 0;

  //nav bar items
  late final List<Widget> screens;

  @override
  void initState() {
    super.initState();

    screens = [
      //first nav item
      const HomePage(),
      //middle nav item
      Center(
        child: Text(
          'List of the user orders',
          style: TextStyle(
            color: GColors.black,
          ),
        ),
      ),
      //last nav item
      const SettingsPage(),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: false,
      bottomNavigationBar: NavigationBar(
        backgroundColor: GColors.navBar,
        selectedIndex: selecetedPage,
        animationDuration: const Duration(milliseconds: 300),
        indicatorColor: GColors.royalBlue.withValues(alpha: 0),
        indicatorShape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(kOuterRadius)),
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
              CustomIcons.list,
              color: GColors.royalBlue,
            ),
            icon: const Icon(
              CustomIcons.list,
            ),
            label: 'Your Orders',
          ),
          NavigationDestination(
            selectedIcon: Icon(
              CustomIcons.settings,
              color: GColors.royalBlue,
            ),
            icon: const Icon(
              CustomIcons.settings,
            ),
            label: 'Settings',
          ),
        ],
        onDestinationSelected: (value) => setState(() => selecetedPage = value),
      ),
      body: screens[selecetedPage],
    );
  }
}
