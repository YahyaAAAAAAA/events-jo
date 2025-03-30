import 'package:events_jo/config/utils/constants.dart';
import 'package:events_jo/config/utils/global_colors.dart';
import 'package:flutter/material.dart';

class SettingsSwitch extends StatelessWidget {
  final bool value;
  final String text;
  final void Function(bool)? onChanged;

  const SettingsSwitch({
    super.key,
    required this.value,
    required this.text,
    this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return SwitchListTile(
      title: Text(
        text,
        style: TextStyle(
          color: value ? GColors.black : GColors.black.withValues(alpha: 0.7),
          fontSize: kSmallFontSize,
        ),
      ),
      value: value,
      tileColor: GColors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(kOuterRadius),
      ),
      onChanged: onChanged,
    );
  }
}
