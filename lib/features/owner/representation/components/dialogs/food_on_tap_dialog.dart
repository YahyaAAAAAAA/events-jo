import 'dart:ui';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:events_jo/config/utils/global_colors.dart';
import 'package:events_jo/config/utils/loading/global_loading_image.dart';
import 'package:flutter/material.dart';

class FoodOnTapDialog extends StatelessWidget {
  final String image;

  const FoodOnTapDialog({
    super.key,
    required this.image,
  });

  @override
  Widget build(BuildContext context) {
    return ClipRect(
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 10.0, sigmaY: 10.0),
        child: Scaffold(
          //close
          appBar: AppBar(
            leading: const SizedBox(),
            backgroundColor: Colors.transparent,
            title: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                IconButton(
                  onPressed: () => Navigator.of(context).pop(),
                  style: ButtonStyle(
                      shape: WidgetStatePropertyAll(RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12))),
                      padding: const WidgetStatePropertyAll(EdgeInsets.zero),
                      backgroundColor:
                          WidgetStatePropertyAll(GColors.royalBlue)),
                  icon: Ink(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                      gradient: GColors.logoGradient,
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Icon(
                        Icons.clear,
                        color: GColors.white,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          backgroundColor: Colors.transparent,
          //interactive image
          body: Center(
            child: InteractiveViewer(
              child: CachedNetworkImage(
                imageUrl: image,
                //waiting for image
                placeholder: (context, url) => const GlobalLoadingImage(),
                //error getting image
                errorWidget: (context, url, error) => SizedBox(
                  width: 100,
                  child: Icon(
                    Icons.error_outline,
                    color: GColors.black,
                    size: 40,
                  ),
                ),
                // fit: BoxFit.cover,
                // width: 70,
                // height: 70,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
