import 'package:cached_network_image/cached_network_image.dart';
import 'package:events_jo/config/algorithms/ratings_utils.dart';
import 'package:events_jo/config/extensions/build_context_extenstions.dart';
import 'package:events_jo/config/extensions/color_extensions.dart';
import 'package:events_jo/config/utils/constants.dart';
import 'package:events_jo/config/utils/custom_icons_icons.dart';
import 'package:events_jo/config/utils/loading/global_loading_image.dart';
import 'package:events_jo/config/utils/global_colors.dart';
import 'package:events_jo/features/auth/domain/entities/app_user.dart';
import 'package:events_jo/features/events/shared/domain/models/football_court.dart';
import 'package:events_jo/features/events/courts/representation/pages/football_courts_details_page.dart';
import 'package:flutter/material.dart';

class CourtCard extends StatelessWidget {
  final AppUser? user;
  final FootballCourt footballCourt;

  const CourtCard({
    super.key,
    required this.user,
    required this.footballCourt,
  });

  @override
  Widget build(BuildContext context) {
    return FittedBox(
      fit: BoxFit.scaleDown,
      child: Container(
        height: 205,
        width: 160,
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
                    onTap: !footballCourt.isBeingApproved
                        ? () => context.push(
                              FootballCourtsDetailsPage(
                                user: user,
                                footballCourt: footballCourt,
                              ),
                            )
                        : () => context.showSnackBar(
                              'The court is being inspected by our team',
                            ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(kOuterRadius),
                      child: CachedNetworkImage(
                        imageUrl: footballCourt.pics.isEmpty
                            ? kPlaceholderImage
                            : footballCourt.pics[0],
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
                          color: GColors.whiteShade3.shade600,
                          borderRadius: BorderRadius.circular(kOuterRadius),
                        ),
                        child: Stack(
                          children: [
                            Align(
                              alignment: Alignment.center,
                              child: Text(
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                footballCourt.city.isNotEmpty
                                    ? '${calculateRatings(footballCourt.rates)['averageRate'].toDouble().toStringAsFixed(1)}'
                                    : 'CNF',
                                style: TextStyle(
                                  color: GColors.royalBlue,
                                  fontSize: kSmallFontSize,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                            Positioned(
                              top: 2,
                              left: 2,
                              child: Icon(
                                Icons.star_rate_rounded,
                                size: kSmallIconSize - 7,
                                color: GColors.royalBlue.withValues(alpha: 0.7),
                              ),
                            ),
                          ],
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
                        footballCourt.name.isNotEmpty
                            ? footballCourt.name
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
                            footballCourt.city.isNotEmpty
                                ? footballCourt.city
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
                  onPressed: !footballCourt.isBeingApproved
                      ? () => context.push(
                            FootballCourtsDetailsPage(
                              user: user,
                              footballCourt: footballCourt,
                            ),
                          )
                      : () => context.showSnackBar(
                            'The court is being inspected by our team',
                          ),
                  style: Theme.of(context).iconButtonTheme.style?.copyWith(
                        backgroundColor:
                            WidgetStatePropertyAll(GColors.royalBlue),
                      ),
                  icon: Icon(
                    !footballCourt.isBeingApproved
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
