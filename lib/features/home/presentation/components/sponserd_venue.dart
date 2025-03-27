import 'package:cached_network_image/cached_network_image.dart';
import 'package:events_jo/config/utils/constants.dart';
import 'package:events_jo/config/utils/global_colors.dart';
import 'package:events_jo/config/utils/loading/global_loading_image.dart';
import 'package:flutter/material.dart';

//todo this widget is fixed.
class SponserdVenue extends StatelessWidget {
  const SponserdVenue({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return FittedBox(
      child: Container(
        height: 150,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: GColors.logoGradientColors.reversed.toList(),
          ),
          borderRadius: BorderRadius.circular(kOuterRadius),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  SizedBox(
                    width: 110,
                    child: Text(
                      'Check Out Our Top Venue',
                      style: TextStyle(
                        color: GColors.white,
                        fontSize: kNormalFontSize,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  const Spacer(),
                  TextButton(
                    //todo
                    onPressed: () {},
                    child: Text(
                      'Reserve Now',
                      style: TextStyle(
                        color: GColors.black,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            ClipRRect(
              borderRadius: const BorderRadius.only(
                topRight: Radius.circular(kOuterRadius),
                bottomRight: Radius.circular(kOuterRadius),
              ),
              child: Stack(
                alignment: Alignment.centerRight,
                children: [
                  CachedNetworkImage(
                    imageUrl:
                        'https://res.cloudinary.com/ddixv6xdj/image/upload/v1731104239/mmoelwfwk66xxvpszsu5.jpg',
                    placeholder: (context, url) => const GlobalLoadingImage(),
                    errorWidget: (context, url, error) => Icon(
                      Icons.error_outline,
                      color: GColors.black,
                      size: 25,
                    ),
                    fit: BoxFit.cover,
                    height: 150,
                    width: 225,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(5),
                    child: Column(
                      spacing: 5,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        ...List.generate(
                          5,
                          (index) {
                            return Container(
                              width: 7,
                              height: 7,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(100),
                                color: index == 0
                                    ? GColors.royalBlue
                                    : GColors.white,
                              ),
                            );
                          },
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
