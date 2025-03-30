import 'package:events_jo/config/utils/constants.dart';
import 'package:events_jo/config/utils/global_colors.dart';
import 'package:events_jo/features/owner/representation/components/venues/owner_tab_item.dart';
import 'package:flutter/material.dart';

class OwnerMenuTabBar extends StatelessWidget {
  final TabController controller;

  const OwnerMenuTabBar({
    super.key,
    required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(kOuterRadius),
      child: ColoredBox(
        color: GColors.white,
        child: TabBar(
          controller: controller,
          tabAlignment: TabAlignment.center,
          indicatorSize: TabBarIndicatorSize.tab,
          dividerColor: Colors.transparent,
          splashBorderRadius: BorderRadius.circular(kOuterRadius),
          indicator: BoxDecoration(
            color: GColors.royalBlue,
            borderRadius: const BorderRadius.all(
              Radius.circular(kOuterRadius),
            ),
          ),
          labelColor: Colors.white,
          unselectedLabelColor: GColors.royalBlue,
          tabs: [
            const OwnerTabItem(
              title: 'Approved',
              count: 0,
            ),
            const OwnerTabItem(
              title: 'Pending',
              count: 0,
            ),
          ],
        ),
      ),
    );
  }
}
