import 'dart:io';
import 'package:events_jo/config/utils/global_colors.dart';
import 'package:events_jo/features/owner/representation/components/dialogs/image_on_tap_dialog.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class ImageCard extends StatelessWidget {
  final List<XFile> images;
  final int index;
  const ImageCard({
    super.key,
    required this.images,
    required this.index,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(10),
      width: 100,
      height: 100,
      decoration: BoxDecoration(
        color: GColors.white,
        boxShadow: [
          BoxShadow(
            color: GColors.poloBlue.withOpacity(0.3),
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
                ImageOnTapDialog(images: images, index: index),
          ),
          child: Image.file(
            File(images[index].path),
            fit: BoxFit.cover,
          ),
        ),
      ),
    );
  }
}
