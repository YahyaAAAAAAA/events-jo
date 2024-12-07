import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:events_jo/config/preferences/preferences.dart';
import 'package:events_jo/config/utils/delay.dart';
import 'package:events_jo/config/utils/global_colors.dart';
import 'package:events_jo/config/utils/loading/global_loading_image.dart';
import 'package:events_jo/features/admin/domain/repos/admin_repo.dart';
import 'package:events_jo/features/admin/presentation/components/dialogs/admin_actions_dialog.dart';
import 'package:events_jo/features/admin/presentation/components/dialogs/admin_drinks_dialog_preview.dart';
import 'package:events_jo/features/admin/presentation/components/dialogs/admin_images_dialog_preview.dart';
import 'package:events_jo/features/admin/presentation/components/dialogs/admin_meals_dialog_preview.dart';
import 'package:events_jo/features/admin/presentation/cubits/venues/unapprove/admin_unapprove_states.dart';
import 'package:events_jo/features/weddings/domain/entities/wedding_venue.dart';
import 'package:events_jo/features/weddings/domain/entities/wedding_venue_drink.dart';
import 'package:events_jo/features/weddings/domain/entities/wedding_venue_meal.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AdminUnapproveCubit extends Cubit<AdminUnapproveStates> {
  final AdminRepo adminRepo;

  AdminUnapproveCubit({required this.adminRepo}) : super(AdminUnapproveInit());

  //listen to unapproved venues stream (in real time)
  List<WeddingVenue> getUnapprovedWeddingVenuesStream() {
    //loading...
    emit(AdminUnapproveLoading());

    List<WeddingVenue> weddingVenues = [];

    //start listening
    adminRepo.getUnapprovedWeddingVenuesStream().listen(
      (snapshot) async {
        final currentState = state;
        List<WeddingVenue> currentVenues = [];

        await Delay.halfSecond();

        //get current venues
        if (currentState is AdminUnapproveLoaded) {
          currentVenues = List.from(currentState.venues);
        }

        for (var change in snapshot.docChanges) {
          //get change data
          final data = change.doc.data();

          //ignore if change is null
          if (data == null) continue;

          //current venue for the change
          final venue = WeddingVenue.fromJson(data);

          //add
          if (change.type == DocumentChangeType.added) {
            //check if the venue already exists before adding
            final exists = currentVenues.any((v) => v.id == venue.id);

            if (!exists) {
              currentVenues.add(venue);
            }
          }
          //update
          else if (change.type == DocumentChangeType.modified) {
            //get updated venue index
            final index = currentVenues.indexWhere((v) => v.id == venue.id);
            if (index != -1) {
              currentVenues[index] = venue;
            }
          }
          //remove
          else if (change.type == DocumentChangeType.removed) {
            currentVenues.removeWhere((v) => v.id == venue.id);
          }
        }

        //done
        emit(AdminUnapproveLoaded(currentVenues));
      },
      onError: (error) {
        //error
        emit(AdminUnapproveError(error.toString()));
      },
    );
    return weddingVenues;
  }

  Future<void> approveVenue(String id) async {
    //approve loading...
    emit(AdminApproveActionLoading());
    try {
      //one second delay for animation
      await Delay.oneSecond();

      //approving
      await adminRepo.approveVenue(id);

      //approve done
      emit(AdminApproveActionLoaded());

      //pass state back to stream
      emit(AdminUnapproveLoaded(getUnapprovedWeddingVenuesStream()));
    } catch (e) {
      //error
      emit(AdminUnapproveError(e.toString()));
    }
  }

  Future<void> denyVenue(String id, List<dynamic> urls) async {
    //deny loading...
    emit(AdminDenyActionLoading());
    try {
      //one second delay for animation
      await Delay.oneSecond();

      //admin denying, don't notify listeners
      await Preferences.saveBool('isAdminDenying', true);

      //denying
      await adminRepo.denyVenue(id, urls);

      //admin done denying
      await Preferences.saveBool('isAdminDenying', false);

      //deny done
      emit(AdminDenyActionLoaded());

      //pass state back to stream
      emit(AdminUnapproveLoaded(getUnapprovedWeddingVenuesStream()));
    } catch (e) {
      //error
      emit(AdminUnapproveError(e.toString()));
    }
  }

  //lock
  Future<void> lockVenue(String id) async {
    try {
      await adminRepo.lockVenue(id);
    } catch (e) {
      //error
      emit(AdminUnapproveError(e.toString()));
    }
  }

  //unlock
  Future<void> unlockVenue(String id) async {
    try {
      await adminRepo.unlockVenue(id);
    } catch (e) {
      //error
      emit(AdminUnapproveError(e.toString()));
    }
  }

  String generateUniqueId() {
    return adminRepo.generateUniqueId();
  }

  //---Dialog Methods Below---

  //shows admin's actions (approve,deny,suspend)
  Future<Object?> showAdminActionsDialog(
    BuildContext context, {
    required String text,
    required String animation,
    required Color color,
  }) {
    return showGeneralDialog(
      context: context,
      barrierDismissible: false,
      pageBuilder: (context, a, secondaryAnimation) => AdminActionsDialog(
        text: text,
        animation: animation,
        color: color,
      ),
    );
  }

  //shows venue's images
  Future<Object?> showImagesDialogPreview(
      BuildContext context, List<dynamic> images) {
    return showGeneralDialog(
      context: context,
      pageBuilder: (context, animation, secondaryAnimation) =>
          AdminImagesDialogPreview(images: imagesStringsToWidgets(images)),
    );
  }

  //shows venue's meals
  Future<Object?> showMealsDialogPreview(
      BuildContext context, List<WeddingVenueMeal> meals) {
    return showGeneralDialog(
      context: context,
      pageBuilder: (context, animation, secondaryAnimation) =>
          AdminMealsDialogPreview(meals: meals),
    );
  }

  //shows venue's drinks
  Future<Object?> showDrinksDialogPreview(
      BuildContext context, List<WeddingVenueDrink> drinks) {
    return showGeneralDialog(
      context: context,
      pageBuilder: (context, animation, secondaryAnimation) =>
          AdminDrinksDialogPreview(drinks: drinks),
    );
  }

  //convert strings -> images
  List<Widget> imagesStringsToWidgets(List<dynamic> images) {
    List<Widget> imagesWidgets = [];
    imagesWidgets.clear();
    for (int i = 0; i < images.length; i++) {
      imagesWidgets.add(
        CachedNetworkImage(
          imageUrl: images[i],
          //waiting for image
          placeholder: (context, url) => const SizedBox(
            width: 100,
            child: GlobalLoadingImage(),
          ),
          //error getting image
          errorWidget: (context, url, error) => SizedBox(
            width: 100,
            child: Icon(
              Icons.error_outline,
              color: GColors.black,
              size: 40,
            ),
          ),
          fit: BoxFit.cover,
        ),
      );
    }

    return imagesWidgets;
  }
}
