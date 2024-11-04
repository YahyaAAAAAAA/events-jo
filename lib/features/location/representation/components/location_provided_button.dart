import 'package:events_jo/config/utils/global_colors.dart';
import 'package:flutter/material.dart';

class LocationProvided extends StatelessWidget {
  final void Function()? onPressed;
  const LocationProvided({
    super.key,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: GColors.poloBlue,
            borderRadius: BorderRadius.circular(12),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Spacer(flex: 2),
              Text(
                'Done',
                style: TextStyle(
                  color: GColors.white,
                  fontSize: 22,
                ),
              ),
              const SizedBox(width: 10),
              Icon(
                Icons.check,
                color: GColors.white,
              ),
              const Spacer(),
              IconButton(
                onPressed: onPressed,
                style: ButtonStyle(
                  shape: WidgetStateProperty.all<RoundedRectangleBorder>(
                    RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  padding: const WidgetStatePropertyAll(EdgeInsets.all(20)),
                  backgroundColor: WidgetStatePropertyAll(GColors.white),
                ),
                icon: Icon(
                  Icons.location_on_outlined,
                  color: GColors.poloBlue,
                ),
              ),
            ],
          ),
        ),
        Text(
          'Click the button check or change the location.',
          style: TextStyle(
            fontSize: 13,
            color: GColors.black,
          ),
        )
      ],
    );
  }
}
