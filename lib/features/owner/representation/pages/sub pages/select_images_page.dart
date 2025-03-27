// import 'package:carousel_slider/carousel_slider.dart';
import 'package:events_jo/config/enums/event_type.dart';
import 'package:events_jo/features/owner/representation/components/owner_button.dart';
// import 'package:events_jo/features/owner/representation/components/image_card.dart';
import 'package:events_jo/features/owner/representation/components/owner_page_bar.dart';
// import 'package:flutter/foundation.dart';
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
    return Center(
      child: ListView(
        children: [
          const OwnerPageBar(),

          images.isEmpty
              ? const SizedBox(height: 100)
              : const SizedBox(height: 30),

          //images button
          OwnerButton(
            text: eventType == EventType.venue
                ? 'Select images for your Venue'
                : eventType == EventType.farm
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
              ? const Text('removed carousel slider temp')
              // ? CarouselSlider.builder(
              //     itemCount: images.length,
              //     itemBuilder: (context, index, realIndex) => images.isNotEmpty
              //         ? ImageCard(images: images, index: index, isWeb: kIsWeb)
              //         : const SizedBox(),
              //     //responsive height
              //     options: CarouselOptions(
              //       enlargeFactor: 1,
              //       enlargeCenterPage: true,
              //       enlargeStrategy: CenterPageEnlargeStrategy.height,
              //       autoPlay: false,
              //     ),
              //   )
              : const SizedBox(),

          const SizedBox(height: 20),
        ],
      ),
    );
  }
}
