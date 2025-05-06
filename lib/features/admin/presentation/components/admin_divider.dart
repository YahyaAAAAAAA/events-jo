import 'package:events_jo/config/utils/constants.dart';
import 'package:events_jo/config/utils/global_colors.dart';
import 'package:flutter/material.dart';

class AdminDivider extends StatelessWidget {
  final String text;
  const AdminDivider({
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
            color: GColors.black,
          ),
        ),
        Text(
          text,
          style: TextStyle(
            color: GColors.black,
            fontSize: kSmallFontSize,
          ),
        ),
        Expanded(
          flex: 5,
          child: Divider(
            endIndent: 12,
            color: GColors.black,
          ),
        ),
      ],
    );
  }
}
