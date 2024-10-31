import 'package:cached_network_image/cached_network_image.dart';
import 'package:events_jo/config/utils/my_colors.dart';
import 'package:events_jo/features/weddings/domain/entities/wedding_venue.dart';
import 'package:events_jo/features/weddings/representation/components/rating_venues.dart';
import 'package:flutter/material.dart';
import 'package:flutter_image_slideshow/flutter_image_slideshow.dart';
import 'package:lottie/lottie.dart';

class WeddingVenuesDetailesPage extends StatefulWidget {
  final WeddingVenue weddingVenue;

  //request the pics for null safety
  final List<CachedNetworkImage> picsList;

  const WeddingVenuesDetailesPage({
    super.key,
    required this.weddingVenue,
    required this.picsList,
  });

  @override
  State<WeddingVenuesDetailesPage> createState() =>
      _WeddingVenuesDetailesPageState();
}

class _WeddingVenuesDetailesPageState extends State<WeddingVenuesDetailesPage> {
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
            color: MyColors.black,
          ),
        ),
        actions: [
          TextButton(
            onPressed: () {},
            child: Icon(
              Icons.report_problem_rounded,
              color: MyColors.black,
            ),
          )
        ],
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back_ios_new,
            color: MyColors.black,
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
                indicatorColor: MyColors.royalBlue,
                indicatorBackgroundColor: MyColors.white,
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
                      color: MyColors.black,
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
