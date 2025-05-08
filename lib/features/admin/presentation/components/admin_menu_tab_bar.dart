import 'package:events_jo/config/utils/global_colors.dart';
import 'package:events_jo/features/admin/presentation/components/admin_tab_item.dart';
import 'package:flutter/material.dart';

class AdminMenuTabBar extends StatelessWidget {
  final TabController controller;

  const AdminMenuTabBar({
    super.key,
    required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: const BorderRadius.all(Radius.circular(12)),
      child: Container(
        height: 40,
        margin: const EdgeInsets.symmetric(horizontal: 12),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          color: GColors.white,
        ),
        child: TabBar(
          controller: controller,
          tabAlignment: TabAlignment.center,
          indicatorSize: TabBarIndicatorSize.tab,
          dividerColor: Colors.transparent,
          indicator: BoxDecoration(
            color: GColors.cyanShade6,
            borderRadius: const BorderRadius.all(
              Radius.circular(12),
            ),
          ),
          labelColor: Colors.white,
          unselectedLabelColor: GColors.cyanShade6,
          tabs: [
            const AdminTabItem(
              title: 'Disapproved',
            ),
            const AdminTabItem(
              title: 'Approved',
            ),
          ],
        ),
      ),
    );
  }
}
