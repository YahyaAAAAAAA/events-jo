import 'package:cached_network_image/cached_network_image.dart';
import 'package:events_jo/config/utils/global_colors.dart';
import 'package:events_jo/config/utils/loading/global_loading_image.dart';
import 'package:flutter/material.dart';

class ImageCardPreview extends StatelessWidget {
  const ImageCardPreview({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5),
          border: Border.all(
            color: GColors.white,
            width: 12,
          )),
      //display preview image
      child: Padding(
        padding: const EdgeInsets.all(4),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(5),
          child: CachedNetworkImage(
            imageUrl: 'https://i.ibb.co/syL2vn2/unnamed.jpg',
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
            width: 100,
            height: 90,
          ),
        ),
      ),
    );
  }
}
