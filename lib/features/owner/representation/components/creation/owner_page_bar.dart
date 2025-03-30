import 'package:events_jo/config/utils/global_colors.dart';
import 'package:events_jo/config/utils/gradient/gradient_text.dart';
import 'package:flutter/material.dart';

class OwnerPageBar extends StatelessWidget {
  const OwnerPageBar({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return FittedBox(
      fit: BoxFit.scaleDown,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          //* logo text
          GradientText(
            'Ej',
            gradient: GColors.logoGradient,
            style: TextStyle(
              color: GColors.royalBlue,
              fontSize: 80,
              fontFamily: 'Gugi',
              fontWeight: FontWeight.bold,
            ),
          ),

          //* logo text
          GradientText(
            'EventsJo for Owners',
            gradient: GColors.logoGradient,
            style: TextStyle(
              color: GColors.black,
              fontSize: 25,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}
