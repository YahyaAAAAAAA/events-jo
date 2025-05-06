import 'package:events_jo/config/extensions/color_extensions.dart';
import 'package:events_jo/config/extensions/int_extensions.dart';
import 'package:events_jo/config/utils/constants.dart';
import 'package:events_jo/config/utils/global_colors.dart';
import 'package:events_jo/features/admin/presentation/components/admin_button.dart';
import 'package:flutter/material.dart';

class AdminCard extends StatelessWidget {
  final String count;
  final String text;
  final IconData icon;
  final void Function()? onPressed;

  const AdminCard({
    super.key,
    required this.count,
    required this.text,
    required this.icon,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return IconButton(
        onPressed: onPressed,
        padding: const EdgeInsets.all(12),
        icon: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  decoration: BoxDecoration(
                    color: GColors.cyanShade6.shade300.withValues(alpha: 0.2),
                    borderRadius: BorderRadius.circular(kOuterRadius),
                  ),
                  padding: const EdgeInsets.all(12),
                  child: Icon(
                    icon,
                    size: kNormalFontSize,
                    color: GColors.cyanShade6,
                  ),
                ),
                10.width,
                Text(
                  '${text} ${count}',
                  style: TextStyle(
                    color: GColors.black,
                    fontSize: kSmallFontSize,
                  ),
                ),
              ],
            ),
            AdminButton(
              onPressed: onPressed,
              isLoading: false,
              icon: Icons.arrow_forward_ios_rounded,
            ),
          ],
        ));
  }
}
