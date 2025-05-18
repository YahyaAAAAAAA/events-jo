import 'package:events_jo/config/enums/order_status.dart';
import 'package:events_jo/config/extensions/color_extensions.dart';
import 'package:events_jo/config/extensions/int_extensions.dart';
import 'package:events_jo/config/utils/constants.dart';
import 'package:events_jo/config/utils/global_colors.dart';
import 'package:events_jo/features/order/domain/models/e_order.dart';
import 'package:flutter/material.dart';

class AdminOrderCard extends StatelessWidget {
  final EOrder order;
  final void Function()? onPressed;
  final String? subText;

  const AdminOrderCard({
    super.key,
    required this.order,
    this.onPressed,
    this.subText,
  });

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: onPressed,
      icon: Row(
        children: [
          Container(
            decoration: BoxDecoration(
              color: order.status.toColor().shade300.withValues(alpha: 0.2),
              borderRadius: BorderRadius.circular(kOuterRadius),
            ),
            padding: const EdgeInsets.all(12),
            child: Icon(
              order.status.toIcon(),
              size: kNormalFontSize,
              color: order.status.toColor(),
            ),
          ),
          10.width,
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Serial No. ${order.id}',
                style: TextStyle(
                  color: GColors.black.withValues(alpha: 0.7),
                  fontSize: kSmallFontSize,
                ),
              ),
              Text(
                'Total Amount: ${order.amount}JOD',
                style: TextStyle(
                  color: GColors.black.withValues(alpha: 0.7),
                  fontSize: kSmallFontSize,
                ),
              ),
              Text(
                'Date: ${order.date.day}/${order.date.month}/${order.date.year}',
                style: TextStyle(
                  color: GColors.black.withValues(alpha: 0.7),
                  fontSize: kSmallFontSize,
                ),
              ),
              if (subText != null)
                Text(
                  'Cancelled by: ${order.canceledBy}',
                  style: TextStyle(
                    color: GColors.black.withValues(alpha: 0.7),
                    fontSize: kSmallFontSize,
                  ),
                ),
            ],
          ),
          const Spacer(),
          IconButton(
            onPressed: onPressed,
            style: ButtonStyle(
              backgroundColor: WidgetStatePropertyAll(
                order.status.toColor(),
              ),
            ),
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
            icon: Icon(
              order.status == OrderStatus.completed
                  ? Icons.swap_horiz_rounded
                  : order.status == OrderStatus.cancelled
                      ? Icons.undo_rounded
                      : order.status == OrderStatus.pending
                          ? Icons.access_alarm_rounded
                          : Icons.done_all_rounded,
              color: GColors.white,
              size: kSmallIconSize,
            ),
          ),
        ],
      ),
    );
  }
}
