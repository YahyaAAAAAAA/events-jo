import 'package:events_jo/config/utils/my_colors.dart';
import 'package:flutter/material.dart';

class ChangeUserTypeRow extends StatelessWidget {
  final bool isOwner;
  final void Function()? setUserType;
  final void Function()? setOwnerType;

  const ChangeUserTypeRow({
    super.key,
    required this.isOwner,
    required this.setUserType,
    required this.setOwnerType,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        TextButton(
          onPressed: setUserType,
          style: ButtonStyle(
            backgroundColor: WidgetStatePropertyAll(MyColors.white),
            shape: WidgetStatePropertyAll(
              RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
            padding: const WidgetStatePropertyAll(
              EdgeInsets.all(12),
            ),
          ),
          child: Icon(
            Icons.person,
            size: 30,
            color: isOwner ? MyColors.black : MyColors.royalBlue,
          ),
        ),
        const SizedBox(width: 10),
        TextButton(
          onPressed: setOwnerType,
          style: ButtonStyle(
            backgroundColor: WidgetStatePropertyAll(MyColors.white),
            shape: WidgetStatePropertyAll(
              RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
            padding: const WidgetStatePropertyAll(
              EdgeInsets.all(12),
            ),
          ),
          child: Icon(
            Icons.person_4,
            size: 30,
            color: isOwner ? MyColors.royalBlue : MyColors.black,
          ),
        ),
        const SizedBox(width: 10),
        Text(
          isOwner ? 'Owner Account' : 'User Account',
          style: const TextStyle(
            fontSize: 18,
          ),
        ),
      ],
    );
  }
}
