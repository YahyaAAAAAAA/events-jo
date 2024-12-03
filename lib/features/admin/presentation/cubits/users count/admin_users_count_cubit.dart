import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:events_jo/features/admin/domain/repos/admin_repo.dart';
import 'package:events_jo/features/admin/presentation/cubits/users%20count/admin_users_count_states.dart';
import 'package:events_jo/features/auth/domain/entities/app_user.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AdminUsersCountCubit extends Cubit<AdminUsersCountStates> {
  final AdminRepo adminRepo;

  AdminUsersCountCubit({required this.adminRepo})
      : super(AdminUsersCountInit());

  //listen to users stream
  List<AppUser> getAllUsersStream() {
    //loading...
    emit(AdminUsersCountLoading());

    List<AppUser> usersCount = [];

    //start listening
    adminRepo.getAllUsersStream().listen(
      (snapshot) async {
        final currentState = state;
        List<AppUser> currentUsers = [];

        //get current users
        if (currentState is AdminUsersCountLoaded) {
          currentUsers = List.from(currentState.users);
        }

        for (var change in snapshot.docChanges) {
          //get change data
          final data = change.doc.data();

          //ignore if change is null
          if (data == null) continue;

          //current user for the change
          final user = AppUser.fromJson(data);

          //add
          if (change.type == DocumentChangeType.added) {
            //check if the user already exists before adding
            final exists = currentUsers.any((v) => v.uid == user.uid);
            if (!exists) {
              currentUsers.add(user);
            }
          }
          //update
          else if (change.type == DocumentChangeType.modified) {
            //get updated user index
            final index = currentUsers.indexWhere((v) => v.uid == user.uid);

            if (index != -1) {
              currentUsers[index] = user;
            }
          }
          //remove
          else if (change.type == DocumentChangeType.removed) {
            currentUsers.removeWhere((v) => v.uid == user.uid);
          }
        }

        emit(AdminUsersCountLoaded(currentUsers));
      },
      onError: (error) {
        //error
        emit(AdminUsersCountError(error.toString()));
      },
    );
    return usersCount;
  }

  String generateUniqueId() {
    return adminRepo.generateUniqueId();
  }
}
