import 'package:events_jo/config/utils/custom_icons_icons.dart';
import 'package:events_jo/config/utils/global_colors.dart';
import 'package:events_jo/features/admin/presentation/components/admin_confirmation_display_row.dart';
import 'package:flutter/material.dart';
import 'package:gradient_icon/gradient_icon.dart';

//* This page displays info for the user's event
class AdminOwnerSummary extends StatelessWidget {
  final String name;
  final String email;
  final String id;
  final void Function()? showMap;

  const AdminOwnerSummary({
    super.key,
    required this.name,
    required this.email,
    required this.id,
    this.showMap,
  });

  @override
  Widget build(BuildContext context) {
    return ConstrainedBox(
      constraints: const BoxConstraints(maxWidth: 450), //todo comeback
      child: ListView(
        shrinkWrap: true,
        children: [
          //* logo icon
          GradientIcon(
            icon: CustomIcons.eventsjo,
            gradient: GColors.adminGradient,
            size: 100,
          ),

          //* users name
          Center(
            child: Text(
              '$name\'s User Info',
              style: TextStyle(
                color: GColors.cyanShade6,
                fontSize: 30,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),

          const SizedBox(height: 10),

          //* summary list
          Padding(
            padding: const EdgeInsets.all(8),
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                color: GColors.white,
                boxShadow: [
                  BoxShadow(
                    color: GColors.cyan.withOpacity(0.2),
                    blurRadius: 7,
                    offset: const Offset(0, 0),
                  ),
                ],
              ),
              child: ListView(
                shrinkWrap: true,
                children: [
                  //name
                  AdminConfirmationDisplayRow(
                      mainText: 'Name: ', subText: name),

                  localDivider(),

                  //email
                  AdminConfirmationDisplayRow(
                      mainText: 'Email: ', subText: email),
                  localDivider(),

                  //id
                  AdminConfirmationDisplayRow(mainText: 'Id: ', subText: id),

                  localDivider(),

                  //location
                  AdminConfirmationDisplayRow(
                    mainText: 'Location: ',
                    isText: false,
                    subText: '',
                    onPressed: showMap,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Divider localDivider() {
    return Divider(
      color: GColors.poloBlue,
      height: 0.01,
      thickness: 0.2,
      indent: 10,
      endIndent: 10,
    );
  }
}
