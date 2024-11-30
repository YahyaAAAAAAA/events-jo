import 'package:events_jo/config/utils/global_colors.dart';
import 'package:events_jo/features/admin/presentation/components/tab_item.dart';
import 'package:flutter/material.dart';

class MenuTabBar extends StatelessWidget {
  final TabController tabController;
  const MenuTabBar({
    super.key,
    required this.tabController,
  });

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: const BorderRadius.all(Radius.circular(12)),
      child: Container(
        height: 40,
        margin: const EdgeInsets.symmetric(horizontal: 12),
        decoration: BoxDecoration(
          borderRadius: const BorderRadius.all(Radius.circular(12)),
          color: GColors.white,
        ),
        child: TabBar(
          controller: tabController,
          indicatorSize: TabBarIndicatorSize.tab,
          dividerColor: Colors.transparent,
          indicator: BoxDecoration(
            color: GColors.cyanShade6,
            borderRadius: const BorderRadius.all(Radius.circular(12)),
          ),
          labelColor: Colors.white,
          unselectedLabelColor: GColors.cyanShade6,
          tabs: [
            const TabItem(title: 'Not Approved'),
            const TabItem(title: 'Approved'),
          ],
        ),
      ),
    );
  }
}
