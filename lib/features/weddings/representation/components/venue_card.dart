import 'package:cached_network_image/cached_network_image.dart';
import 'package:events_jo/config/utils/global_snack_bar.dart';
import 'package:events_jo/config/utils/loading/global_loading_image.dart';
import 'package:events_jo/config/utils/global_colors.dart';
import 'package:events_jo/features/auth/domain/entities/app_user.dart';
import 'package:events_jo/features/weddings/domain/entities/wedding_venue.dart';
import 'package:events_jo/features/weddings/representation/components/venue_rating.dart';
import 'package:events_jo/features/weddings/representation/pages/wedding_venues_details_page.dart';
import 'package:flutter/material.dart';

class VenueCard extends StatelessWidget {
  final AppUser? user;
  final WeddingVenue weddingVenue;
  final bool isLoading;

  const VenueCard({
    super.key,
    required this.user,
    required this.weddingVenue,
    required this.isLoading,
  });

  //todo move this to the cubit
  List<CachedNetworkImage> addPicsToList() {
    List<CachedNetworkImage> picsList = [];
    for (int i = 0; i < weddingVenue.pics.length; i++) {
      picsList.add(
        CachedNetworkImage(
          imageUrl: weddingVenue.pics[i],
          //waiting for image
          placeholder: (context, url) => const SizedBox(
            width: 100,
            child: GlobalLoadingImage(),
          ),
          //error getting image
          errorWidget: (context, url, error) => SizedBox(
            width: 100,
            child: Icon(
              Icons.error_outline,
              color: GColors.black,
              size: 40,
            ),
          ),
          fit: BoxFit.fill,
        ),
      );
    }
    return picsList;
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(15),
      child: MediaQuery.of(context).size.width > 270
          ? Row(
              children: [
                //* image
                Container(
                  height: 110,
                  width: 150,
                  padding: const EdgeInsets.all(6),
                  decoration: BoxDecoration(
                    color: GColors.white,
                    borderRadius: BorderRadius.circular(5),
                    boxShadow: [
                      BoxShadow(
                        color: GColors.poloBlue.withOpacity(0.3),
                        blurRadius: 10,
                        offset: const Offset(2, 2),
                      ),
                    ],
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(5),
                    //display preview image
                    child: CachedNetworkImage(
                      imageUrl: weddingVenue.pics[0],
                      //waiting for image
                      placeholder: (context, url) => const SizedBox(
                        width: 100,
                        child: GlobalLoadingImage(),
                      ),
                      //error getting image
                      errorWidget: (context, url, error) => SizedBox(
                        width: 100,
                        child: Icon(
                          Icons.error_outline,
                          color: GColors.black,
                          size: 40,
                        ),
                      ),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),

                //* details
                Expanded(
                  child: Container(
                    height: 100,
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: GColors.white,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        //* title
                        FittedBox(
                          fit: BoxFit.cover,
                          child: Text(
                            weddingVenue.name,
                            style: TextStyle(
                              color: GColors.black,
                              fontSize: 22,
                              overflow: TextOverflow.clip,
                            ),
                          ),
                        ),

                        //* available or not
                        FittedBox(
                          child: Row(
                            children: [
                              Icon(
                                Icons.circle,
                                color: weddingVenue.isOpen
                                    ? GColors.greenShade3
                                    : GColors.redShade3,
                                size: 13,
                              ),
                              const SizedBox(width: 5),
                              Text(
                                weddingVenue.isOpen ? "Available" : "Full",
                                style: TextStyle(
                                  color: GColors.black,
                                  fontSize: 15,
                                ),
                              ),
                            ],
                          ),
                        ),

                        //* rating
                        FittedBox(
                          child: VenueRating(
                            weddingVenue: weddingVenue,
                            size: 14,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),

                //* button
                Container(
                  height: 100,
                  decoration: BoxDecoration(
                    borderRadius: const BorderRadius.only(
                      bottomRight: Radius.circular(10),
                      topRight: Radius.circular(10),
                    ),
                    color: GColors.white,
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(15),
                    //navigate to details page
                    child: IconButton(
                      onPressed: !weddingVenue.isBeingApproved
                          ? () => Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) =>
                                      WeddingVenuesDetailsPage(
                                    weddingVenue: weddingVenue,
                                    user: user,
                                    picsList: addPicsToList(),
                                  ),
                                ),
                              )
                          : () => GSnackBar.show(
                                context: context,
                                text:
                                    'The venue is being inspected by our team',
                              ),
                      style: ButtonStyle(
                        backgroundColor: WidgetStatePropertyAll(GColors.white),
                        shadowColor: WidgetStatePropertyAll(
                          GColors.black.withOpacity(0.5),
                        ),
                        shape: WidgetStatePropertyAll(
                          RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                        padding: const WidgetStatePropertyAll(EdgeInsets.zero),
                      ),
                      icon: Ink(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12),
                          gradient: !isLoading ? GColors.logoGradient : null,
                        ),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                            vertical: 20,
                            horizontal: 15,
                          ),
                          child: Icon(
                            !weddingVenue.isBeingApproved
                                ? Icons.arrow_forward_ios
                                : Icons.lock_person_outlined,
                            color: GColors.white,
                          ),
                        ),
                      ),
                    ),
                  ),
                )
              ],
            )
          : const SizedBox(),
    );
  }
}
