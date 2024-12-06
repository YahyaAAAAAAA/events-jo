import 'package:events_jo/config/utils/global_colors.dart';
import 'package:flutter/material.dart';

class AdminHomeCard extends StatelessWidget {
  final String count;
  final String text;
  final IconData icon;

  const AdminHomeCard({
    super.key,
    required this.count,
    required this.text,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12),
      decoration: BoxDecoration(
        border: Border(
          left: BorderSide(
            color: GColors.cyanShade6,
            width: 10,
          ),
        ),
        boxShadow: [
          BoxShadow(
            color: GColors.cyan.withOpacity(0.2),
            blurRadius: 7,
            offset: const Offset(0, 0),
          ),
        ],
        borderRadius: BorderRadius.circular(12),
        color: GColors.white,
      ),
      child: IntrinsicHeight(
        child: Row(
          children: [
            Icon(
              Icons.circle,
              size: 12,
              color: GColors.cyanShade6,
            ),
            const SizedBox(width: 10),
            Text(
              text,
              style: TextStyle(
                color: GColors.cyanShade6,
                fontSize: 20,
              ),
            ),
            const Spacer(),
            CircleAvatar(
              backgroundColor: GColors.cyanShade6,
              child: Text(
                count, //todo add +9 maybe ?
                style: TextStyle(
                  color: GColors.white,
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            const Spacer(),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 12),
              child: VerticalDivider(color: GColors.cyanShade6),
            ),
            SizedBox(
              width: 70,
              height: 100,
              child: Icon(
                icon,
                size: 35,
                color: GColors.cyanShade6,
              ),
            )
          ],
        ),
      ),
    );
  }
}
