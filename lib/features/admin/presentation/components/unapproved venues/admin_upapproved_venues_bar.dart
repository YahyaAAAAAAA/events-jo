import 'package:events_jo/config/utils/global_colors.dart';
import 'package:flutter/material.dart';

class AdminUnapprovedVenuesBar extends StatelessWidget {
  final void Function()? onDenyPressed;
  final void Function()? onApprovePressed;

  const AdminUnapprovedVenuesBar({
    super.key,
    required this.onApprovePressed,
    required this.onDenyPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        color: GColors.white,
      ),
      padding: const EdgeInsets.all(20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          //deny button
          Row(
            children: [
              IconButton(
                onPressed: onDenyPressed,
                style: ButtonStyle(
                  backgroundColor: WidgetStatePropertyAll(GColors.cyanShade6),
                ),
                padding: const EdgeInsets.all(12),
                icon: Icon(
                  Icons.clear,
                  size: 30,
                  color: GColors.white,
                ),
              ),
              const SizedBox(width: 10),
              Text(
                'Deny',
                style: TextStyle(
                  color: GColors.black,
                  fontSize: 25,
                ),
              ),
            ],
          ),
          //approve button
          Row(
            children: [
              Text(
                'Approve',
                style: TextStyle(
                  color: GColors.black,
                  fontSize: 25,
                ),
              ),
              const SizedBox(width: 10),
              IconButton(
                onPressed: onApprovePressed,
                style: ButtonStyle(
                  backgroundColor: WidgetStatePropertyAll(GColors.cyanShade6),
                ),
                padding: const EdgeInsets.all(12),
                icon: Icon(
                  Icons.check,
                  size: 30,
                  color: GColors.white,
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}
