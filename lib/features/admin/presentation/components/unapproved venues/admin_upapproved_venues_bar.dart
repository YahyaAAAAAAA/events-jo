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
              color: GColors.cyan.withValues(alpha: 0.2),
              blurRadius: 7,
              offset: const Offset(0, 0),
            ),
          ],
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
                      backgroundColor:
                          WidgetStatePropertyAll(GColors.royalBlue),
                      shadowColor: WidgetStatePropertyAll(
                        GColors.black.withValues(alpha: 0.5),
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
                        Icons.clear,
                        size: 30,
                        color: GColors.white,
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 10),
                Text(
                  'Deny',
                  style: TextStyle(
                    color: GColors.cyanShade6,
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
                    color: GColors.cyanShade6,
                    fontSize: 25,
                  ),
                ),
                const SizedBox(width: 10),
                IconButton(
                  onPressed: onApprovePressed,
                  style: ButtonStyle(
                      backgroundColor:
                          WidgetStatePropertyAll(GColors.royalBlue),
                      shadowColor: WidgetStatePropertyAll(
                        GColors.black.withValues(alpha: 0.5),
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
                        Icons.check,
                        size: 30,
                        color: GColors.white,
                      ),
                    ),
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
