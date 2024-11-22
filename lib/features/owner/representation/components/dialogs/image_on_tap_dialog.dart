import 'dart:io';
import 'dart:ui';
import 'package:events_jo/config/utils/global_colors.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class ImageOnTapDialog extends StatelessWidget {
  final List<XFile> images;
  final int index;
  final bool isWeb;

  const ImageOnTapDialog({
    super.key,
    required this.images,
    required this.index,
    required this.isWeb,
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
                      gradient: LinearGradient(
                        begin: Alignment.topLeft,
                        colors: GColors.logoGradient,
                      ),
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
          body: Container(
            width: double.infinity,
            height: double.infinity,
            child: InteractiveViewer(
              child: isWeb
                  ? Image.network(
                      images[index].path,
                      // fit: BoxFit.cover,
                    )
                  : Image.file(
                      File(
                        images[index].path,
                      ),
                      fit: BoxFit.contain,
                    ),
            ),
          ),
        ),
      ),
    );
  }
}
