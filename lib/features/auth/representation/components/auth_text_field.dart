import 'package:events_jo/config/utils/global_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class AuthTextField extends StatelessWidget {
  final TextEditingController controller;
  final String hintText;
  final bool obscureText;
  final TextAlign textAlign;
  final void Function(String)? onChanged;
  final Color textColor;
  final FontWeight fontWeight;
  final bool isOnlyDouble;
  final bool isOnlyInt;

  const AuthTextField({
    super.key,
    required this.controller,
    required this.hintText,
    required this.obscureText,
    this.onChanged,
    this.textAlign = TextAlign.start,
    this.textColor = Colors.black,
    this.fontWeight = FontWeight.normal,
    this.isOnlyDouble = false,
    this.isOnlyInt = false,
  });

  //todo focus node

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      obscureText: obscureText,
      onChanged: onChanged,
      style: TextStyle(
        color: textColor,
        fontSize: 17,
        fontWeight: fontWeight,
      ),
      textAlign: textAlign,
      keyboardType:
          // accepts only integers
          isOnlyInt
              ? TextInputType.number
              //accepts only doubles
              : isOnlyDouble
                  ? const TextInputType.numberWithOptions(decimal: true)
                  //accepts anything
                  : null,
      inputFormatters:
          // accepts only integers
          isOnlyInt
              ? [FilteringTextInputFormatter.digitsOnly]
              //accepts only doubles
              : isOnlyDouble
                  ? [
                      FilteringTextInputFormatter.allow(
                          RegExp(r'^(\d+)?\.?\d{0,2}'))
                    ]
                  //accepts anything
                  : null,
      decoration: InputDecoration(
        hintText: hintText,
        hintStyle: TextStyle(
          color: GColors.black,
          fontSize: 17,
        ),
        fillColor: GColors.white,
        filled: true,
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(
            color: GColors.whiteShade3,
          ),
          borderRadius: BorderRadius.circular(12),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: GColors.royalBlue, width: 1),
          borderRadius: BorderRadius.circular(12),
        ),
      ),
      cursorColor: GColors.royalBlue,
    );
  }
}
