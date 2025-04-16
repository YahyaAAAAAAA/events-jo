import 'package:cached_network_image/cached_network_image.dart';
import 'package:events_jo/config/packages/image%20slideshow/image_slideshow.dart';
import 'package:events_jo/config/utils/global_colors.dart';
import 'package:events_jo/features/auth/domain/entities/app_user.dart';
import 'package:events_jo/features/location/domain/entities/ej_location.dart';
import 'package:events_jo/features/location/representation/cubits/location_cubit.dart';
import 'package:events_jo/features/weddings/domain/entities/wedding_venue.dart';
import 'package:events_jo/features/weddings/representation/components/details/venue_name_rating_and_location.dart';
import 'package:flutter/cupertino.dart';

class VenueImageSlider extends StatelessWidget {
  final List<CachedNetworkImage> picsList;
  final WeddingVenue? weddingVenue;
  final LocationCubit? locationCubit;
  final EjLocation? venueLocation;
  final AppUser user;

  const VenueImageSlider({
    super.key,
    required this.picsList,
    required this.weddingVenue,
    required this.user,
    this.locationCubit,
    this.venueLocation,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ClipRRect(
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(5),
            topRight: Radius.circular(5),
          ),
          child: ColoredBox(
            color: GColors.white,
            child: ImageSlideshow(
              width: double.infinity,
              height: 250,
              initialPage: 0,
              indicatorPadding: 10,
              indicatorBottomPadding: 20,
              indicatorRadius: 4,
              indicatorColor: GColors.royalBlue,
              indicatorBackgroundColor: GColors.white,
              autoPlayInterval: 3000,
              isLoop: true,
              children: picsList,
            ),
          ),
        ),
        VenueNameRatingAndLocation(
          weddingVenue: weddingVenue,
          locationCubit: locationCubit,
          venueLocation: venueLocation,
          user: user,
        ),
      ],
    );
  }
}
