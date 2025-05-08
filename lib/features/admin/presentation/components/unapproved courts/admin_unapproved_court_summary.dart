import 'package:events_jo/config/extensions/int_extensions.dart';
import 'package:events_jo/config/extensions/string_extensions.dart';
import 'package:events_jo/config/utils/constants.dart';
import 'package:events_jo/config/utils/custom_icons_icons.dart';
import 'package:events_jo/features/admin/presentation/components/admin_confirmation_display_row.dart';
import 'package:events_jo/features/admin/presentation/components/unapproved%20courts/admin_upapproved_court_bar.dart';
import 'package:flutter/material.dart';

//* This page displays info for the user's even
class UnapprovedAdminCourtSummary extends StatelessWidget {
  final void Function()? showMap;
  final void Function()? showLicense;
  final void Function()? showImages;
  final void Function()? onApprovePressed;
  final void Function()? onDenyPressed;
  final String courtName;
  final String ownerName;
  final List<int> time;
  final double peoplePrice;

  const UnapprovedAdminCourtSummary({
    super.key,
    required this.courtName,
    required this.ownerName,
    required this.time,
    required this.peoplePrice,
    this.showMap,
    this.showImages,
    this.onApprovePressed,
    this.showLicense,
    this.onDenyPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: kListViewWidth),
        child: ListView(
          children: [
            //* summary list
            const AdminConfirmationDisplayRow(
              mainText: 'Type: ',
              subText: 'Football Court',
            ),

            localDivider(),

            //name
            AdminConfirmationDisplayRow(mainText: 'Name: ', subText: courtName),

            localDivider(),

            //time
            AdminConfirmationDisplayRow(
                mainText: 'Open Hours: ',
                subText:
                    'From ${time[0].toString().toTime} To ${time[1].toString().toTime}'),

            localDivider(),

            //people
            AdminConfirmationDisplayRow(
              mainText: 'Price Per Hour: ',
              subText: '${peoplePrice.toString()}JD',
            ),

            localDivider(),

            //images
            AdminConfirmationDisplayRow(
              mainText: 'Images:    ',
              isText: false,
              subText: '',
              icon: Icons.image,
              onPressed: showImages,
            ),

            localDivider(),

            //license
            AdminConfirmationDisplayRow(
              mainText: 'License:   ',
              isText: false,
              subText: '',
              icon: CustomIcons.license,
              onPressed: showLicense,
            ),

            localDivider(),

            //location
            AdminConfirmationDisplayRow(
              mainText: 'Location:  ',
              isText: false,
              subText: '',
              onPressed: showMap,
            ),

            localDivider(),

            //* bottom bar
            AdminUnapprovedCourtBar(
              onApprovePressed: onApprovePressed,
              onDenyPressed: onDenyPressed,
            ),

            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

  Widget localDivider() {
    return 10.height;
  }
}
