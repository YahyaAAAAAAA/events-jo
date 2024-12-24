import 'package:events_jo/config/utils/gradient/gradient_icon.dart';
import 'package:flutter/material.dart';

class EmptyList extends StatelessWidget {
  final String text;
  final IconData icon;
  final Gradient gradient;
  final Color color;

  const EmptyList({
    super.key,
    required this.icon,
    required this.text,
    required this.gradient,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: ListView(
        shrinkWrap: true,
        children: [
          GradientIcon(
            icon: icon,
            gradient: gradient,
            size: 60,
          ),
          const SizedBox(height: 20),
          Center(
            child: Text(
              text,
              style: TextStyle(
                color: color,
                fontSize: 20,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
