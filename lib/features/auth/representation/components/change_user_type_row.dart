import 'package:events_jo/config/enums/user_type_enum.dart';
import 'package:events_jo/config/utils/constants.dart';
import 'package:events_jo/config/utils/global_colors.dart';
import 'package:flutter/material.dart';

class ChangeUserTypeRow extends StatelessWidget {
  final UserType type;
  final void Function(UserType)? onSelected;
  final void Function()? onRandomPress;

  const ChangeUserTypeRow({
    super.key,
    required this.type,
    required this.onSelected,
    this.onRandomPress,
  });

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerLeft,
      child: Wrap(
        spacing: 10,
        runSpacing: 10,
        children: [
          PopupMenuButton(
            icon: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Text(
                  'Join As',
                  style: TextStyle(
                    fontSize: kSmallFontSize,
                    overflow: TextOverflow.clip,
                  ),
                ),
                Icon(
                  Icons.arrow_drop_down_sharp,
                  color: GColors.black,
                  size: kSmallIconSize,
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
          IconButton(
            onPressed: onRandomPress,
            style: ButtonStyle(
              backgroundColor: WidgetStatePropertyAll(GColors.white),
            ),
            padding: const EdgeInsets.all(12),
            icon: Row(
              spacing: 5,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  'Fill Info',
                  style: TextStyle(
                    color: GColors.black,
                    fontSize: kSmallFontSize,
                  ),
                ),
                Icon(
                  Icons.shuffle_rounded,
                  color: GColors.black,
                  size: kSmallIconSize,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
