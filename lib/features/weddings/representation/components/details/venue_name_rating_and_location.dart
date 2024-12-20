import 'package:events_jo/config/utils/custom_icons_icons.dart';
import 'package:events_jo/config/utils/global_colors.dart';
import 'package:events_jo/config/utils/gradient/gradient_text.dart';
import 'package:events_jo/features/location/domain/entities/ej_location.dart';
import 'package:events_jo/features/location/representation/cubits/location_cubit.dart';
import 'package:events_jo/features/weddings/domain/entities/wedding_venue.dart';
import 'package:events_jo/features/weddings/representation/components/venue_rating.dart';
import 'package:events_jo/features/weddings/representation/components/venue_details_button.dart';
import 'package:flutter/material.dart';

class VenueNameRatingAndLocation extends StatelessWidget {
  const VenueNameRatingAndLocation({
    super.key,
    required this.weddingVenue,
    this.locationCubit,
    this.venueLocation,
  });

  final WeddingVenue weddingVenue;
  final LocationCubit? locationCubit;
  final EjLocation? venueLocation;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: GColors.white,
        borderRadius: const BorderRadius.only(
          bottomLeft: Radius.circular(12),
          bottomRight: Radius.circular(12),
        ),
      ),
      padding: const EdgeInsets.all(12),
      child: Wrap(
        alignment: WrapAlignment.spaceBetween,
        crossAxisAlignment: WrapCrossAlignment.center,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.max,
            children: [
              //venue name
              ConstrainedBox(
                constraints: const BoxConstraints(maxWidth: 290),
                child: FittedBox(
                  child: GradientText(
                    weddingVenue.name,
                    gradient: GColors.logoGradient,
                    style: TextStyle(
                      color: GColors.royalBlue,
                      fontSize: 28,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ),
              ),

              //rate
              VenueRating(weddingVenue: weddingVenue, size: 20),
            ],
          ),

          //location
          VenueDetailsButton(
            onPressed: () => locationCubit!
                .showMapDialogPreview(context, userLocation: venueLocation!),
            icon: CustomIcons.map_marker,
            iconSize: 30,
            padding: 18,
          ),
        ],
      ),
    );
  }
}
