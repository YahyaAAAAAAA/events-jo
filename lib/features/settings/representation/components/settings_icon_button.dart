import 'package:events_jo/config/extensions/color_extensions.dart';
import 'package:events_jo/config/utils/constants.dart';
import 'package:events_jo/config/utils/global_colors.dart';
import 'package:flutter/material.dart';

class SettingsIconButton extends StatelessWidget {
  final String text;
  final IconData icon;
  final Color? color;
  final void Function()? onPressed;

  const SettingsIconButton({
    super.key,
    required this.text,
    required this.icon,
    this.color,
    this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: onPressed,
      style: ButtonStyle(
        backgroundColor: WidgetStatePropertyAll(GColors.white),
      ),
      icon: Row(
        children: [
          Row(
            spacing: 10,
            children: [
              IconButton(
                onPressed: onPressed,
                style: ButtonStyle(
                  backgroundColor: WidgetStatePropertyAll(color != null
                      ? color!.withValues(alpha: 0.3)
                      : GColors.whiteShade3.shade600),
                  shape: WidgetStatePropertyAll(
                    RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(kOuterRadius)),
                  ),
                ),
                icon: Icon(
                  icon,
                  color: color ?? GColors.royalBlue,
                  size: kSmallIconSize + 5,
                ),
              ),
              Text(
                text,
                style: TextStyle(
                  fontSize: kSmallFontSize,
                  color: GColors.black,
                ),
              ),
            ],
          ),
          const Spacer(),
          IconButton(
            onPressed: onPressed,
            style: ButtonStyle(
              backgroundColor:
                  WidgetStatePropertyAll(color ?? GColors.royalBlue),
            ),
            icon: Icon(
              Icons.arrow_forward_ios_outlined,
              color: GColors.white,
            ),
          )
        ],
      ),
    );
  }
}
