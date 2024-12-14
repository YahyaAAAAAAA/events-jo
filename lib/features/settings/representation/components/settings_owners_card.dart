import 'package:events_jo/config/utils/global_colors.dart';
import 'package:flutter/material.dart';
import 'package:mesh_gradient/mesh_gradient.dart';

class SettingsOwnersCard extends StatelessWidget {
  final AnimatedMeshGradientController controller;
  final List<Color> colors;
  final String text;
  final IconData icon;
  final double iconSize;
  final void Function()? onTap;

  const SettingsOwnersCard({
    super.key,
    required this.controller,
    required this.colors,
    required this.text,
    required this.icon,
    required this.iconSize,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
              color: colors[0].withOpacity(0.3),
              blurRadius: 20,
              offset: const Offset(0, 0),
            ),
          ],
          borderRadius: BorderRadius.circular(12),
          color: GColors.white,
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(12),
          child: AnimatedMeshGradient(
            colors: colors,
            controller: controller,
            options: AnimatedMeshGradientOptions(
              speed: 15,
            ),
            child: Padding(
              padding: const EdgeInsets.all(15),
              child: Row(
                children: [
                  Icon(
                    icon,
                    size: iconSize,
                    color: GColors.white,
                  ),
                  const SizedBox(width: 10),
                  Text(
                    text,
                    style: TextStyle(
                      color: GColors.white,
                      fontSize: 20,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
