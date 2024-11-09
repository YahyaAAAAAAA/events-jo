import 'package:events_jo/config/utils/custom_icons_icons.dart';
import 'package:events_jo/config/utils/global_colors.dart';
import 'package:events_jo/features/home/presentation/components/gradient_text.dart';
import 'package:events_jo/features/home/presentation/components/owner_button.dart';
import 'package:events_jo/features/owner/representation/components/image_card.dart';
import 'package:flutter/material.dart';
import 'package:gradient_icon/gradient_icon.dart';
import 'package:image_picker/image_picker.dart';

class SelectImages extends StatelessWidget {
  final List<XFile> images;
  final int selectedEventType;
  final void Function()? onPressed;

  const SelectImages({
    super.key,
    required this.images,
    required this.selectedEventType,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        GradientIcon(
          icon: CustomIcons.events_jo,
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            colors: GColors.logoGradient,
          ),
          size: 100,
        ),
        GradientText(
          'EventsJo for Owners',
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            colors: GColors.logoGradient,
          ),
          style: TextStyle(
            color: GColors.black,
            fontSize: 30,
            fontWeight: FontWeight.bold,
          ),
        ),
        images.isEmpty ? Spacer() : SizedBox(height: 20),
        OwnerButton(
          text: selectedEventType == 0
              ? 'Select images for your Venue'
              : selectedEventType == 1
                  ? 'Select images for your Farm'
                  : 'Select images for your Court',
          icon: Icons.image,
          fontSize: 20,
          iconSize: 40,
          padding: 20,
          fontWeight: FontWeight.bold,
          onPressed: onPressed,
        ),
        Expanded(
          child: GridView.builder(
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: 20,
              mainAxisSpacing: 20,
            ),
            itemCount: images.length,
            padding: EdgeInsets.all(20),
            itemBuilder: (context, index) => images.isNotEmpty
                ? ImageCard(images: images, index: index)
                : SizedBox(),
          ),
        ),
        images.isEmpty ? Spacer() : SizedBox(height: 0),
      ],
    );
  }
}
