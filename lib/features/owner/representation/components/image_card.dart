import 'dart:io';
import 'package:events_jo/config/utils/global_colors.dart';
import 'package:events_jo/features/owner/representation/components/dialogs/image_on_tap_dialog.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class ImageCard extends StatelessWidget {
  final List<XFile> images;
  final int index;
  final bool isWeb;

  const ImageCard({
    super.key,
    required this.images,
    required this.index,
    required this.isWeb,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10),
      width: 250,
      height: 100,
      decoration: BoxDecoration(
        color: GColors.white,
        boxShadow: [
          BoxShadow(
            color: GColors.poloBlue.withValues(alpha: 0.3),
            blurRadius: 7,
            offset: const Offset(0, 4),
          )
        ],
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          colors: GColors.imageCardGradient,
        ),
        borderRadius: BorderRadius.circular(22),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(12),
        child: GestureDetector(
          onTap: () => showDialog(
            context: context,
            builder: (context) =>
                ImageOnTapDialog(images: images, index: index, isWeb: isWeb),
          ),
          //* image.file not supported on the web
          child: isWeb
              ? Image.network(
                  images[index].path,
                  fit: BoxFit.cover,
                )
              : Image.file(
                  File(images[index].path),
                  fit: BoxFit.cover,
                ),
        ),
      ),
    );
  }
}
