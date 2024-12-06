import 'package:events_jo/config/utils/global_colors.dart';
import 'package:flutter/material.dart';
import 'package:gradient_icon/gradient_icon.dart';

class NoRequestsLeft extends StatefulWidget {
  final String text;
  final IconData icon;
  const NoRequestsLeft({
    super.key,
    required this.icon,
    required this.text,
  });

  @override
  State<NoRequestsLeft> createState() => _NoRequestsLeftState();
}

class _NoRequestsLeftState extends State<NoRequestsLeft> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: ListView(
        shrinkWrap: true,
        children: [
          GradientIcon(
            icon: widget.icon,
            gradient: GColors.adminGradient,
            size: 60,
          ),
          const SizedBox(height: 20),
          Center(
            child: Text(
              widget.text,
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
