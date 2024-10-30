import 'package:events_jo/config/my_colors.dart';
import 'package:flutter/material.dart';

class AppBarButton extends StatelessWidget {
  final void Function()? onPressed;
  final IconData icon;
  final double size;
  const AppBarButton({
    super.key,
    required this.onPressed,
    required this.icon,
    required this.size,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
        left: 20,
        bottom: 10,
        right: 20,
        top: 10,
      ),
      child: SizedBox(
        width: 50,
        height: 50,
        child: ElevatedButton(
          onPressed: onPressed,
          style: ButtonStyle(
            fixedSize: const WidgetStatePropertyAll(Size.fromWidth(20)),
            padding: const WidgetStatePropertyAll(EdgeInsets.all(0)),
            backgroundColor: WidgetStatePropertyAll(MyColors.white),
            shadowColor: WidgetStatePropertyAll(
              MyColors.black.withOpacity(0.5),
            ),
            elevation: const WidgetStatePropertyAll(3),
            shape: WidgetStatePropertyAll(
              RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
          ),
          child: Icon(
            icon,
            color: MyColors.poloBlue,
            size: size,
          ),
        ),
      ),
    );
  }
}
