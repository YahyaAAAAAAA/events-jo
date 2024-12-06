import 'package:events_jo/config/utils/global_colors.dart';
import 'package:events_jo/features/admin/presentation/components/admin_button.dart';
import 'package:flutter/material.dart';

class AdminCard extends StatelessWidget {
  final String count;
  final String text;
  final IconData icon;
  final void Function()? onPressed;

  const AdminCard({
    super.key,
    required this.count,
    required this.text,
    required this.icon,
    required this.onPressed,
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
                icon,
                size: 40,
                color: GColors.cyanShade6,
              ),
              VerticalDivider(color: GColors.cyanShade6),
              Icon(
                Icons.circle,
                color: GColors.cyanShade6,
                size: 12,
              ),
              const SizedBox(width: 5),
              Text(
                text,
                style: TextStyle(
                  color: GColors.cyanShade6,
                  fontSize: 20,
                ),
              ),
              Text(
                count,
                style: TextStyle(
                  color: GColors.cyanShade6,
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const Spacer(),
              AdminButton(
                onPressed: onPressed,
                padding: EdgeInsets.zero,
                isLoading: false,
                buttonPadding:
                    const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
                icon: Icons.arrow_forward_ios_rounded,
              ),
            ],
          ),
        ));
  }
}
