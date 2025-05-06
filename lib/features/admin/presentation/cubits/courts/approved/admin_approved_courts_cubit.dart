import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:events_jo/config/utils/delay.dart';
import 'package:events_jo/config/utils/global_colors.dart';
import 'package:events_jo/config/utils/loading/global_loading_image.dart';
import 'package:events_jo/features/admin/domain/repos/admin_repo.dart';
import 'package:events_jo/features/admin/presentation/components/dialogs/admin_actions_dialog.dart';
import 'package:events_jo/features/admin/presentation/components/dialogs/admin_drinks_dialog_preview.dart';
import 'package:events_jo/features/admin/presentation/components/dialogs/admin_images_dialog_preview.dart';
import 'package:events_jo/features/admin/presentation/components/dialogs/admin_meals_dialog_preview.dart';
import 'package:events_jo/features/admin/presentation/cubits/courts/approved/admin_approved_courts_states.dart';
import 'package:events_jo/features/events/shared/domain/models/football_court.dart';
import 'package:events_jo/features/events/shared/domain/models/wedding_venue_drink.dart';
import 'package:events_jo/features/events/shared/domain/models/wedding_venue_meal.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

//cubits should be done, check repo and then implement ui then orders
class AdminApprovedCourtsCubit extends Cubit<AdminApprovedCourtsStates> {
  final AdminRepo adminRepo;

  AdminApprovedCourtsCubit({required this.adminRepo})
      : super(AdminApprovedCourtsInit());

  //listen to approved venues stream
  List<FootballCourt> getApprovedCourtStream() {
    //loading...
    emit(AdminApprovedCourtsLoading());

    List<FootballCourt> footballCourts = [];

    //start listening
    adminRepo.getApprovedCourtsStream().listen(
      (snapshot) async {
        final currentState = state;
        List<FootballCourt> currentCourts = [];

        await Delay.halfSecond();

        //get current venues
        if (currentState is AdminApprovedCourtsLoaded) {
          currentCourts = List.from(currentState.courts);
        }

        for (var change in snapshot.docChanges) {
          //get change data
          final data = change.doc.data();

          //ignore if change is null
          if (data == null) continue;

          //current venue for the change
          final court = FootballCourt.fromJson(data);

          //add
          if (change.type == DocumentChangeType.added) {
            //check if the venue already exists before adding
            final exists = currentCourts.any((v) => v.id == court.id);
            if (!exists) {
              currentCourts.add(court);
            }
          }

          //update
          else if (change.type == DocumentChangeType.modified) {
            //get updated venue index
            final index = currentCourts.indexWhere((v) => v.id == court.id);

            if (index != -1) {
              currentCourts[index] = court;
            }
          }

          //remove
          else if (change.type == DocumentChangeType.removed) {
            currentCourts.removeWhere((v) => v.id == court.id);
          }
        }

        emit(AdminApprovedCourtsLoaded(currentCourts));
      },
      onError: (error) {
        //error
        emit(AdminApprovedCourtsError(error.toString()));

        return [];
      },
    );
    return footballCourts;
  }

  Future<void> suspendVenue(String id) async {
    //suspend loading...
    emit(AdminApprovedCourtsSuspendActionLoading());
    try {
      //one second delay for animation
      await Future.delayed(
        const Duration(seconds: 1),
        () async {
          //suspending
          await adminRepo.suspendVenue(id);
        },
      );

      //suspend done
      emit(AdminApprovedCourtsSuspendActionLoaded());

      //pass state back to stream
      emit(AdminApprovedCourtsLoaded(getApprovedCourtStream()));
    } catch (e) {
      //error
      emit(AdminApprovedCourtsError(e.toString()));
    }
  }

  //lock
  Future<void> lockVenue(String id) async {
    try {
      await adminRepo.lockVenue(id);
    } catch (e) {
      //error
      emit(AdminApprovedCourtsError(e.toString()));
    }
  }

  //unlock
  Future<void> unlockVenue(String id) async {
    try {
      await adminRepo.unlockVenue(id);
    } catch (e) {
      //error
      emit(AdminApprovedCourtsError(e.toString()));
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
