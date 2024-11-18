import 'dart:io';
import 'package:events_jo/features/owner/domain/repo/owner_repo.dart';
import 'package:events_jo/features/owner/representation/components/dialogs/drinks_dialog_preview.dart';
import 'package:events_jo/features/owner/representation/components/dialogs/images_dialog_preview.dart';
import 'package:events_jo/features/owner/representation/components/dialogs/meals_dialog_preview.dart';
import 'package:events_jo/features/owner/representation/cubits/owner_states.dart';
import 'package:events_jo/features/weddings/domain/entities/wedding_venue_drink.dart';
import 'package:events_jo/features/weddings/domain/entities/wedding_venue_meal.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';

class OwnerCubit extends Cubit<OwnerStates> {
  //repo instance
  final OwnerRepo ownerRepo;

  OwnerCubit({required this.ownerRepo}) : super(OwnerInitial());

  //add event
  Future<void> addVenueToDatabase({
    required String name,
    required double lat,
    required double lon,
    required String ownerId,
    required int peopleMax,
    required int peopleMin,
    required double peoplePrice,
    required List<int> startDate,
    required List<int> endDate,
    required List<int> time,
    List<String>? pics,
    List<WeddingVenueMeal>? meals,
    List<WeddingVenueDrink>? drinks,
  }) async {
    try {
      //loading...
      emit(OwnerLoading('Uploading Your Event, Please Wait...'));

      //add to db
      await ownerRepo.addVenueToDatabase(
        name: name,
        lat: lat,
        lon: lon,
        startDate: startDate,
        endDate: endDate,
        time: time,
        peopleMax: peopleMax,
        peopleMin: peopleMin,
        peoplePrice: peoplePrice,
        ownerId: ownerId,
        pics: pics,
        meals: meals,
        drinks: drinks,
      );

      //done
      emit(OwnerLoaded());
    } catch (e) {
      //error
      emit(OwnerError(e.toString()));
    }
  }

  //add images
  Future<List<String>> addImagesToServer(List<XFile> images) async {
    try {
      //loading...
      emit(OwnerLoading('Uploading Images, Please Wait...'));

      //add images
      List<String> urls = await ownerRepo.addImagesToServer(images);

      return urls;
    } catch (e) {
      //error
      emit(OwnerError(e.toString()));

      return [];
    }
  }

  //this shows user's images
  Future<Object?> showImagesDialogPreview(
      BuildContext context, List<XFile> images) {
    return showGeneralDialog(
      context: context,
      pageBuilder: (context, animation, secondaryAnimation) =>
          ImagesDialogPreview(images: imagesFilesToWidgets(images)),
    );
  }

  //this shows user's meals
  Future<Object?> showMealsDialogPreview(
      BuildContext context, List<WeddingVenueMeal> meals) {
    return showGeneralDialog(
      context: context,
      pageBuilder: (context, animation, secondaryAnimation) =>
          MealsDialogPreview(meals: meals),
    );
  }

  //this shows user's drinks
  Future<Object?> showDrinksDialogPreview(
      BuildContext context, List<WeddingVenueDrink> drinks) {
    return showGeneralDialog(
      context: context,
      pageBuilder: (context, animation, secondaryAnimation) =>
          DrinksDialogPreview(drinks: drinks),
    );
  }

  //convert files -> images
  List<Widget> imagesFilesToWidgets(List<XFile> images) {
    List<Widget> imagesWidgets = [];
    imagesWidgets.clear();
    for (int i = 0; i < images.length; i++) {
      imagesWidgets.add(
        Image.file(
          File(images[i].path),
          fit: BoxFit.cover,
        ),
      );
    }

    return imagesWidgets;
  }
}
