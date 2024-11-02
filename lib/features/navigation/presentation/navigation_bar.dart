import 'package:events_jo/config/utils/custom_icons_icons.dart';
import 'package:events_jo/config/utils/global_colors.dart';
import 'package:events_jo/features/home/presentation/pages/home_page.dart';
import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';

class MyNavigationBar extends StatefulWidget {
  const MyNavigationBar({super.key});

  @override
  State<MyNavigationBar> createState() => _MyNavigationBarState();
}

class _MyNavigationBarState extends State<MyNavigationBar> {
  int selecetedPage = 1;

  final screens = [
    Center(
      child: Text(
        'List of the user orders',
        style: TextStyle(
          color: GlobalColors.black,
        ),
      ),
    ),
    const HomePage(),
    Center(
      child: Text(
        'Settings page',
        style: TextStyle(
          color: GlobalColors.black,
        ),
      ),
    ),
  ];

  @override
  void initState() {
    super.initState();
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
        child: ClipRRect(
          borderRadius: BorderRadius.circular(10),
          child: GNav(
            backgroundColor: GlobalColors.navBar,
            tabBorderRadius: 0,
            duration: const Duration(milliseconds: 300),
            color: GlobalColors.poloBlue,
            activeColor: GlobalColors.royalBlue,
            rippleColor: GlobalColors.white.withOpacity(0.2),
            iconSize: 24,
            tabBackgroundColor: Colors.transparent,
            tabActiveBorder: Border(
              bottom: BorderSide(
                color: GlobalColors.royalBlue,
                width: 10,
              ),
            ),
            textStyle: TextStyle(
              fontSize: 15,
              color: GlobalColors.royalBlue,
              fontWeight: FontWeight.bold,
            ),
            selectedIndex: selecetedPage,
            tabMargin: const EdgeInsets.all(5),
            padding: const EdgeInsets.all(20),
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
          ),
        ),
      ),
      body: screens[selecetedPage],
    );
  }
}
