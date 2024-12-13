import 'package:events_jo/config/utils/global_colors.dart';
import 'package:flutter/material.dart';
import 'package:mesh_gradient/mesh_gradient.dart';

class HomeCard extends StatelessWidget {
  final AnimatedMeshGradientController controller;
  final List<Color> colors;
  final IconData icon;
  final String text;
  final void Function()? onPressed;

  const HomeCard({
    super.key,
    required this.controller,
    required this.colors,
    required this.icon,
    required this.text,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      // width: 210,
      height: 120,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: colors[0].withOpacity(0.3),
            blurRadius: 20,
            offset: const Offset(0, 0),
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(20),
        child: AnimatedMeshGradient(
          colors: colors,
          controller: controller,
          options: AnimatedMeshGradientOptions(
            speed: 15,
          ),
          child: Padding(
            padding: const EdgeInsets.only(top: 20, left: 20, right: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    DecoratedBox(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(16),
                        border: Border.all(
                          width: 1,
                          color: GColors.white,
                        ),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(12),
                        child: Icon(
                          icon,
                          color: GColors.white,
                          size: 25,
                        ),
                      ),
                    ),
                    const SizedBox(width: 5),
                    Text(
                      text,
                      style: TextStyle(
                        color: GColors.white,
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
                IconButton(
                  onPressed: onPressed,
                  icon: Icon(
                    Icons.arrow_forward_ios_rounded,
                    color: GColors.white,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
