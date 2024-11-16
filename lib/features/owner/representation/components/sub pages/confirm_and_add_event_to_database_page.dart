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
  final void Function()? showMap;
  final void Function()? showImages;
  final int selectedEventType;
  final TextEditingController nameController;
  final DateTimeRange? range;
  final List<int> time;

  const ConfirmAndAddEventToDatabasePage({
    super.key,
    required this.onPressed,
    required this.selectedEventType,
    required this.nameController,
    required this.range,
    required this.time,
    this.showMap,
    this.showImages,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
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

        const Spacer(),

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

        localDivider(),

        const Spacer(flex: 2),

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

        const Spacer(),
      ],
    );
  }

  Divider localDivider() {
    return const Divider(
      // color: GColors.poloBlue,
      height: 0.1,
      indent: 10,
      endIndent: 10,
    );
  }
}
