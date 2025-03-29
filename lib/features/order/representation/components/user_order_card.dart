import 'package:events_jo/config/extensions/color_extensions.dart';
import 'package:events_jo/config/extensions/int_extensions.dart';
import 'package:events_jo/config/extensions/string_extensions.dart';
import 'package:events_jo/config/utils/constants.dart';
import 'package:events_jo/config/utils/global_colors.dart';
import 'package:events_jo/features/order/domain/models/e_order.dart';
import 'package:flutter/material.dart';

class UserOrderCard extends StatelessWidget {
  final EOrder? order;
  final void Function()? onPressed;

  const UserOrderCard({
    super.key,
    this.order,
    this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: onPressed,
      style: ButtonStyle(
        backgroundColor: WidgetStatePropertyAll(GColors.white),
      ),
      icon: FittedBox(
        fit: BoxFit.scaleDown,
        alignment: Alignment.centerLeft,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          spacing: 70,
          children: [
            Row(
              spacing: 5,
              children: [
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(kOuterRadius),
                    color: GColors.whiteShade3.shade600,
                  ),
                  padding: const EdgeInsets.symmetric(
                    vertical: 4,
                    horizontal: 12,
                  ),
                  child: Column(
                    // spacing: 10,
                    children: [
                      5.height,
                      Icon(
                        Icons.pending_actions_rounded,
                        color: GColors.royalBlue,
                        size: kNormalIconSize,
                      ),
                      Text(
                        order?.status.name.toCapitalized ?? 'dummy dummy',
                        style: TextStyle(
                          color: GColors.royalBlue,
                          fontSize: kSmallFontSize,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      5.height,
                    ],
                  ),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Serail No. ${order?.id}',
                      style: TextStyle(
                        color: GColors.black.withValues(alpha: 0.7),
                        fontSize: kSmallFontSize,
                      ),
                    ),
                    Text(
                      'Total Amount: ${order?.amount}JOD',
                      style: TextStyle(
                        color: GColors.black.withValues(alpha: 0.7),
                        fontSize: kSmallFontSize,
                      ),
                    ),
                    Text(
                      'Date: ${order?.date.day}/${order?.date.month}/${order?.date.year}',
                      style: TextStyle(
                        color: GColors.black.withValues(alpha: 0.7),
                        fontSize: kSmallFontSize,
                      ),
                    ),
                  ],
                ),
              ],
            ),
            IconButton(
                onPressed: null,
                style: ButtonStyle(
                  backgroundColor: WidgetStatePropertyAll(GColors.royalBlue),
                  padding: const WidgetStatePropertyAll(
                    EdgeInsets.all(12),
                  ),
                ),
                icon: Icon(
                  Icons.info_outline_rounded,
                  color: GColors.white,
                  size: kNormalIconSize,
                ))
          ],
        ),
      ),
    );
  }
}
