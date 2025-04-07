import 'dart:io';
import 'package:events_jo/config/enums/event_type.dart';
import 'package:events_jo/config/extensions/build_context_extenstions.dart';
import 'package:events_jo/config/extensions/color_extensions.dart';
import 'package:events_jo/config/extensions/string_extensions.dart';
import 'package:events_jo/config/utils/constants.dart';
import 'package:events_jo/config/utils/custom_icons_icons.dart';
import 'package:events_jo/config/utils/global_colors.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class SelectLicensePage extends StatelessWidget {
  final List<XFile> images;
  final EventType eventType;
  final void Function()? onPressed;

  const SelectLicensePage({
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
              CustomIcons.license,
              color: GColors.royalBlue,
              size: kSmallIconSize + 5,
            ),
          ),
          Text(
            'Your ${eventType.name.toCapitalized} License',
            style: TextStyle(
              color: GColors.black,
              fontSize: kSmallFontSize,
            ),
          ),
          const Spacer(),
          images.isNotEmpty
              ? IconButton(
                  onPressed: () => context.dialog(
                    pageBuilder: (context, _, __) => AlertDialog(
                      content: SizedBox(
                        width: 300,
                        height: 300,
                        child: ListView.builder(
                          itemCount: images.length,
                          itemBuilder: (context, index) {
                            return ClipRRect(
                              borderRadius: BorderRadius.circular(kOuterRadius),
                              child: Image.file(
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
                    Icons.image_search,
                    color: GColors.white,
                    size: kSmallIconSize + 5,
                  ),
                )
              : IconButton(
                  onPressed: null,
                  style: ButtonStyle(
                    backgroundColor: WidgetStatePropertyAll(GColors.royalBlue),
                    shape: WidgetStatePropertyAll(
                      RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(kOuterRadius)),
                    ),
                  ),
                  icon: Icon(
                    Icons.image_not_supported_outlined,
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
