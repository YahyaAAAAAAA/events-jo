import 'package:events_jo/config/extensions/string_extensions.dart';
import 'package:events_jo/config/utils/global_colors.dart';
import 'package:events_jo/config/utils/gradient/gradient_text.dart';
import 'package:events_jo/features/admin/presentation/components/admin_confirmation_display_row.dart';
import 'package:events_jo/features/admin/presentation/components/approved%20venues/admin_approved_venues_bar.dart';
import 'package:flutter/material.dart';

//* This page displays info for the user's event
class AdminApprovedVenueSummary extends StatelessWidget {
  final void Function()? showMeals;
  final void Function()? showDrinks;
  final void Function()? showMap;
  final void Function()? showImages;
  final void Function()? onSuspendPressed;
  final String venueName;
  final String ownerName;
  final DateTimeRange? range;
  final List<int> time;
  final double peoplePrice;
  final int peopleMax;
  final int peopleMin;

  const AdminApprovedVenueSummary({
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
    this.onSuspendPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: 450),
        child: ListView(
          children: [
            //* logo text
            Center(
              child: GradientText(
                'Ej',
                gradient: GColors.adminGradient,
                style: TextStyle(
                  color: GColors.royalBlue,
                  fontSize: 70,
                  fontFamily: 'Gugi',
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),

            //* owner's name
            Center(
              child: Text(
                '$ownerName\'s Venue Info',
                style: TextStyle(
                  color: GColors.cyanShade6,
                  fontSize: 25,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),

            //* confirm the information
            Align(
              alignment: Alignment.centerLeft,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 12),
                child: Text(
                  'Please check the Wedding Venue information',
                  style: TextStyle(
                    color: GColors.poloBlue,
                  ),
                ),
              ),
            ),

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
                    //type
                    const AdminConfirmationDisplayRow(
                      mainText: 'Type: ',
                      subText: 'Wedding Venue',
                    ),

                    localDivider(),

                    //name
                    AdminConfirmationDisplayRow(
                        mainText: 'Name: ', subText: venueName),

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
                      mainText: 'Images:   ',
                      isText: false,
                      subText: '',
                      icon: Icons.image,
                      onPressed: showImages,
                    ),

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

            //* bottom bar
            AdminApprovedVenuesBar(
              onSuspendPressed: onSuspendPressed,
            ),
          ],
        ),
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
