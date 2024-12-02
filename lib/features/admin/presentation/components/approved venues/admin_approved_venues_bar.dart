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
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          color: GColors.white,
          border: Border(
            left: BorderSide(
              color: GColors.cyanShade6,
              width: 10,
            ),
            right: BorderSide(
              color: GColors.cyanShade6,
              width: 10,
            ),
          ),
          boxShadow: [
            BoxShadow(
              color: GColors.cyan.withOpacity(0.2),
              blurRadius: 7,
              offset: const Offset(0, 0),
            ),
          ],
        ),
        padding: const EdgeInsets.all(20),
        //suspend button
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            IconButton(
              onPressed: onSuspendPressed,
              style: ButtonStyle(
                  backgroundColor: WidgetStatePropertyAll(GColors.royalBlue),
                  shadowColor: WidgetStatePropertyAll(
                    GColors.black.withOpacity(0.5),
                  ),
                  elevation: const WidgetStatePropertyAll(3),
                  shape: WidgetStatePropertyAll(
                    RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  padding: const WidgetStatePropertyAll(EdgeInsets.zero)),
              icon: Ink(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  gradient: GColors.adminGradient,
                ),
                child: Padding(
                  padding: const EdgeInsets.all(15),
                  child: Icon(
                    CustomIcons.hammer_crash,
                    size: 30,
                    color: GColors.white,
                  ),
                ),
              ),
            ),
            const SizedBox(width: 10),
            Text(
              'Suspend',
              style: TextStyle(
                color: GColors.cyanShade6,
                fontSize: 25,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
