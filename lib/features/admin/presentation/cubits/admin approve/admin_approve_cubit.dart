import 'package:cached_network_image/cached_network_image.dart';
import 'package:events_jo/config/utils/global_colors.dart';
import 'package:events_jo/config/utils/loading/global_loading_image.dart';
import 'package:events_jo/features/admin/domain/repos/admin_repo.dart';
import 'package:events_jo/features/admin/presentation/components/dialogs/admin_actions_dialog.dart';
import 'package:events_jo/features/admin/presentation/components/dialogs/admin_drinks_dialog_preview.dart';
import 'package:events_jo/features/admin/presentation/components/dialogs/admin_images_dialog_preview.dart';
import 'package:events_jo/features/admin/presentation/components/dialogs/admin_meals_dialog_preview.dart';
import 'package:events_jo/features/admin/presentation/cubits/admin%20approve/admin_approve_states.dart';
import 'package:events_jo/features/weddings/domain/entities/wedding_venue.dart';
import 'package:events_jo/features/weddings/domain/entities/wedding_venue_drink.dart';
import 'package:events_jo/features/weddings/domain/entities/wedding_venue_meal.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AdminApproveCubit extends Cubit<AdminApproveStates> {
  final AdminRepo adminRepo;

  AdminApproveCubit({required this.adminRepo}) : super(AdminApproveInit());

  //listen to approved venues stream (in real time)
  List<WeddingVenue> getApprovedWeddingVenuesStream() {
    //loading...
    emit(AdminApproveLoading());

    List<WeddingVenue> weddingVenues = [];

    //start listening
    adminRepo.getApprovedWeddingVenuesStream().listen(
      (venues) async {
        weddingVenues = venues;

        //done
        emit(AdminApproveLoaded(venues));
      },
      onError: (error) {
        //error
        emit(AdminApproveError(error.toString()));
      },
    );
    return weddingVenues;
  }

  Future<void> suspendVenue(String id) async {
    //suspend loading...
    emit(AdminSuspendActionLoading());
    try {
      //suspending
      await adminRepo.suspendVenue(id);

      //suspend done
      emit(AdminSuspendActionLoaded());

      //pass state back to stream
      emit(AdminApproveLoaded(getApprovedWeddingVenuesStream()));
    } catch (e) {
      //error
      emit(AdminApproveError(e.toString()));
    }
  }

  //---Dialog Methods Below---

  //shows admin's actions (approve,deny,suspend)
  Future<Object?> showAdminActionsDialog(BuildContext context,
      {required String text, required IconData icon}) {
    return showGeneralDialog(
      context: context,
      barrierDismissible: false,
      pageBuilder: (context, animation, secondaryAnimation) =>
          AdminActionsDialog(
        icon: icon,
        text: text,
      ),
    );
  }

  //shows venue's images
  Future<Object?> showImagesDialogPreview(
      BuildContext context, List<dynamic> images, bool isWeb) {
    return showGeneralDialog(
      context: context,
      pageBuilder: (context, animation, secondaryAnimation) =>
          AdminImagesDialogPreview(
              images: imagesStringsToWidgets(images, isWeb)),
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
  List<Widget> imagesStringsToWidgets(List<dynamic> images, bool isWeb) {
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
