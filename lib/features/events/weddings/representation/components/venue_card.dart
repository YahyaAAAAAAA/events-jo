import 'package:cached_network_image/cached_network_image.dart';
import 'package:events_jo/config/extensions/build_context_extenstions.dart';
import 'package:events_jo/config/extensions/color_extensions.dart';
import 'package:events_jo/config/utils/constants.dart';
import 'package:events_jo/config/utils/custom_icons_icons.dart';
import 'package:events_jo/config/utils/loading/global_loading_image.dart';
import 'package:events_jo/config/utils/global_colors.dart';
import 'package:events_jo/features/auth/domain/entities/app_user.dart';
import 'package:events_jo/features/events/shared/domain/models/wedding_venue.dart';
import 'package:events_jo/features/events/weddings/representation/pages/wedding_venues_details_page.dart';
import 'package:flutter/material.dart';

class VenueCard extends StatelessWidget {
  final AppUser? user;
  final WeddingVenue weddingVenue;

  const VenueCard({
    super.key,
    required this.user,
    required this.weddingVenue,
  });

  @override
  Widget build(BuildContext context) {
    return FittedBox(
      fit: BoxFit.scaleDown,
      child: Container(
        height: 200,
        width: 150,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          spacing: 5,
          children: [
            //* image
            Container(
              height: 150,
              width: 150,
              padding: const EdgeInsets.all(6),
              decoration: BoxDecoration(
                color: GColors.white,
                borderRadius: BorderRadius.circular(kOuterRadius),
              ),
              child: Stack(
                children: [
                  InkWell(
                    onTap: !weddingVenue.isBeingApproved
                        ? () => context.push(
                              WeddingVenuesDetailsPage(
                                weddingVenue: weddingVenue,
                                user: user,
                              ),
                            )
                        : () => context.showSnackBar(
                              'The venue is being inspected by our team',
                            ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(kOuterRadius),
                      child: CachedNetworkImage(
                        imageUrl: weddingVenue.pics[0],
                        placeholder: (context, url) =>
                            const GlobalLoadingImage(),
                        errorWidget: (context, url, error) => Icon(
                          Icons.error_outline,
                          color: GColors.black,
                          size: 40,
                        ),
                        fit: BoxFit.cover,
                        width: 150,
                        height: 150,
                      ),
                    ),
                  ),
                  Positioned(
                    top: -1,
                    right: -1,
                    child: Container(
                      padding: const EdgeInsets.all(4),
                      decoration: BoxDecoration(
                        color: GColors.white,
                        borderRadius: const BorderRadius.only(
                          bottomLeft: Radius.circular(kOuterRadius),
                        ),
                      ),
                      child: Container(
                        width: 35,
                        height: 35,
                        decoration: BoxDecoration(
                          color: GColors.white.shade600,
                          borderRadius: BorderRadius.circular(kOuterRadius),
                        ),
                        child: Icon(
                          Icons.favorite_border_outlined,
                          size: kSmallIconSize,
                          color: GColors.royalBlue,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            //* details
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    //* name
                    SizedBox(
                      //for overflow
                      width: 105,
                      child: Text(
                        weddingVenue.name.isNotEmpty
                            ? weddingVenue.name
                            : 'NNF',
                        maxLines: 1,
                        style: TextStyle(
                          color: GColors.black,
                          fontSize: kSmallFontSize,
                          fontWeight: FontWeight.bold,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ),
                    //* city
                    Row(
                      spacing: 2,
                      children: [
                        Icon(
                          CustomIcons.map_marker,
                          color: GColors.black,
                          size: kSmallIconSize,
                        ),
                        SizedBox(
                          //for overflow
                          width: 90,
                          child: Text(
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            weddingVenue.city.isNotEmpty
                                ? weddingVenue.city
                                : 'CNF',
                            style: TextStyle(
                              color: GColors.black,
                              fontSize: kSmallFontSize,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                IconButton(
                  onPressed: !weddingVenue.isBeingApproved
                      ? () => context.push(
                            WeddingVenuesDetailsPage(
                              weddingVenue: weddingVenue,
                              user: user,
                            ),
                          )
                      : () => context.showSnackBar(
                            'The venue is being inspected by our team',
                          ),
                  style: Theme.of(context).iconButtonTheme.style?.copyWith(
                        backgroundColor:
                            WidgetStatePropertyAll(GColors.royalBlue),
                      ),
                  icon: Icon(
                    !weddingVenue.isBeingApproved
                        ? Icons.arrow_forward_ios_rounded
                        : Icons.lock_person_outlined,
                    color: GColors.white,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
