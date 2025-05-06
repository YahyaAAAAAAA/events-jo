import 'dart:io';
import 'package:events_jo/features/events/shared/domain/models/football_court.dart';
import 'package:events_jo/features/owner/domain/repo/owner_repo.dart';
import 'package:events_jo/features/owner/representation/components/creation/dialogs/drinks_dialog_preview.dart';
import 'package:events_jo/features/owner/representation/components/creation/dialogs/images_dialog_preview.dart';
import 'package:events_jo/features/owner/representation/components/creation/dialogs/meals_dialog_preview.dart';
import 'package:events_jo/features/owner/representation/cubits/creation/owner_states.dart';
import 'package:events_jo/features/events/shared/domain/models/wedding_venue_drink.dart';
import 'package:events_jo/features/events/shared/domain/models/wedding_venue_meal.dart';
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
    required double long,
    required String ownerId,
    required String ownerName,
    required int peopleMax,
    required int peopleMin,
    required double peoplePrice,
    required List<int> startDate,
    required List<int> endDate,
    required List<int> time,
    required String stripeAccountId,
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
        long: long,
        startDate: startDate,
        endDate: endDate,
        time: time,
        peopleMax: peopleMax,
        peopleMin: peopleMin,
        peoplePrice: peoplePrice,
        ownerId: ownerId,
        ownerName: ownerName,
        pics: pics,
        meals: meals,
        drinks: drinks,
        stripeAccountId: stripeAccountId,
      );

      //done
      emit(OwnerLoaded());
    } catch (e) {
      //error
      emit(OwnerError(e.toString()));
    }
  }

  Future<void> addCourtToDatabase(FootballCourt court) async {
    //loading...
    emit(OwnerLoading('Uploading Your Event, Please Wait...'));
    try {
      //add to db
      await ownerRepo.addCourtToDatabase(court);

      //done
      emit(OwnerLoaded());
    } catch (e) {
      //error
      emit(OwnerError(e.toString()));
    }
  }

  //add images
  Future<List<String>> addImagesToServer(
      List<XFile> images, String name) async {
    //loading...
    emit(OwnerLoading('Uploading Images, Please Wait...'));
    try {
      //add images
      List<String> urls = await ownerRepo.addImagesToServer(images, name);

      return urls;
    } catch (e) {
      //error
      emit(OwnerError(e.toString()));

      return [];
    }
  }

  Future<String?> getCity(double lat, double long) async {
    String? city = await ownerRepo.getCity(lat, long);

    return city;
  }

  //used for meals & drinks lists locally (new ids generated on submit)
  String generateUniqueId() {
    return ownerRepo.generateUniqueId();
  }

  //---Dialogs Below---

  //shows venue's images
  Future<Object?> showImagesDialogPreview(
      BuildContext context, List<XFile> images, bool isWeb) {
    return showGeneralDialog(
      context: context,
      pageBuilder: (context, animation, secondaryAnimation) =>
          ImagesDialogPreview(images: imagesFilesToWidgets(images, isWeb)),
    );
  }

  //shows venue's meals
  Future<Object?> showMealsDialogPreview(
      BuildContext context, List<WeddingVenueMeal> meals) {
    return showGeneralDialog(
      context: context,
      pageBuilder: (context, animation, secondaryAnimation) =>
          MealsDialogPreview(meals: meals),
    );
  }

  //shows venue's drinks
  Future<Object?> showDrinksDialogPreview(
      BuildContext context, List<WeddingVenueDrink> drinks) {
    return showGeneralDialog(
      context: context,
      pageBuilder: (context, animation, secondaryAnimation) =>
          DrinksDialogPreview(drinks: drinks),
    );
  }

  //convert files -> images
  List<Widget> imagesFilesToWidgets(List<XFile> images, bool isWeb) {
    List<Widget> imagesWidgets = [];
    imagesWidgets.clear();
    for (int i = 0; i < images.length; i++) {
      imagesWidgets.add(
        isWeb
            ? Image.network(
                images[i].path,
              )
            : Image.file(
                File(images[i].path),
                fit: BoxFit.cover,
              ),
      );
    }

    return imagesWidgets;
  }
}
