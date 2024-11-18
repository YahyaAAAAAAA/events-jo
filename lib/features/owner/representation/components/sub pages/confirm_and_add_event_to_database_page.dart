import 'package:events_jo/config/utils/custom_icons_icons.dart';
import 'package:events_jo/config/utils/global_colors.dart';
import 'package:events_jo/config/utils/gradient_text.dart';
import 'package:events_jo/features/home/presentation/components/owner_button.dart';
import 'package:events_jo/features/owner/representation/components/owner_confirmation_display_row.dart';
import 'package:events_jo/features/owner/representation/components/sub%20pages/select_range_time_page.dart';
import 'package:flutter/material.dart';
import 'package:gradient_icon/gradient_icon.dart';

//* This page displays info for the user's even
class ConfirmAndAddEventToDatabasePage extends StatelessWidget {
  final void Function()? onPressed;
  final void Function()? showMeals;
  final void Function()? showDrinks;
  final void Function()? showMap;
  final void Function()? showImages;
  final int selectedEventType;
  final TextEditingController nameController;
  final DateTimeRange? range;
  final List<int> time;
  final double peoplePrice;
  final int peopleMax;
  final int peopleMin;

  const ConfirmAndAddEventToDatabasePage({
    super.key,
    required this.onPressed,
    required this.selectedEventType,
    required this.nameController,
    required this.range,
    required this.time,
    required this.peopleMax,
    required this.peopleMin,
    required this.peoplePrice,
    this.showMap,
    this.showImages,
    this.showMeals,
    this.showDrinks,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: 400),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            GradientIcon(
              icon: CustomIcons.eventsjo,
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                colors: GColors.logoGradient,
              ),
              size: 100,
            ),

            GradientText(
              'EventsJo for Owners',
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                colors: GColors.logoGradient,
              ),
              style: TextStyle(
                color: GColors.black,
                fontSize: 30,
                fontWeight: FontWeight.bold,
              ),
            ),

            //add to db
            OwnerButton(
              fontSize: 20,
              fontWeight: FontWeight.normal,
              icon: Icons.done,
              iconSize: 50,
              padding: 8,
              text: selectedEventType == 0
                  ? 'Add Your Wedding Venue To EventsJo'
                  : selectedEventType == 1
                      ? 'Add Your Farm To EventsJo'
                      : 'Add Your Football Court To EventsJo',
              onPressed: onPressed,
            ),

            const SizedBox(height: 10),

            //confirm your information
            Align(
              alignment: Alignment.centerLeft,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: Text(
                  selectedEventType == 0
                      ? 'Please confirm your Wedding Venue information'
                      : selectedEventType == 1
                          ? 'Please confirm your Farm information'
                          : 'Please confirm your Football Court information',
                  style: TextStyle(
                    color: GColors.poloBlue,
                  ),
                ),
              ),
            ),
            //summary list
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(12),
                  child: ColoredBox(
                    color: GColors.white,
                    child: ListView(
                      children: [
                        //type
                        OwnerConfirmationDisplayRow(
                          mainText: 'Type: ',
                          subText: selectedEventType == 0
                              ? 'Wedding Venue'
                              : selectedEventType == 1
                                  ? 'Farm'
                                  : 'Football Court',
                        ),

                        localDivider(),

                        //name
                        OwnerConfirmationDisplayRow(
                            mainText: 'Name: ', subText: nameController.text),

                        localDivider(),

                        //date
                        OwnerConfirmationDisplayRow(
                            mainText: 'Date: ',
                            subText:
                                'From ${range!.start.month}/${range!.start.day}/${range!.start.year} - To ${range!.end.month}/${range!.end.day}/${range!.end.year}'),

                        localDivider(),

                        //time
                        OwnerConfirmationDisplayRow(
                            mainText: 'Open Hours: ',
                            subText:
                                'From ${time[0].toString().toTime} To ${time[1].toString().toTime}'),

                        localDivider(),

                        //people
                        OwnerConfirmationDisplayRow(
                            mainText: 'People Range: ',
                            subText:
                                'Between ${peopleMin.toString()} Person To ${peopleMax.toString()}'),

                        localDivider(),

                        //people
                        OwnerConfirmationDisplayRow(
                          mainText: 'Price Per Person: ',
                          subText: '${peoplePrice.toString()}JD',
                        ),

                        localDivider(),

                        //images
                        OwnerConfirmationDisplayRow(
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
                        OwnerConfirmationDisplayRow(
                          mainText: 'Images:   ',
                          isText: false,
                          subText: '',
                          icon: Icons.image,
                          onPressed: showImages,
                        ),

                        localDivider(),

                        //location
                        OwnerConfirmationDisplayRow(
                          mainText: 'Location: ',
                          isText: false,
                          subText: '',
                          onPressed: showMap,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),

            // const SizedBox(height: 10),
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
