import 'package:events_jo/config/utils/constants.dart';
import 'package:events_jo/config/utils/global_colors.dart';
import 'package:flutter/material.dart';

//* Used when a venue doesn't have meals or drinks.
class EmptyCard extends StatelessWidget {
  final String text;
  const EmptyCard({
    super.key,
    required this.text,
  });

  @override
  Widget build(BuildContext context) {
    return FittedBox(
      fit: BoxFit.scaleDown,
      alignment: Alignment.centerLeft,
      child: Container(
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: GColors.white,
          borderRadius: BorderRadius.circular(kOuterRadius),
        ),
        child: Text(
          text,
          style: TextStyle(
            color: GColors.black,
            fontSize: kSmallFontSize,
          ),
        ),
      ),
    );
  }
}
