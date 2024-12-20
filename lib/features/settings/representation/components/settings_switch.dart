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
          color: value ? GColors.royalBlue : GColors.poloBlue,
          fontSize: 17,
        ),
      ),
      value: value,
      activeColor: GColors.royalBlue,
      activeTrackColor: GColors.whiteShade3,
      inactiveThumbColor: GColors.poloBlue,
      inactiveTrackColor: GColors.whiteShade3,
      trackOutlineColor: value
          ? WidgetStatePropertyAll(GColors.royalBlue)
          : WidgetStatePropertyAll(GColors.poloBlue),
      tileColor: GColors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      onChanged: onChanged,
    );
  }
}
