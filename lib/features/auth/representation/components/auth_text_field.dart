import 'package:events_jo/config/utils/my_colors.dart';
import 'package:flutter/material.dart';

class AuthTextField extends StatelessWidget {
  final TextEditingController controller;
  final String hintText;
  final bool obscureText;
  final void Function(String)? onChanged;
  const AuthTextField({
    super.key,
    required this.controller,
    required this.hintText,
    required this.obscureText,
    this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      obscureText: obscureText,
      onChanged: onChanged,
      style: TextStyle(
        color: MyColors.black,
        fontSize: 17,
      ),
      decoration: InputDecoration(
        hintText: hintText,
        hintStyle: TextStyle(
          color: MyColors.black,
          fontSize: 17,
        ),
        fillColor: MyColors.white,
        filled: true,
        disabledBorder: OutlineInputBorder(
          borderSide: BorderSide(
            color: MyColors.whiteShade3,
          ),
          borderRadius: BorderRadius.circular(12),
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(
            color: MyColors.whiteShade3,
          ),
          borderRadius: BorderRadius.circular(12),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(
            color: MyColors.black,
          ),
          borderRadius: BorderRadius.circular(12),
        ),
      ),
    );
  }
}
