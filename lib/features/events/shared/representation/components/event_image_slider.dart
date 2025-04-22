import 'package:cached_network_image/cached_network_image.dart';
import 'package:events_jo/config/packages/image%20slideshow/image_slideshow.dart';
import 'package:events_jo/config/utils/global_colors.dart';
import 'package:events_jo/features/location/domain/entities/ej_location.dart';
import 'package:events_jo/features/events/shared/domain/models/event.dart';
import 'package:events_jo/features/events/shared/representation/components/event_name_rating_and_location.dart';
import 'package:flutter/cupertino.dart';

class EventImageSlider extends StatelessWidget {
  final List<CachedNetworkImage> picsList;
  final Event? event;
  final EjLocation? eventLocation;

  const EventImageSlider({
    super.key,
    required this.picsList,
    required this.event,
    this.eventLocation,
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
        EventNameRatingAndLocation(
          event: event,
          eventLocation: eventLocation,
        ),
      ],
    );
  }
}
