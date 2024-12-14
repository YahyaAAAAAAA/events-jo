import 'package:events_jo/config/utils/global_colors.dart';
import 'package:flutter/material.dart';

class SettingsDivider extends StatelessWidget {
  final String text;

  const SettingsDivider({
    super.key,
    required this.text,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Divider(
            indent: 12,
            color: GColors.royalBlue,
          ),
        ),
        Text(
          text,
          style: TextStyle(
            color: GColors.royalBlue,
            fontSize: 17,
          ),
        ),
        Expanded(
          flex: 10,
          child: Divider(
            endIndent: 12,
            color: GColors.royalBlue,
          ),
        ),
      ],
    );
  }
}
