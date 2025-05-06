import 'package:events_jo/config/extensions/int_extensions.dart';
import 'package:events_jo/features/admin/presentation/components/admin_confirmation_display_row.dart';
import 'package:flutter/material.dart';

//* This page displays info for the user's event
class AdminUserSummary extends StatelessWidget {
  final String name;
  final String email;
  final String id;
  final void Function()? showMap;

  const AdminUserSummary({
    super.key,
    required this.name,
    required this.email,
    required this.id,
    this.showMap,
  });

  @override
  Widget build(BuildContext context) {
    return ConstrainedBox(
      constraints: const BoxConstraints(maxWidth: 450),
      child: ListView(
        children: [
          AdminConfirmationDisplayRow(mainText: 'Name: ', subText: name),

          localDivider(),

          //email
          AdminConfirmationDisplayRow(mainText: 'Email: ', subText: email),
          localDivider(),

          //id
          AdminConfirmationDisplayRow(mainText: 'Id: ', subText: id),
        ],
      ),
    );
  }

  Widget localDivider() {
    return 10.height;
  }
}
