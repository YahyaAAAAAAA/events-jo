import 'package:cached_network_image/cached_network_image.dart';
import 'package:date_picker_plus/date_picker_plus.dart';
import 'package:events_jo/config/utils/custom_icons_icons.dart';
import 'package:events_jo/config/utils/global_colors.dart';
import 'package:events_jo/features/location/domain/entities/user_location.dart';
import 'package:events_jo/features/location/representation/cubits/location_cubit.dart';
import 'package:events_jo/features/owner/representation/components/time_picker.dart';
import 'package:events_jo/features/weddings/domain/entities/wedding_venue.dart';
import 'package:events_jo/features/weddings/representation/components/rating_venues.dart';
import 'package:events_jo/features/weddings/representation/components/venue_location_button.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_image_slideshow/flutter_image_slideshow.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:time_picker_spinner_pop_up/time_picker_spinner_pop_up.dart';

class WeddingVenuesDetailsPage extends StatefulWidget {
  final WeddingVenue weddingVenue;

  //request the pics for null safety
  final List<CachedNetworkImage> picsList;

  const WeddingVenuesDetailsPage({
    super.key,
    required this.weddingVenue,
    required this.picsList,
  });

  @override
  State<WeddingVenuesDetailsPage> createState() =>
      _WeddingVenuesDetailsPageState();
}

class _WeddingVenuesDetailsPageState extends State<WeddingVenuesDetailsPage> {
  late final WeddingVenue weddingVenue;
  late final LocationCubit locationCubit;
  late final UserLocation venueLocation;

  @override
  void initState() {
    super.initState();

    //get venue
    weddingVenue = widget.weddingVenue;

    //get location cubit
    locationCubit = context.read<LocationCubit>();

    //get venue location
    venueLocation = UserLocation(
      lat: double.parse(weddingVenue.latitude),
      long: double.parse(weddingVenue.longitude),
      initLat: double.parse(weddingVenue.latitude),
      initLong: double.parse(weddingVenue.longitude),
      marker: Marker(
        point: LatLng(
          double.parse(weddingVenue.latitude),
          double.parse(weddingVenue.longitude),
        ),
        child: Icon(
          Icons.location_pin,
          color: GColors.black,
        ),
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
    locationCubit.close();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //* title
      appBar: AppBar(
        title: FittedBox(
          child: Text(
            'Wedding Venue in Jordan',
            style: TextStyle(
              color: GColors.black,
            ),
          ),
        ),
        actions: [
          TextButton(
            onPressed: () {},
            child: Icon(
              Icons.report_problem_rounded,
              color: GColors.black,
            ),
          )
        ],
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back_ios_new,
            color: GColors.black,
          ),
          onPressed: () => Navigator.of(context).pop(),
        ),
        backgroundColor: Colors.transparent,
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(10),
        child: ListView(
          children: [
            //* images slider
            ClipRRect(
              borderRadius: BorderRadius.circular(5),
              child: ImageSlideshow(
                width: double.infinity,
                height: 300,
                initialPage: 0,
                indicatorPadding: 10,
                indicatorBottomPadding: 20,
                indicatorRadius: 4,
                indicatorColor: GColors.royalBlue,
                indicatorBackgroundColor: GColors.white,
                autoPlayInterval: 3000,
                isLoop: true,
                children: widget.picsList,
              ),
            ),

            //* name,rating and location
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      //name
                      Text(
                        weddingVenue.name,
                        style: TextStyle(
                          color: GColors.black,
                          fontSize: 28,
                        ),
                      ),

                      //rate
                      VenuesRating(weddingVenue: weddingVenue, size: 20),
                    ],
                  ),

                  //location
                  VenueLocationButton(
                    onPressed: () => locationCubit.showMapDialogPreview(context,
                        userLocation: venueLocation),
                    icon: CustomIcons.map,
                    iconSize: 30,
                    padding: 18,
                    fontWeight: FontWeight.normal,
                  ),
                ],
              ),
            ),

            //* date
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8),
              child: Text(
                'Select the date you want to book',
                style: TextStyle(
                  fontSize: 17,
                  color: GColors.poloBlue,
                ),
              ),
            ),
            SizedBox(
              width: MediaQuery.of(context).size.width,
              height: 320,
              child: DatePicker(
                minDate: DateTime(
                  weddingVenue.startDate[0],
                  weddingVenue.startDate[1],
                  weddingVenue.startDate[2],
                ),
                maxDate: DateTime(
                  weddingVenue.endDate[0],
                  weddingVenue.endDate[1],
                  weddingVenue.endDate[2],
                ),
                currentDateDecoration: BoxDecoration(
                  border: Border.all(
                    color: GColors.royalBlue,
                  ),
                  borderRadius: BorderRadius.circular(50),
                ),
                slidersColor: GColors.royalBlue,
                highlightColor: GColors.royalBlue.withOpacity(0.2),
                splashColor: GColors.royalBlue.withOpacity(0.2),
                selectedCellDecoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: GColors.logoGradient,
                  ),
                  borderRadius: BorderRadius.circular(100),
                ),
                daysOfTheWeekTextStyle: TextStyle(
                  color: GColors.poloBlue,
                ),
                leadingDateTextStyle: TextStyle(
                  color: GColors.royalBlue,
                  fontSize: 21,
                ),
              ),
            ),

            //* time
            TimePickerSpinnerPopUp(
              mode: CupertinoDatePickerMode.time,
              initTime: DateTime(0, 0, 0, DateTime.now().hour, 0),
              minTime: DateTime(weddingVenue.time[0]),
              maxTime: DateTime(weddingVenue.time[1]),

              minuteInterval: 30,
              textStyle: TextStyle(
                color: GColors.royalBlue,
              ),
              confirmTextStyle: TextStyle(
                color: GColors.royalBlue,
              ),
              cancelTextStyle: TextStyle(
                color: GColors.royalBlue,
              ),
              radius: 12,
              padding: const EdgeInsets.all(8),
              paddingHorizontalOverlay: BorderSide.strokeAlignCenter,
              use24hFormat: false,
              cancelText: 'Cancel',
              confirmText: 'OK',
              pressType: PressType.singlePress,
              timeFormat: 'dd/MM/yyyy',
              // Customize your time widget
              timeWidgetBuilder: (dateTime) {
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Select the time you want to book',
                        style: TextStyle(
                          fontSize: 17,
                          color: GColors.poloBlue,
                        ),
                      ),
                      //time
                      const VenueLocationButton(
                        onPressed: null,
                        icon: Icons.access_time_rounded,
                        iconSize: 30,
                        padding: 18,
                        fontWeight: FontWeight.normal,
                      ),
                    ],
                  ),
                );
              },
              onChange: (dateTime) {
                // Implement your logic with select dateTime
              },
            )

            //specs (n of people , drinks , food,...etc)

            //payment

            //back and checkout
          ],
        ),
      ),
    );
  }
}
