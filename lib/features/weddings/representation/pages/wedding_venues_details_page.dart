import 'package:cached_network_image/cached_network_image.dart';
import 'package:events_jo/config/utils/custom_icons_icons.dart';
import 'package:events_jo/config/utils/global_colors.dart';
import 'package:events_jo/features/location/domain/entities/user_location.dart';
import 'package:events_jo/features/location/representation/cubits/location_cubit.dart';
import 'package:events_jo/features/weddings/domain/entities/wedding_venue.dart';
import 'package:events_jo/features/weddings/representation/components/details/image_slider.dart';
import 'package:events_jo/features/weddings/representation/components/details/name_rating_and_location.dart';
import 'package:events_jo/features/weddings/representation/components/details/venue_date_picker.dart';
import 'package:events_jo/features/weddings/representation/components/details/venue_time_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';

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

  double padding = 12;

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
              CustomIcons.menu,
              color: GColors.black,
              size: 20,
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
        padding: const EdgeInsets.all(12),
        child: ListView(
          children: [
            //* images slider
            ImageSlider(picsList: widget.picsList),

            const SizedBox(height: 20),

            //* name,rating and location
            NameRatingAndLocation(
              padding: padding,
              weddingVenue: weddingVenue,
              locationCubit: locationCubit,
              venueLocation: venueLocation,
            ),

            const SizedBox(height: 20),

            //* date
            venueText('Select the date you want to book'),
            VenueDatePicker(weddingVenue: weddingVenue),

            const SizedBox(height: 20),

            //* time
            venueText('Select the time for your venue'),
            VenueTimePicker(
              weddingVenue: weddingVenue,
              padding: padding,
              onChange: null,
            ),

            //specs (n of people , drinks , food,...etc)

            //payment

            //back and checkout
          ],
        ),
      ),
    );
  }

  Text venueText(String text) {
    return Text(
      text,
      style: TextStyle(
        fontSize: 17,
        color: GColors.poloBlue,
      ),
    );
  }
}
