import 'package:events_jo/config/extensions/int_extensions.dart';
import 'package:events_jo/config/utils/constants.dart';
import 'package:events_jo/config/utils/custom_icons_icons.dart';
import 'package:events_jo/config/utils/global_colors.dart';
import 'package:events_jo/features/location/domain/entities/ej_location.dart';
import 'package:events_jo/features/location/representation/cubits/location_cubit.dart';
import 'package:events_jo/features/events/shared/domain/models/event.dart';
import 'package:events_jo/features/events/shared/representation/components/event_ratings.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class EventNameRatingAndLocation extends StatelessWidget {
  final Event? event;
  final EjLocation? eventLocation;

  const EventNameRatingAndLocation({
    super.key,
    required this.event,
    this.eventLocation,
  });

  @override
  Widget build(BuildContext context) {
    return MediaQuery.of(context).size.width >= 175
        ? Container(
            constraints: const BoxConstraints(minWidth: 362),
            decoration: BoxDecoration(
              color: GColors.white,
              borderRadius: const BorderRadius.only(
                bottomLeft: Radius.circular(12),
                bottomRight: Radius.circular(12),
              ),
            ),
            padding: const EdgeInsets.all(12),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    //venue name
                    Text(
                      event?.name ?? 'Event 123',
                      style: TextStyle(
                        color: GColors.black,
                        fontSize: kSmallFontSize,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    //rate
                    EventRating(
                      rates: event?.rates ?? [],
                    ),
                  ],
                ),

                //location
                IconButton(
                  onPressed: () => context
                      .read<LocationCubit>()
                      .showMapDialogPreview(context,
                          userLocation: eventLocation!),
                  icon: const Icon(
                    CustomIcons.map_marker,
                  ),
                ),
              ],
            ),
          )
        : 0.width;
  }
}
