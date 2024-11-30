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
      (owners) async {
        ownersCount = owners;

        //done
        emit(AdminOwnersCountLoaded(owners));
      },
      onError: (error) {
        //error
        emit(AdminOwnersCountError(error.toString()));
      },
    );
    return ownersCount;
  }
}
