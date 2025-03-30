import 'package:events_jo/config/extensions/color_extensions.dart';
import 'package:events_jo/config/utils/constants.dart';
import 'package:events_jo/config/utils/global_colors.dart';
import 'package:flutter/material.dart';

class SettingsCard extends StatelessWidget {
  final String text;
  final IconData icon;
  final void Function()? onTap;

  const SettingsCard({
    super.key,
    required this.text,
    required this.icon,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: onTap,
      style: ButtonStyle(
        backgroundColor: WidgetStatePropertyAll(GColors.white),
      ),
      icon: Row(
        spacing: 10,
        children: [
          Container(
            decoration: BoxDecoration(
              color: GColors.whiteShade3.shade600,
              borderRadius: BorderRadius.circular(kOuterRadius),
            ),
            padding: const EdgeInsets.all(12),
            child: Icon(
              icon,
              size: kNormalIconSize,
              color: GColors.royalBlue,
            ),
          ),
          Text(
            text,
            style: TextStyle(
              color: GColors.black,
              fontSize: kNormalFontSize - 3,
            ),
          ),
          const Spacer(),
          IconButton(
            onPressed: onTap,
            style: ButtonStyle(
              backgroundColor: WidgetStateProperty.all(GColors.royalBlue),
              padding: WidgetStateProperty.all(EdgeInsets.zero),
            ),
            icon: Icon(
              Icons.arrow_forward_ios_rounded,
              color: GColors.white,
            ),
          ),
        ],
      ),
    );
  }
}
