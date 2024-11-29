import 'package:events_jo/features/admin/domain/repos/admin_repo.dart';
import 'package:events_jo/features/admin/presentation/cubits/admin_states.dart';
import 'package:events_jo/features/owner/representation/components/dialogs/drinks_dialog_preview.dart';
import 'package:events_jo/features/owner/representation/components/dialogs/images_dialog_preview.dart';
import 'package:events_jo/features/owner/representation/components/dialogs/meals_dialog_preview.dart';
import 'package:events_jo/features/weddings/domain/entities/wedding_venue_drink.dart';
import 'package:events_jo/features/weddings/domain/entities/wedding_venue_meal.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AdminCubit extends Cubit<AdminStates> {
  final AdminRepo adminRepo;

  AdminCubit({required this.adminRepo}) : super(AdminInit());

  //listen to venues stream (in real time)
  void getWeddingVenuesStream() {
    //loading...
    emit(AdminLoading());

    //start listening
    adminRepo.getWeddingVenuesRequestsStream().listen(
      (venues) async {
        //? I dont like this , might add ownerName to every venue instead.
        List<String> names = [];
        for (int i = 0; i < venues.length; i++) {
          names.add(await getWeddingOwnerName(venues[i].owner));
        }

        //done
        emit(AdminLoaded(venues, names));
      },
      onError: (error) {
        //error
        emit(AdminError(error.toString()));
      },
    );
  }

  //delete images
  Future<void> deleteImagesFromServer(List<String> urls) async {
    try {
      //loading...
      emit(AdminLoading());

      //delete images
      await adminRepo.deleteImagesFromServer(urls);

      emit(AdminInit()); //todo for now
    } catch (e) {
      //error
      emit(AdminError(e.toString()));

      return;
    }
  }

  //get owner name of a venue
  Future<String> getWeddingOwnerName(String uid) async {
    //no need to emit state here since it's called inside a stream
    try {
      //get name
      final data = await adminRepo.getWeddingOwnerName(uid);

      return data;
    } catch (e) {
      //error
      emit(AdminError(e.toString()));
      return '';
    }
  }

  //shows venue's images
  Future<Object?> showImagesDialogPreview(
      BuildContext context, List<dynamic> images, bool isWeb) {
    return showGeneralDialog(
      context: context,
      pageBuilder: (context, animation, secondaryAnimation) =>
          ImagesDialogPreview(images: imagesStringsToWidgets(images, isWeb)),
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

  //convert strings -> images
  List<Widget> imagesStringsToWidgets(List<dynamic> images, bool isWeb) {
    List<Widget> imagesWidgets = [];
    imagesWidgets.clear();
    for (int i = 0; i < images.length; i++) {
      //todo replace with cached image
      imagesWidgets.add(Image.network(
        images[i],
      ));
    }

    return imagesWidgets;
  }
}
