import 'package:events_jo/config/enums/user_type_enum.dart';
import 'package:events_jo/config/extensions/int_extensions.dart';
import 'package:events_jo/config/extensions/string_extensions.dart';
import 'package:events_jo/config/utils/constants.dart';
import 'package:events_jo/config/utils/global_colors.dart';
import 'package:flutter/material.dart';

class SettingsDropdownField extends StatelessWidget {
  final UserType type;
  final void Function(UserType?)? onChanged;

  const SettingsDropdownField({
    super.key,
    required this.type,
    this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField(
      elevation: 0,
      borderRadius: BorderRadius.circular(kOuterRadius),
      style: TextStyle(
        color: GColors.black,
        fontSize: kSmallFontSize,
      ),
      icon: Icon(
        Icons.arrow_drop_down,
        color: GColors.black,
        size: kNormalIconSize,
      ),
      dropdownColor: GColors.white,
      alignment: Alignment.center,
      decoration: InputDecoration(
        filled: true,
        fillColor: GColors.white,
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(kOuterRadius),
          borderSide: BorderSide(
            color: GColors.white,
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(kOuterRadius),
          borderSide: BorderSide(
            color: GColors.black,
          ),
        ),
      ),
      value: type,
      onChanged: onChanged,
      items: [UserType.user, UserType.owner].map((value) {
        return DropdownMenuItem(
          value: value,
          child: Row(
            children: [
              Icon(
                value == UserType.user ? Icons.person : Icons.person_4_rounded,
                color: GColors.black,
                size: kNormalIconSize,
              ),
              10.width,
              Text(
                value.name.toCapitalized,
                style: TextStyle(
                  color: GColors.black,
                  fontSize: kSmallFontSize,
                  fontFamily: 'Abel',
                ),
              ),
            ],
          ),
        );
      }).toList(),
    );
  }
}
