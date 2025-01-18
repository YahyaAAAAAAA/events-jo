import 'package:events_jo/config/utils/global_colors.dart';
import 'package:events_jo/features/admin/presentation/components/admin_button.dart';
import 'package:flutter/material.dart';
import 'package:skeletonizer/skeletonizer.dart';

class AdminLoadingCard extends StatelessWidget {
  const AdminLoadingCard({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Skeletonizer(
      enabled: true,
      child: Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            border: Border(
              left: BorderSide(
                color: GColors.white,
                width: 10,
              ),
            ),
            boxShadow: [
              BoxShadow(
                color: GColors.cyan.withValues(alpha: 0.2),
                blurRadius: 7,
                offset: const Offset(0, 0),
              ),
            ],
            borderRadius: BorderRadius.circular(12),
            color: GColors.white,
          ),
          child: IntrinsicHeight(
            child: Row(
              children: [
                Icon(
                  Icons.person,
                  size: 40,
                  color: GColors.cyanShade6,
                ),
                VerticalDivider(color: GColors.cyanShade6),
                Icon(
                  Icons.circle,
                  color: GColors.cyanShade6,
                  size: 12,
                ),
                const SizedBox(width: 5),
                Text(
                  'Users Count',
                  style: TextStyle(
                    color: GColors.cyanShade6,
                    fontSize: 20,
                  ),
                ),
                Text(
                  '1',
                  style: TextStyle(
                    color: GColors.cyanShade6,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const Spacer(),
                const AdminButton(
                  onPressed: null,
                  padding: EdgeInsets.zero,
                  isLoading: true,
                  buttonPadding:
                      EdgeInsets.symmetric(vertical: 20, horizontal: 20),
                  icon: Icons.arrow_forward_ios_rounded,
                ),
              ],
            ),
          )),
    );
  }
}
