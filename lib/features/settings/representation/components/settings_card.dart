import 'package:events_jo/config/utils/global_colors.dart';
import 'package:flutter/material.dart';

class SettingsCard extends StatelessWidget {
  final String text;
  final IconData icon;
  final double iconSize;
  final void Function()? onTap;

  const SettingsCard({
    super.key,
    required this.text,
    required this.icon,
    required this.iconSize,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(15),
        decoration: BoxDecoration(
          border: Border(
            left: BorderSide(
              color: GColors.royalBlue,
              width: 10,
            ),
          ),
          borderRadius: BorderRadius.circular(12),
          color: GColors.white,
        ),
        child: Row(
          children: [
            Icon(
              icon,
              size: iconSize,
              color: GColors.royalBlue,
            ),
            const SizedBox(width: 10),
            Text(
              text,
              style: TextStyle(
                color: GColors.royalBlue,
                fontSize: 20,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
