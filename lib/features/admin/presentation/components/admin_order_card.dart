import 'package:events_jo/config/enums/order_status.dart';
import 'package:events_jo/config/extensions/color_extensions.dart';
import 'package:events_jo/config/extensions/int_extensions.dart';
import 'package:events_jo/config/utils/constants.dart';
import 'package:events_jo/config/utils/global_colors.dart';
import 'package:events_jo/features/order/domain/models/e_order_detailed.dart';
import 'package:flutter/material.dart';

class AdminOrderCard extends StatelessWidget {
  final EOrderDetailed detaildOrder;
  final void Function()? onPressed;

  const AdminOrderCard({
    super.key,
    required this.detaildOrder,
    this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: onPressed,
      icon: Row(
        children: [
          Container(
            decoration: BoxDecoration(
              // color: GColors.cyanShade6.shade300.withValues(alpha: 0.2),
              color: detaildOrder.order.status
                  .toColor()
                  .shade300
                  .withValues(alpha: 0.2),
              borderRadius: BorderRadius.circular(kOuterRadius),
            ),
            padding: const EdgeInsets.all(12),
            child: Icon(
              detaildOrder.order.status.toIcon(),
              size: kNormalFontSize,
              color: detaildOrder.order.status.toColor(),
            ),
          ),
          10.width,
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Serial No. ${detaildOrder.order.id}',
                style: TextStyle(
                  color: GColors.black.withValues(alpha: 0.7),
                  fontSize: kSmallFontSize,
                ),
              ),
              Text(
                'Total Amount: ${detaildOrder.order.amount}JOD',
                style: TextStyle(
                  color: GColors.black.withValues(alpha: 0.7),
                  fontSize: kSmallFontSize,
                ),
              ),
              Text(
                'Date: ${detaildOrder.order.date.day}/${detaildOrder.order.date.month}/${detaildOrder.order.date.year}',
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
                detaildOrder.order.status.toColor(),
              ),
            ),
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
            icon: Icon(
              detaildOrder.order.status == OrderStatus.completed
                  ? Icons.swap_horiz_rounded
                  : detaildOrder.order.status == OrderStatus.canceled
                      ? Icons.undo_rounded
                      : detaildOrder.order.status == OrderStatus.pending
                          ? Icons.access_alarm_rounded
                          : Icons.stop_circle,
              color: GColors.white,
              size: kSmallIconSize,
            ),
          ),
        ],
      ),
    );
  }
}
