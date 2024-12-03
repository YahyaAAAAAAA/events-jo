import 'dart:ui';
import 'package:events_jo/config/utils/global_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_image_slideshow/flutter_image_slideshow.dart';

class ImagesDialogPreview extends StatelessWidget {
  const ImagesDialogPreview({
    super.key,
    required this.images,
  });

  final List<Widget> images;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 10.0, sigmaY: 10.0),
        child: AlertDialog(
          contentPadding: const EdgeInsets.all(0),
          titlePadding: const EdgeInsets.only(bottom: 10),
          //close out of dialog
          title: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              IconButton(
                onPressed: () => Navigator.of(context).pop(),
                style: ButtonStyle(
                    shape: WidgetStatePropertyAll(RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12))),
                    padding: const WidgetStatePropertyAll(EdgeInsets.zero),
                    backgroundColor: WidgetStatePropertyAll(GColors.royalBlue)),
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
          backgroundColor: Colors.transparent,
          content: ClipRRect(
            borderRadius: BorderRadius.circular(12),
            child: SizedBox(
              width: 300,
              height: 300,
              child: ImageSlideshow(
                width: 300,
                height: 300,
                initialPage: 0,
                indicatorPadding: 10,
                indicatorBottomPadding: 20,
                indicatorRadius: 4,
                indicatorColor: GColors.royalBlue,
                indicatorBackgroundColor: GColors.poloBlue,
                children: images.isNotEmpty
                    ? images
                    :
                    //if no images selected
                    [
                        Center(
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(12),
                            child: ColoredBox(
                              color: GColors.white,
                              child: Padding(
                                padding: const EdgeInsets.all(20),
                                child: Text(
                                  'There are not any images',
                                  style: TextStyle(
                                    color: GColors.poloBlue,
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        )
                      ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
