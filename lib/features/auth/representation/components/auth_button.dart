import 'package:events_jo/config/my_colors.dart';
import 'package:flutter/material.dart';

class AuthButton extends StatelessWidget {
  final void Function()? onTap;
  final String text;
  final IconData icon;
  const AuthButton({
    super.key,
    required this.onTap,
    required this.text,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: MyColors.white,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: Center(
              child: Text(
                text,
                style: TextStyle(
                  fontSize: 21,
                  fontWeight: FontWeight.normal,
                  color: MyColors.black,
                ),
              ),
            ),
          ),
          IconButton(
            onPressed: onTap,
            style: ButtonStyle(
              shape: WidgetStateProperty.all<RoundedRectangleBorder>(
                RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              padding: const WidgetStatePropertyAll(EdgeInsets.all(0)),
              // backgroundColor: WidgetStatePropertyAll(MyColors.royalBlue),
            ),
            icon: Ink(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  colors: MyColors.logoGradient,
                ),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: Icon(
                  icon,
                  color: MyColors.whiteShade3,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
