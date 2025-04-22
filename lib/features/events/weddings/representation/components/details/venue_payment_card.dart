import 'package:events_jo/config/extensions/int_extensions.dart';
import 'package:events_jo/config/utils/constants.dart';
import 'package:events_jo/config/utils/global_colors.dart';
import 'package:flutter/material.dart';

class VenuePaymentCard extends StatelessWidget {
  final String title;
  final IconData icon;
  final String value;
  final String groupValue;
  final void Function()? onPressed;

  const VenuePaymentCard({
    super.key,
    required this.title,
    required this.value,
    required this.groupValue,
    required this.icon,
    this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 250,
      height: 40,
      child: IconButton(
        onPressed: onPressed,
        style: ButtonStyle(
          backgroundColor: const WidgetStatePropertyAll(Colors.transparent),
          side: WidgetStatePropertyAll(
            BorderSide(
              width: 0.2,
              color: GColors.black.withValues(alpha: 0.5),
            ),
          ),
        ),
        icon: Row(
          children: [
            Icon(
              icon,
              color: GColors.black,
              size: kNormalIconSize,
            ),
            5.width,
            Text(
              title,
              style: TextStyle(
                color: GColors.black,
                fontSize: kSmallFontSize,
              ),
            ),
            const Spacer(),
            Radio(
              value: value,
              groupValue: groupValue,
              fillColor: WidgetStatePropertyAll(GColors.black),
              onChanged: null,
            ),
          ],
        ),
      ),
    );
  }
}
