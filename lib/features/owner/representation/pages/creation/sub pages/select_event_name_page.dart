import 'package:events_jo/config/enums/event_type.dart';
import 'package:events_jo/config/extensions/color_extensions.dart';
import 'package:events_jo/config/extensions/int_extensions.dart';
import 'package:events_jo/config/extensions/string_extensions.dart';
import 'package:events_jo/config/utils/constants.dart';
import 'package:events_jo/config/utils/global_colors.dart';
import 'package:events_jo/features/auth/representation/components/auth_text_field.dart';
import 'package:flutter/material.dart';

//* This page lets the user to pick a name for their event (REQUIRED)
class SelectEventNamePage extends StatelessWidget {
  final EventType eventType;
  final TextEditingController nameController;
  final void Function()? testPress;

  const SelectEventNamePage({
    super.key,
    required this.eventType,
    required this.nameController,
    this.testPress,
  });

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: null,
      icon: Row(
        children: [
          IconButton(
            onPressed: testPress,
            style: ButtonStyle(
              backgroundColor:
                  WidgetStatePropertyAll(GColors.whiteShade3.shade600),
              shape: WidgetStatePropertyAll(
                RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(kOuterRadius)),
              ),
            ),
            icon: Icon(
              Icons.edit_outlined,
              color: GColors.royalBlue,
              size: kSmallIconSize + 5,
            ),
          ),
          10.width,
          Text(
            'Your ${eventType.name.toCapitalized} Name: ',
            style: TextStyle(
              color: GColors.black,
              fontSize: kSmallFontSize,
            ),
          ),
          20.width,
          Expanded(
            child: AuthTextField(
              controller: nameController,
              hintText: 'Name Here',
              textColor: GColors.black,
              enabledColor: GColors.black.withValues(alpha: 0.3),
              fontWeight: FontWeight.normal,
              maxLength: 25,
            ),
          ),
        ],
      ),
    );
  }
}
