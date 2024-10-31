import 'package:events_jo/config/utils/my_colors.dart';
import 'package:flutter/material.dart';

class OwnerButton extends StatelessWidget {
  final void Function()? onPressed;
  const OwnerButton({
    super.key,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            'Add Your Venue,Farm or Court',
            style: TextStyle(
              color: MyColors.poloBlue,
              fontSize: 17,
            ),
          ),
          const SizedBox(height: 5),
          IconButton(
            onPressed: onPressed,
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
                padding: const EdgeInsets.all(8.0),
                child: Icon(
                  Icons.add,
                  size: 50,
                  color: MyColors.white,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
