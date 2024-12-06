import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:events_jo/config/utils/delay.dart';
import 'package:events_jo/features/admin/domain/repos/admin_repo.dart';
import 'package:events_jo/features/admin/presentation/cubits/owners%20count/admin_owners_count_states.dart';
import 'package:events_jo/features/auth/domain/entities/app_user.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AdminOwnersCountCubit extends Cubit<AdminOwnersCountStates> {
  final AdminRepo adminRepo;

  AdminOwnersCountCubit({required this.adminRepo})
      : super(AdminOwnersCountInit());

  //listen to approved venues stream (in real time)
  List<AppUser> getAllOwnersStream() {
    //loading...
    emit(AdminOwnersCountLoading());

    List<AppUser> ownersCount = [];

    //start listening
    adminRepo.getAllOwnersStream().listen(
      (snapshot) async {
        final currentState = state;
        List<AppUser> currentOwners = [];

        await Delay.oneSecond();

        //get current owners
        if (currentState is AdminOwnersCountLoaded) {
          currentOwners = List.from(currentState.owners);
        }

        for (var change in snapshot.docChanges) {
          //get change data
          final data = change.doc.data();

          //ignore if change is null
          if (data == null) continue;

          //current owner for the change
          final owner = AppUser.fromJson(data);

          //add
          if (change.type == DocumentChangeType.added) {
            //check if the owner already exists before adding
            final exists = currentOwners.any((v) => v.uid == owner.uid);
            if (!exists) {
              currentOwners.add(owner);
            }
          }
          //update
          else if (change.type == DocumentChangeType.modified) {
            //get updated owner index
            final index = currentOwners.indexWhere((v) => v.uid == owner.uid);

            if (index != -1) {
              currentOwners[index] = owner;
            }
          }
          //remove
          else if (change.type == DocumentChangeType.removed) {
            currentOwners.removeWhere((v) => v.uid == owner.uid);
          }
        }

        emit(AdminOwnersCountLoaded(currentOwners));
      },
      onError: (error) {
        //error
        emit(AdminOwnersCountError(error.toString()));
      },
    );
    return ownersCount;
  }

  String generateUniqueId() {
    return adminRepo.generateUniqueId();
  }
}
