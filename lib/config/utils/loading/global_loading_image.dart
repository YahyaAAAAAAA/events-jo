import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class GlobalLoadingImage extends StatelessWidget {
  const GlobalLoadingImage({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Lottie.asset(
        'assets/animations/image.json',
        frameRate: const FrameRate(60),
        fit: BoxFit.contain,
      ),
    );
  }
}
