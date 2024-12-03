import 'package:events_jo/features/admin/domain/repos/admin_repo.dart';
import 'package:events_jo/features/admin/presentation/cubits/single%20owner/admin_single_owner_states.dart';
import 'package:events_jo/features/auth/domain/entities/app_user.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AdminSingleOwnerCubit extends Cubit<AdminSingleOwnerStates> {
  final AdminRepo adminRepo;

  AdminSingleOwnerCubit({required this.adminRepo})
      : super(AdminSingleOwnerInit());

  void getOwnerStream(String id) {
    //loading...
    emit(AdminSingleOwnerLoading());

    adminRepo.getOwnerStream(id).listen(
      (owner) {
        if (owner == null) {
          //error
          emit(AdminSingleOwnerError('Owner doesn\'t exist'));
          return;
        }

        final currentState = state;
        AppUser? currentOwner = owner;

        if (currentState is AdminSingleOwnerLoaded) {
          currentOwner = currentState.owner;
        }

        //check if two objects are the same
        if (!identical(currentOwner!, owner)) {
          //notify for change
          emit(AdminSingleOwnerChanged());
        }

        //done
        emit(AdminSingleOwnerLoaded(owner));
      },
      onError: (error) {
        //error
        emit(AdminSingleOwnerError(error.toString()));
      },
    );
  }
}
