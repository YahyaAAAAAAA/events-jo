import 'package:events_jo/config/extensions/build_context_extenstions.dart';
import 'package:events_jo/config/extensions/color_extensions.dart';
import 'package:events_jo/config/extensions/int_extensions.dart';
import 'package:events_jo/config/utils/constants.dart';
import 'package:events_jo/config/utils/custom_icons_icons.dart';
import 'package:events_jo/config/utils/global_colors.dart';
import 'package:events_jo/features/events/shared/domain/models/event.dart';
import 'package:events_jo/features/events/shared/domain/models/wedding_venue.dart';
import 'package:flutter/material.dart';

class OwnerEventsCard extends StatelessWidget {
  final Event? event;
  final void Function()? onEditPressed;
  final void Function()? onOrdersPressed;

  const OwnerEventsCard({
    super.key,
    required this.event,
    this.onEditPressed,
    this.onOrdersPressed,
  });

  @override
  Widget build(BuildContext context) {
    return IconButton(
        onPressed: null,
        icon: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              spacing: 10,
              children: [
                Container(
                  decoration: BoxDecoration(
                    color: GColors.whiteShade3.shade600,
                    borderRadius: BorderRadius.circular(kOuterRadius),
                  ),
                  padding: const EdgeInsets.all(12),
                  child: Icon(
                    event is WeddingVenue
                        ? CustomIcons.wedding
                        : CustomIcons.football_1,
                    size: kNormalIconSize,
                    color: GColors.royalBlue,
                  ),
                ),
                Text(
                  event == null ? 'Venue 123' : event!.name,
                  style: TextStyle(
                    color: GColors.black,
                    fontSize: kNormalFontSize,
                  ),
                ),
              ],
            ),
            event == null
                ? 0.width
                : !event!.isBeingApproved && event!.isApproved
                    ? Row(
                        spacing: 10,
                        children: [
                          IconButton(
                            onPressed: onOrdersPressed,
                            style: ButtonStyle(
                              backgroundColor:
                                  WidgetStatePropertyAll(GColors.royalBlue),
                            ),
                            icon: Icon(
                              CustomIcons.list,
                              color: GColors.white,
                              size: kSmallIconSize,
                            ),
                          ),
                          IconButton(
                            onPressed: onEditPressed,
                            style: ButtonStyle(
                              backgroundColor:
                                  WidgetStatePropertyAll(GColors.royalBlue),
                            ),
                            icon: Icon(
                              Icons.edit_rounded,
                              color: GColors.white,
                              size: kSmallIconSize,
                            ),
                          ),
                        ],
                      )
                    : IconButton(
                        onPressed: () => context.showSnackBar(
                            'The event is being reviewed by our team'),
                        style: ButtonStyle(
                          backgroundColor: WidgetStatePropertyAll(
                            GColors.royalBlue,
                          ),
                        ),
                        icon: Icon(
                          Icons.lock_person_rounded,
                          color: GColors.white,
                          size: kSmallIconSize,
                        ),
                      ),
          ],
        ));
  }
}
