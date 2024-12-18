import 'package:events_jo/config/enums/user_type_enum.dart';
import 'package:events_jo/config/utils/global_colors.dart';
import 'package:flutter/material.dart';

class ChangeUserTypeRow extends StatelessWidget {
  final UserType type;
  final void Function(UserType)? onSelected;

  const ChangeUserTypeRow({
    super.key,
    required this.type,
    required this.onSelected,
  });

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerLeft,
      child: PopupMenuButton(
        icon: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text(
              'Join As',
              style: TextStyle(
                fontSize: 18,
                overflow: TextOverflow.clip,
              ),
            ),
            Icon(
              Icons.arrow_drop_down_sharp,
              color: GColors.black,
              size: 35,
            ),
          ],
        ),
        style: ButtonStyle(
          backgroundColor: WidgetStatePropertyAll(GColors.white),
          padding: const WidgetStatePropertyAll(
            EdgeInsets.all(12),
          ),
          shape: WidgetStatePropertyAll(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
          ),
        ),
        color: GColors.white,
        onSelected: onSelected,
        tooltip: '',
        enableFeedback: false,
        initialValue: type,
        position: PopupMenuPosition.under,
        itemBuilder: (context) {
          return [
            PopupMenuItem(
              value: UserType.user,
              child: Row(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Icon(
                    Icons.person,
                    color: GColors.black,
                    size: 25,
                  ),
                  const SizedBox(width: 10),
                  Text(
                    'User',
                    style: TextStyle(
                      color: GColors.black,
                      fontSize: 15,
                    ),
                  ),
                ],
              ),
            ),
            PopupMenuItem(
              value: UserType.owner,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(
                    Icons.person_4_rounded,
                    color: GColors.black,
                    size: 25,
                  ),
                  const SizedBox(width: 10),
                  Text(
                    'Owner',
                    style: TextStyle(
                      color: GColors.black,
                      fontSize: 15,
                    ),
                  ),
                ],
              ),
            ),
          ];
        },
      ),
    );
  }
}
