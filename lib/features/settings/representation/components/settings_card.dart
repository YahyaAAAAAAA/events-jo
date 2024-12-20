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
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        children: [
          Icon(
            icon,
            size: iconSize,
            color: GColors.royalBlue,
          ),
          const SizedBox(width: 20),
          Text(
            text,
            style: TextStyle(
              color: GColors.royalBlue,
              fontSize: 20,
            ),
          ),
          const Spacer(),
          IconButton(
            onPressed: onTap,
            style: ButtonStyle(
              backgroundColor: WidgetStateProperty.all(Colors.transparent),
              padding: WidgetStateProperty.all(EdgeInsets.zero),
            ),
            icon: Icon(
              Icons.arrow_forward_ios_rounded,
              color: GColors.royalBlue,
            ),
          ),
        ],
      ),
    );
  }
}
