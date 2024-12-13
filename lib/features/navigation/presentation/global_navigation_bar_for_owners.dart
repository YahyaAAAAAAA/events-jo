import 'package:events_jo/config/packages/google%20navigation%20bar/gbutton.dart';
import 'package:events_jo/config/packages/google%20navigation%20bar/gnav.dart';
import 'package:events_jo/config/utils/custom_icons_icons.dart';
import 'package:events_jo/config/utils/global_colors.dart';
import 'package:events_jo/features/home/presentation/pages/home_page_for_owners.dart';
import 'package:events_jo/features/settings/representation/pages/settings_page_for_owners.dart';
import 'package:flutter/material.dart';

class GlobalNavigationBarForOwners extends StatefulWidget {
  const GlobalNavigationBarForOwners({
    super.key,
  });

  @override
  State<GlobalNavigationBarForOwners> createState() =>
      _GlobalNavigationBarForOwnersState();
}

class _GlobalNavigationBarForOwnersState
    extends State<GlobalNavigationBarForOwners> {
  //current nav bar page
  int selecetedPage = 1;

  //nav bar items
  late final List<Widget> screens;

  @override
  void initState() {
    super.initState();

    screens = [
      //first nav item
      Center(
        child: Text(
          'List of the user orders',
          style: TextStyle(
            color: GColors.black,
          ),
        ),
      ),
      //middle nav item
      const HomePageForOwners(),
      //last nav item
      const SettingsPageForOwners(),
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
                color: GColors.poloBlue,
                activeColor: GColors.royalBlue,
                rippleColor: GColors.white.withOpacity(0.2),
                iconSize: 24,
                tabBackgroundColor: Colors.transparent,
                tabActiveBorder: Border(
                  left: BorderSide(
                    color: GColors.royalBlue,
                    width: 5,
                  ),
                  right: BorderSide(
                    color: GColors.royalBlue,
                    width: 5,
                  ),
                ),
                textStyle: TextStyle(
                  fontSize: 15,
                  color: GColors.royalBlue,
                  fontWeight: FontWeight.bold,
                ),
                selectedIndex: selecetedPage,
                tabMargin: const EdgeInsets.all(5),
                padding: const EdgeInsets.all(20),
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                tabs: const [
                  GButton(
                    icon: CustomIcons.list,
                    text: ' Your Orders',
                  ),
                  GButton(
                    icon: CustomIcons.home,
                    text: ' Home',
                  ),
                  GButton(
                    icon: CustomIcons.settings,
                    text: ' Settings',
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
