import 'package:events_jo/config/extensions/int_extensions.dart';
import 'package:events_jo/config/extensions/string_extensions.dart';
import 'package:events_jo/config/utils/constants.dart';
import 'package:events_jo/config/utils/custom_icons_icons.dart';
import 'package:events_jo/features/admin/presentation/components/admin_confirmation_display_row.dart';
import 'package:events_jo/features/admin/presentation/components/unapproved%20venues/admin_upapproved_venues_bar.dart';
import 'package:flutter/material.dart';

//* This page displays info for the user's even
class UnapprovedAdminVenueSummary extends StatelessWidget {
  final void Function()? showMeals;
  final void Function()? showDrinks;
  final void Function()? showMap;
  final void Function()? showLicense;
  final void Function()? showImages;
  final void Function()? onApprovePressed;
  final void Function()? onDenyPressed;
  final String venueName;
  final String ownerName;
  final DateTimeRange? range;
  final List<int> time;
  final double peoplePrice;
  final int peopleMax;
  final int peopleMin;

  const UnapprovedAdminVenueSummary({
    super.key,
    required this.venueName,
    required this.ownerName,
    required this.range,
    required this.time,
    required this.peopleMax,
    required this.peopleMin,
    required this.peoplePrice,
    this.showMap,
    this.showImages,
    this.showMeals,
    this.showDrinks,
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
              subText: 'Wedding Venue',
            ),

            localDivider(),

            //name
            AdminConfirmationDisplayRow(mainText: 'Name: ', subText: venueName),

            localDivider(),

            //date
            AdminConfirmationDisplayRow(
                mainText: 'Date: ',
                subText:
                    'From ${range!.start.month}/${range!.start.day}/${range!.start.year} - To ${range!.end.month}/${range!.end.day}/${range!.end.year}'),

            localDivider(),

            //time
            AdminConfirmationDisplayRow(
                mainText: 'Open Hours: ',
                subText:
                    'From ${time[0].toString().toTime} To ${time[1].toString().toTime}'),

            localDivider(),

            //people
            AdminConfirmationDisplayRow(
                mainText: 'People Range: ',
                subText:
                    'Between ${peopleMin.toString()} Person To ${peopleMax.toString()}'),

            localDivider(),

            //people
            AdminConfirmationDisplayRow(
              mainText: 'Price Per Person: ',
              subText: '${peoplePrice.toString()}JD',
            ),

            localDivider(),

            //images
            AdminConfirmationDisplayRow(
              mainText: 'Meals & Drinks: ',
              isText: false,
              subText: '',
              icon: Icons.cake_rounded,
              withSecondIcon: true,
              secondIcon: Icons.free_breakfast,
              onPressed: showMeals,
              onPressedSecondIcon: showDrinks,
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
            AdminUnapprovedVenuesBar(
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
