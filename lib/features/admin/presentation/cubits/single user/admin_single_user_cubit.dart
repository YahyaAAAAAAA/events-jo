import 'package:events_jo/features/admin/domain/repos/admin_repo.dart';
import 'package:events_jo/features/admin/presentation/cubits/single%20user/admin_single_user_states.dart';
import 'package:events_jo/features/auth/domain/entities/app_user.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AdminSingleUserCubit extends Cubit<AdminSingleUserStates> {
  final AdminRepo adminRepo;

  AdminSingleUserCubit({required this.adminRepo})
      : super(AdminSingleUserInit());

  void getUserStream(String id) {
    //loading...
    emit(AdminSingleUserLoading());

    adminRepo.getUserStream(id).listen(
      (user) {
        if (user == null) {
          //error
          emit(AdminSingleUserError('User doesn\'t exist'));
          return;
        }

        final currentState = state;
        AppUser? currentUser = user;

        if (currentState is AdminSingleUserLoaded) {
          currentUser = currentState.user;
        }

        //check if two objects are the same
        if (!identical(currentUser!, user)) {
          //notify for change
          emit(AdminSingleUserChanged());
        }

        //done
        emit(AdminSingleUserLoaded(user));
      },
      onError: (error) {
        //error
        emit(AdminSingleUserError(error.toString()));
      },
    );
  }
}
