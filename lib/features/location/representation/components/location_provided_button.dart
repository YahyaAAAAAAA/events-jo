import 'package:events_jo/config/utils/my_colors.dart';
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
            color: MyColors.poloBlue,
            borderRadius: BorderRadius.circular(12),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Spacer(flex: 2),
              Text(
                'Done',
                style: TextStyle(
                  color: MyColors.white,
                  fontSize: 22,
                ),
              ),
              const SizedBox(width: 10),
              Icon(
                Icons.check,
                color: MyColors.white,
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
                  backgroundColor: WidgetStatePropertyAll(MyColors.white),
                ),
                icon: Icon(
                  Icons.location_on_outlined,
                  color: MyColors.poloBlue,
                ),
              ),
            ],
          ),
        ),
        Text(
          'Click the button check or change the location.',
          style: TextStyle(
            fontSize: 13,
            color: MyColors.black,
          ),
        )
      ],
    );
  }
}
