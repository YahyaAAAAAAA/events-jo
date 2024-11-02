import 'package:cached_network_image/cached_network_image.dart';
import 'package:events_jo/config/utils/image_loading_indicator.dart';
import 'package:events_jo/config/utils/global_colors.dart';
import 'package:events_jo/features/weddings/domain/entities/wedding_venue.dart';
import 'package:events_jo/features/weddings/representation/components/rating_venues.dart';
import 'package:events_jo/features/weddings/representation/pages/wedding_venues_detailes_page.dart';
import 'package:flutter/material.dart';

class WeddingVenueCard extends StatelessWidget {
  final WeddingVenue weddingVenue;
  const WeddingVenueCard({
    super.key,
    required this.weddingVenue,
  });

  //dev move this to the cubit
  List<CachedNetworkImage> addPicsToList() {
    List<CachedNetworkImage> picsList = [];
    for (int i = 0; i < weddingVenue.pics.length; i++) {
      picsList.add(CachedNetworkImage(
        imageUrl: weddingVenue.pics[i],
        //waiting for image
        placeholder: (context, url) => const SizedBox(
          width: 100,
          child: ImageLoadingIndicator(),
        ),
        //error getting image
        errorWidget: (context, url, error) => SizedBox(
          width: 100,
          child: Icon(
            Icons.error_outline,
            color: GlobalColors.black,
            size: 40,
          ),
        ),
        fit: BoxFit.fill,
      ));
    }
    return picsList;
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(15),
      child: Row(
        children: [
          //* image
          Container(
            height: 110,
            padding: const EdgeInsets.all(6),
            decoration: BoxDecoration(
              color: GlobalColors.white,
              borderRadius: BorderRadius.circular(5),
              //dev might change later
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.1),
                  blurRadius: 20,
                  offset: const Offset(2, 2),
                ),
              ],
            ),
            // width: 100,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(5),
              //display preview image
              child: CachedNetworkImage(
                imageUrl: weddingVenue.pics[0],
                //waiting for image
                placeholder: (context, url) => const SizedBox(
                  width: 100,
                  child: ImageLoadingIndicator(),
                ),
                //error getting image
                errorWidget: (context, url, error) => SizedBox(
                  width: 100,
                  child: Icon(
                    Icons.error_outline,
                    color: GlobalColors.black,
                    size: 40,
                  ),
                ),
                fit: BoxFit.scaleDown,
              ),
            ),
          ),

          //* details
          Expanded(
            child: Container(
              height: 100,
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: GlobalColors.white,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  //* title
                  FittedBox(
                    fit: BoxFit.fill,
                    child: Text(
                      weddingVenue.name,
                      style: TextStyle(
                        color: GlobalColors.black,
                        fontSize: 22,
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
                              ? GlobalColors.greenShade3
                              : GlobalColors.redShade3,
                          size: 13,
                        ),
                        const SizedBox(width: 5),
                        Text(
                          weddingVenue.isOpen ? "Available" : "Full",
                          style: TextStyle(
                            color: GlobalColors.black,
                            fontSize: 15,
                          ),
                        ),
                      ],
                    ),
                  ),
                  //* rating
                  FittedBox(
                    child: VenuesRating(
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
              color: GlobalColors.white,
            ),
            child: Padding(
              padding: const EdgeInsets.all(15),
              //navigate to details page
              child: TextButton(
                onPressed: () => Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => WeddingVenuesDetailesPage(
                      weddingVenue: weddingVenue,
                      picsList: addPicsToList(),
                    ),
                  ),
                ),
                style: ButtonStyle(
                  shape: WidgetStatePropertyAll(
                    RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  backgroundColor:
                      WidgetStatePropertyAll(GlobalColors.royalBlue),
                ),
                child: Icon(
                  Icons.arrow_forward_ios,
                  color: GlobalColors.white,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
