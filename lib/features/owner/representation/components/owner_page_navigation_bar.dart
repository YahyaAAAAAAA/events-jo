import 'package:events_jo/config/utils/my_colors.dart';
import 'package:flutter/material.dart';

class OwnerPageNavigationBar extends StatelessWidget {
  final void Function()? onPressedNext;
  final void Function()? onPressedBack;
  const OwnerPageNavigationBar({
    super.key,
    required this.onPressedNext,
    required this.onPressedBack,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            IconButton(
              onPressed: onPressedBack,
              style: ButtonStyle(
                  backgroundColor: WidgetStatePropertyAll(MyColors.royalBlue),
                  shadowColor: WidgetStatePropertyAll(
                    MyColors.black.withOpacity(0.5),
                  ),
                  elevation: const WidgetStatePropertyAll(3),
                  shape: WidgetStatePropertyAll(
                    RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  padding: const WidgetStatePropertyAll(EdgeInsets.zero)),
              icon: Ink(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    colors: MyColors.logoGradient,
                  ),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(15),
                  child: Icon(
                    Icons.arrow_back_ios_new_rounded,
                    size: 30,
                    color: MyColors.white,
                  ),
                ),
              ),
            ),
            const SizedBox(width: 10),
            Text(
              'Back',
              style: TextStyle(
                color: MyColors.royalBlue,
                fontSize: 25,
              ),
            ),
          ],
        ),
        Row(
          children: [
            Text(
              'Next',
              style: TextStyle(
                color: MyColors.royalBlue,
                fontSize: 25,
              ),
            ),
            const SizedBox(width: 10),
            IconButton(
              onPressed: onPressedNext,
              style: ButtonStyle(
                  backgroundColor: WidgetStatePropertyAll(MyColors.royalBlue),
                  shadowColor: WidgetStatePropertyAll(
                    MyColors.black.withOpacity(0.5),
                  ),
                  elevation: const WidgetStatePropertyAll(3),
                  shape: WidgetStatePropertyAll(
                    RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  padding: const WidgetStatePropertyAll(EdgeInsets.zero)),
              icon: Ink(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    colors: MyColors.logoGradient,
                  ),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(15),
                  child: Icon(
                    Icons.arrow_forward_ios_rounded,
                    size: 30,
                    color: MyColors.white,
                  ),
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
