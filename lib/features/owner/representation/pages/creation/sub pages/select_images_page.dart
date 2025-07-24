import 'dart:io';
import 'package:events_jo/config/enums/event_type.dart';
import 'package:events_jo/config/extensions/build_context_extenstions.dart';
import 'package:events_jo/config/extensions/color_extensions.dart';
import 'package:events_jo/config/extensions/string_extensions.dart';
import 'package:events_jo/config/packages/image%20slideshow/image_slideshow.dart';
import 'package:events_jo/config/utils/constants.dart';
import 'package:events_jo/config/utils/global_colors.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

//* This page lets the user select images for their event (NOT REQUIRED)
//if empty a placeholder image will be displayed instead
class SelectImagesPage extends StatelessWidget {
  final List<XFile> images;
  final EventType eventType;
  final void Function()? onPressed;

  const SelectImagesPage({
    super.key,
    required this.images,
    required this.eventType,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: onPressed,
      icon: Row(
        spacing: 10,
        children: [
          IconButton(
            onPressed: null,
            style: ButtonStyle(
              backgroundColor:
                  WidgetStatePropertyAll(GColors.whiteShade3.shade600),
              shape: WidgetStatePropertyAll(
                RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(kOuterRadius)),
              ),
            ),
            icon: Icon(
              Icons.image_outlined,
              color: GColors.royalBlue,
              size: kSmallIconSize + 5,
            ),
          ),
          Text(
            'Your ${eventType.name.toCapitalized} Images',
            style: TextStyle(
              color: GColors.black,
              fontSize: kSmallFontSize,
            ),
          ),
          const Spacer(),
          IconButton(
            onPressed: images.isEmpty
                ? null
                : () => context.dialog(
                      pageBuilder: (context, _, __) => AlertDialog(
                        content: ImageSlideshow(
                          width: 300,
                          height: 300,
                          children: List.generate(
                            images.length,
                            (index) {
                              return ClipRRect(
                                borderRadius:
                                    BorderRadius.circular(kOuterRadius),
                                child: kIsWeb
                                    ? Image.network(
                                        images[index].path,
                                        fit: BoxFit.contain,
                                      )
                                    : Image.file(
                                        File(images[index].path),
                                        fit: BoxFit.contain,
                                      ),
                              );
                            },
                          ),
                        ),
                      ),
                    ),
            style: ButtonStyle(
              backgroundColor: WidgetStatePropertyAll(GColors.royalBlue),
              shape: WidgetStatePropertyAll(
                RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(kOuterRadius)),
              ),
            ),
            icon: Icon(
              images.isEmpty
                  ? Icons.image_not_supported_outlined
                  : Icons.image_search,
              color: GColors.white,
              size: kSmallIconSize + 5,
            ),
          ),
          IconButton(
            onPressed: onPressed,
            style: ButtonStyle(
              backgroundColor: WidgetStatePropertyAll(GColors.royalBlue),
              shape: WidgetStatePropertyAll(
                RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(kOuterRadius)),
              ),
            ),
            icon: Icon(
              Icons.arrow_forward_ios_rounded,
              color: GColors.white,
              size: kSmallIconSize + 5,
            ),
          ),
        ],
      ),
    );
  }
}
