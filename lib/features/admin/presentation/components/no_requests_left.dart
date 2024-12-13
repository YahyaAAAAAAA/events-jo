import 'package:events_jo/config/utils/global_colors.dart';
import 'package:events_jo/config/utils/gradient/gradient_icon.dart';
import 'package:flutter/material.dart';

class NoRequestsLeft extends StatelessWidget {
  final String text;
  final IconData icon;
  const NoRequestsLeft({
    super.key,
    required this.icon,
    required this.text,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: ListView(
        shrinkWrap: true,
        children: [
          GradientIcon(
            icon: icon,
            gradient: GColors.adminGradient,
            size: 60,
          ),
          const SizedBox(height: 20),
          Center(
            child: Text(
              text,
              style: TextStyle(
                color: GColors.cyanShade6,
                fontSize: 20,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
