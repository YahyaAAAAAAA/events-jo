import 'package:events_jo/config/extensions/color_extensions.dart';
import 'package:events_jo/config/extensions/int_extensions.dart';
import 'package:events_jo/config/utils/constants.dart';
import 'package:events_jo/config/utils/global_colors.dart';
import 'package:flutter/material.dart';

class AdminHomeCard extends StatelessWidget {
  final String count;
  final String text;
  final IconData icon;
  final Color? bgColor;
  final Color? iconColor;

  const AdminHomeCard({
    super.key,
    required this.count,
    required this.text,
    required this.icon,
    this.bgColor,
    this.iconColor,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(kOuterRadius),
        color: GColors.white,
      ),
      child: Row(
        children: [
          Container(
            decoration: BoxDecoration(
              color:
                  bgColor ?? GColors.cyanShade6.shade300.withValues(alpha: 0.2),
              borderRadius: BorderRadius.circular(kOuterRadius),
            ),
            padding: const EdgeInsets.all(12),
            child: Icon(
              icon,
              size: kNormalFontSize,
              color: iconColor ?? GColors.cyanShade6,
            ),
          ),
          10.width,
          Text(
            text,
            style: TextStyle(
              color: GColors.black,
              fontSize: kNormalFontSize - 3,
            ),
          ),
          const Spacer(),
          IconButton(
            onPressed: null,
            style: ButtonStyle(
              backgroundColor: WidgetStatePropertyAll(
                GColors.cyanShade6,
              ),
            ),
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
            icon: Text(
              count,
              style: TextStyle(
                color: GColors.white,
                fontSize: kNormalFontSize,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
