import 'package:events_jo/config/enums/text_field_input_type.dart';
import 'package:events_jo/config/utils/global_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class AuthTextField extends StatelessWidget {
  final TextEditingController controller;
  final String hintText;
  final bool obscureText;

  final void Function(String)? onChanged;

  final TextAlign? textAlign;
  final Color? textColor;
  final FontWeight? fontWeight;
  final int? maxLength;
  final BorderRadius? borderRadius;
  final double? elevation;

  final TextFieldInputType? inputType;

  const AuthTextField({
    super.key,
    required this.controller,
    required this.hintText,
    required this.obscureText,
    this.onChanged,
    this.borderRadius,
    this.elevation,
    this.textAlign,
    this.textColor,
    this.fontWeight,
    this.maxLength,
    this.inputType,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      shadowColor: GColors.black.withValues(alpha: 0.2),
      elevation: elevation ?? 0,
      borderRadius: BorderRadius.circular(12),
      child: TextField(
        controller: controller,
        obscureText: obscureText,
        onChanged: onChanged,
        maxLength: maxLength ?? null,
        style: TextStyle(
          color: textColor ?? GColors.black,
          fontSize: 17,
          fontWeight: fontWeight ?? FontWeight.normal,
        ),
        textAlign: textAlign ?? TextAlign.start,
        keyboardType:
            // accepts only integers
            inputType == TextFieldInputType.integers
                ? TextInputType.number
                //accepts only doubles
                : inputType == TextFieldInputType.doubles
                    ? const TextInputType.numberWithOptions(decimal: true)
                    //accepts anything
                    : null,
        inputFormatters:
            // accepts only integers
            inputType == TextFieldInputType.integers
                ? [FilteringTextInputFormatter.digitsOnly]
                //accepts only doubles
                : inputType == TextFieldInputType.doubles
                    ? [
                        FilteringTextInputFormatter.allow(
                            RegExp(r'^(\d+)?\.?\d{0,2}'))
                      ]
                    //accepts anything
                    : null,
        decoration: InputDecoration(
          hintText: hintText,
          //note: hides maxLength counter
          counterText: "",
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
            borderRadius: borderRadius ?? BorderRadius.circular(12),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: GColors.royalBlue, width: 1),
            borderRadius: BorderRadius.circular(12),
          ),
        ),
        cursorColor: GColors.royalBlue,
      ),
    );
  }
}
