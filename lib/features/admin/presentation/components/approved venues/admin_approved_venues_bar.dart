import 'package:events_jo/config/utils/custom_icons_icons.dart';
import 'package:events_jo/config/utils/global_colors.dart';
import 'package:flutter/material.dart';

class AdminApprovedVenuesBar extends StatelessWidget {
  final void Function()? onSuspendPressed;

  const AdminApprovedVenuesBar({
    super.key,
    required this.onSuspendPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        color: GColors.white,
      ),
      padding: const EdgeInsets.all(20),
      //suspend button
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          IconButton(
            onPressed: onSuspendPressed,
            style: ButtonStyle(
              backgroundColor: WidgetStatePropertyAll(GColors.cyanShade6),
            ),
            padding: const EdgeInsets.all(12),
            icon: Icon(
              CustomIcons.hammer_crash,
              size: 30,
              color: GColors.white,
            ),
          ),
          const SizedBox(width: 10),
          Text(
            'Suspend',
            style: TextStyle(
              color: GColors.black,
              fontSize: 25,
            ),
          ),
        ],
      ),
    );
  }
}
