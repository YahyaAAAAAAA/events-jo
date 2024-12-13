import 'package:events_jo/config/utils/global_colors.dart';
import 'package:events_jo/config/utils/gradient/gradient_icon.dart';
import 'package:events_jo/config/utils/gradient/gradient_text.dart';
import 'package:flutter/material.dart';

class AuthErrorCard extends StatelessWidget {
  const AuthErrorCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            GradientIcon(
              icon: Icons.error,
              gradient: GColors.logoGradient,
              size: 80,
            ),
            const SizedBox(height: 20),
            GradientText(
              'Error Occurred',
              gradient: GColors.logoGradientReversed,
              style: TextStyle(
                color: GColors.royalBlue,
                fontSize: 30,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
