import 'package:cached_network_image/cached_network_image.dart';
import 'package:events_jo/config/utils/global_colors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_image_slideshow/flutter_image_slideshow.dart';

class VenueImageSlider extends StatelessWidget {
  final List<CachedNetworkImage> picsList;

  const VenueImageSlider({
    super.key,
    required this.picsList,
  });

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: const BorderRadius.only(
        topLeft: Radius.circular(5),
        topRight: Radius.circular(5),
      ),
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
        children: picsList,
      ),
    );
  }
}
