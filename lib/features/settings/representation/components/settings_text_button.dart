import 'package:events_jo/config/extensions/color_extensions.dart';
import 'package:events_jo/config/utils/constants.dart';
import 'package:events_jo/config/utils/global_colors.dart';
import 'package:flutter/material.dart';

class SettingsTextButton extends StatelessWidget {
  final String text;
  final void Function()? onPressed;

  const SettingsTextButton({
    super.key,
    required this.text,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: onPressed,
      style: ButtonStyle(
        backgroundColor: WidgetStatePropertyAll(GColors.whiteShade3.shade600),
        shape: WidgetStatePropertyAll(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(kOuterRadius),
          ),
        ),
      ),
      icon: Text(
        text,
        style: TextStyle(
          color: GColors.royalBlue,
          fontSize: kNormalFontSize,
        ),
      ),
    );
  }
}
