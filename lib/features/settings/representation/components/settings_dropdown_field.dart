import 'package:events_jo/config/enums/user_type_enum.dart';
import 'package:events_jo/config/extensions/string_extensions.dart';
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
    return Material(
      shadowColor: GColors.black.withValues(alpha: 0.2),
      elevation: 3,
      borderRadius: BorderRadius.circular(12),
      child: DropdownButtonFormField(
        style: TextStyle(
          color: GColors.royalBlue,
          fontSize: 17,
        ),
        icon: Icon(
          Icons.arrow_drop_down,
          color: GColors.royalBlue,
          size: 30,
        ),
        dropdownColor: GColors.white,
        alignment: Alignment.center,
        decoration: InputDecoration(
          filled: true,
          fillColor: GColors.white,
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
        value: type,
        onChanged: onChanged,
        items: [UserType.user, UserType.owner].map((value) {
          return DropdownMenuItem(
            value: value,
            child: Row(
              children: [
                Icon(
                  value == UserType.user
                      ? Icons.person
                      : Icons.person_4_rounded,
                  color: GColors.royalBlue,
                  size: 25,
                ),
                const SizedBox(width: 10),
                Text(
                  value.name.toCapitalized,
                  style: TextStyle(
                    color: GColors.royalBlue,
                    fontSize: 17,
                    fontFamily: 'Abel',
                  ),
                ),
              ],
            ),
          );
        }).toList(),
      ),
    );
  }
}
