import 'package:events_jo/config/utils/global_colors.dart';
import 'package:flutter/material.dart';

class SettingsDivider extends StatelessWidget {
  const SettingsDivider({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Divider(
      indent: 10,
      endIndent: 10,
      color: GColors.royalBlue,
      thickness: 0.5,
    );
  }
}
