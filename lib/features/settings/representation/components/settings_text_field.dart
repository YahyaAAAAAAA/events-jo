import 'package:events_jo/config/utils/global_colors.dart';
import 'package:flutter/material.dart';

class SettingsTextField extends StatelessWidget {
  final String? initialValue;
  final String? hintText;
  final int? maxLines;
  final void Function(String)? onChanged;
  final bool isObscure;
  final TextEditingController? controller;

  const SettingsTextField({
    super.key,
    this.initialValue,
    this.hintText,
    this.onChanged,
    this.isObscure = false,
    this.controller,
    this.maxLines,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      shadowColor: GColors.black.withValues(alpha: 0.2),
      elevation: 3,
      borderRadius: BorderRadius.circular(12),
      child: TextFormField(
        controller: controller,
        obscureText: isObscure,
        maxLines: maxLines ?? 1,
        style: TextStyle(
          color: GColors.royalBlue,
          fontSize: 17,
        ),
        decoration: InputDecoration(
          filled: true,
          fillColor: GColors.white,
          hintText: hintText,
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide(
              color: GColors.white,
            ),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide(
              color: GColors.royalBlue,
            ),
          ),
        ),
        initialValue: initialValue,
        onChanged: onChanged,
      ),
    );
  }
}
