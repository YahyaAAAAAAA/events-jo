import 'package:events_jo/config/utils/global_colors.dart';
import 'package:flutter/material.dart';

class AdminErrorCard extends StatelessWidget {
  final String messege;

  const AdminErrorCard({
    super.key,
    required this.messege,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          border: Border(
            left: BorderSide(
              color: GColors.cyanShade6,
              width: 10,
            ),
          ),
          borderRadius: BorderRadius.circular(12),
          color: GColors.white,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.error,
              color: GColors.cyanShade6,
              size: 20,
            ),
            const SizedBox(width: 5),
            Text(
              messege,
              style: TextStyle(
                color: GColors.cyanShade6,
                fontSize: 20,
              ),
            ),
          ],
        ));
  }
}
