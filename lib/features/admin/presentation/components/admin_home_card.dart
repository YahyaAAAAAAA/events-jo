import 'package:events_jo/config/extensions/color_extensions.dart';
import 'package:events_jo/config/extensions/int_extensions.dart';
import 'package:events_jo/config/utils/constants.dart';
import 'package:events_jo/config/utils/global_colors.dart';
import 'package:flutter/material.dart';

class AdminHomeCard extends StatelessWidget {
  final String text;
  final IconData icon;
  final String? count;
  final Color? bgColor;
  final Color? iconColor;
  final void Function()? onPressed;

  const AdminHomeCard({
    super.key,
    required this.text,
    required this.icon,
    this.count,
    this.bgColor,
    this.iconColor,
    this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: onPressed,
      padding: const EdgeInsets.all(12),
      icon: Row(
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
          count != null
              ? IconButton(
                  onPressed: null,
                  style: ButtonStyle(
                    backgroundColor: WidgetStatePropertyAll(
                      GColors.cyanShade6.shade300.withValues(alpha: 0.2),
                    ),
                  ),
                  padding:
                      const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                  icon: Text(
                    count!,
                    style: TextStyle(
                      color: GColors.cyanShade6,
                      fontSize: kNormalFontSize,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                )
              : 0.width,
          10.width,
          IconButton(
            onPressed: onPressed,
            style: ButtonStyle(
              backgroundColor: WidgetStatePropertyAll(
                GColors.cyanShade6,
              ),
            ),
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
            icon: Icon(
              Icons.arrow_forward_ios_rounded,
              color: GColors.white,
              size: kSmallIconSize,
            ),
          ),
        ],
      ),
    );
  }
}
