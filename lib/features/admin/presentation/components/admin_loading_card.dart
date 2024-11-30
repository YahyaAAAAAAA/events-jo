import 'package:events_jo/config/utils/global_colors.dart';
import 'package:events_jo/config/utils/loading/global_loading_admin.dart';
import 'package:flutter/material.dart';

class AdminLoadingCard extends StatelessWidget {
  const AdminLoadingCard({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          border: Border(
            left: BorderSide(
              color: GColors.cyanShade6,
              width: 10,
            ),
          ),
          borderRadius: BorderRadius.circular(12),
          color: GColors.white,
        ),
        child: const Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            GlobalLoadingAdminBar(withImage: false),
          ],
        ));
  }
}
