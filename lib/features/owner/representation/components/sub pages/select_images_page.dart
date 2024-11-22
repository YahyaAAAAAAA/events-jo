import 'package:carousel_slider/carousel_slider.dart';
import 'package:events_jo/config/utils/custom_icons_icons.dart';
import 'package:events_jo/config/utils/global_colors.dart';
import 'package:events_jo/config/utils/gradient_text.dart';
import 'package:events_jo/features/home/presentation/components/owner_button.dart';
import 'package:events_jo/features/owner/representation/components/image_card.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:gradient_icon/gradient_icon.dart';
import 'package:image_picker/image_picker.dart';

//* This page lets the user select images for their event (NOT REQUIRED)
//if empty a placeholder image will be displayed instead
class SelectImagesPage extends StatelessWidget {
  final List<XFile> images;
  final int selectedEventType;
  final void Function()? onPressed;

  const SelectImagesPage({
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
        //logo icon
        GradientIcon(
          icon: CustomIcons.eventsjo,
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            colors: GColors.logoGradient,
          ),
          size: 100,
        ),

        //logo text
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

        const Spacer(),

        //images button
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

        images.isEmpty ? const SizedBox() : const SizedBox(height: 20),

        //images slider
        images.isNotEmpty
            ? CarouselSlider.builder(
                itemCount: images.length,
                itemBuilder: (context, index, realIndex) => images.isNotEmpty
                    ? ImageCard(images: images, index: index, isWeb: kIsWeb)
                    : const SizedBox(),
                //responsive height
                options: CarouselOptions(
                  height: MediaQuery.of(context).size.height > 693
                      ? 250
                      : MediaQuery.of(context).size.height > 643
                          ? 200
                          : MediaQuery.of(context).size.height > 595
                              ? 150
                              : 0,
                  enlargeFactor: 1,
                  enlargeCenterPage: true,
                  enlargeStrategy: CenterPageEnlargeStrategy.height,
                  autoPlay: false,
                ),
              )
            : const SizedBox(),

        const Spacer(flex: 2),
      ],
    );
  }
}
