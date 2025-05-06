import 'package:events_jo/config/extensions/color_extensions.dart';
import 'package:events_jo/config/extensions/int_extensions.dart';
import 'package:events_jo/config/utils/constants.dart';
import 'package:events_jo/config/utils/global_colors.dart';
import 'package:events_jo/features/admin/presentation/components/admin_button.dart';
import 'package:flutter/material.dart';

class AdminUsersCard extends StatelessWidget {
  final String name;
  final int index;
  final bool isOnline;
  final bool isLoading;
  final void Function()? onPressed;

  const AdminUsersCard({
    super.key,
    required this.name,
    required this.index,
    required this.isOnline,
    required this.isLoading,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: IconButton(
        onPressed: onPressed,
        icon: Row(
          children: [
            IconButton(
              onPressed: null,
              style: ButtonStyle(
                backgroundColor: WidgetStatePropertyAll(
                  GColors.cyanShade6.shade300.withValues(alpha: 0.2),
                ),
              ),
              icon: Icon(
                Icons.person_rounded,
                color: GColors.cyanShade6,
                size: kNormalIconSize,
              ),
            ),
            10.width,
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    name,
                    style: TextStyle(
                      color: GColors.black,
                      fontSize: kNormalFontSize,
                    ),
                  ),
                  Row(
                    children: [
                      Icon(
                        Icons.circle,
                        color:
                            isOnline ? GColors.greenShade3 : GColors.redShade3,
                        size: kSmallIconSize - 3,
                      ),
                      const SizedBox(width: 5),
                      Text(
                        isOnline ? 'Online' : 'Offline',
                        style: TextStyle(
                          color: GColors.black,
                          fontSize: kSmallFontSize,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            AdminButton(
              onPressed: onPressed,
              isLoading: isLoading,
              icon: Icons.info_outline_rounded,
            ),
          ],
        ),
      ),
    );
  }
}
