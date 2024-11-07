import 'package:cached_network_image/cached_network_image.dart';
import 'package:events_jo/config/utils/global_colors.dart';
import 'package:events_jo/features/weddings/domain/entities/wedding_venue.dart';
import 'package:flutter/material.dart';
import 'package:flutter_image_slideshow/flutter_image_slideshow.dart';

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

  @override
  void initState() {
    super.initState();
    weddingVenue = widget.weddingVenue;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Wedding Venue in Jordan',
          style: TextStyle(
            color: GColors.black,
          ),
        ),
        actions: [
          TextButton(
            onPressed: () {},
            child: Icon(
              Icons.report_problem_rounded,
              color: GColors.black,
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
        padding: const EdgeInsets.all(10),
        child: Column(
          children: [
            //images slideshow
            ClipRRect(
              borderRadius: BorderRadius.circular(5),
              child: ImageSlideshow(
                width: double.infinity,
                height: 300,
                initialPage: 0,
                indicatorPadding: 10,
                indicatorBottomPadding: 20,
                indicatorRadius: 4,
                indicatorColor: GColors.royalBlue,
                indicatorBackgroundColor: GColors.white,
                autoPlayInterval: 3000,
                isLoop: true,
                children: widget.picsList,
              ),
            ),
            //name and rating
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    weddingVenue.name,
                    style: TextStyle(
                      color: GColors.black,
                      fontSize: 28,
                    ),
                  ),
                  // VenuesRating(weddingVenue: weddingVenue, size: 20),
                  // Container(
                  //   child:  Lottie.asset('name')
                  // ),
                ],
              ),
            ),
            //todo address and map

            //specs (schedule,n of people , drinks , food,...etc)

            //payment

            //back and checkout
          ],
        ),
      ),
    );
  }
}
