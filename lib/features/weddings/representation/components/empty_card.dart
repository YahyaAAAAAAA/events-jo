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
    return Container(
      width: MediaQuery.of(context).size.width,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: GColors.white,
        borderRadius: BorderRadius.circular(12),
      ),
      child: FittedBox(
        fit: BoxFit.scaleDown,
        child: Text(
          text,
          style: TextStyle(
            color: GColors.royalBlue,
            fontSize: 20,
          ),
        ),
      ),
    );
  }
}
