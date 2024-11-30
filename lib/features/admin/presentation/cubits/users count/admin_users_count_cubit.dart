import 'package:events_jo/features/admin/domain/repos/admin_repo.dart';
import 'package:events_jo/features/admin/presentation/cubits/users%20count/admin_users_count_states.dart';
import 'package:events_jo/features/auth/domain/entities/app_user.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AdminUsersCountCubit extends Cubit<AdminUsersCountStates> {
  final AdminRepo adminRepo;

  AdminUsersCountCubit({required this.adminRepo})
      : super(AdminUsersCountInit());

  //listen to users stream (in real time)
  List<AppUser> getAllUsersStream() {
    //loading...
    emit(AdminUsersCountLoading());

    List<AppUser> usersCount = [];

    //start listening
    adminRepo.getAllUsersStream().listen(
      (users) async {
        usersCount = users;

        //done
        emit(AdminUsersCountLoaded(users));
      },
      onError: (error) {
        //error
        emit(AdminUsersCountError(error.toString()));
      },
    );
    return usersCount;
  }
}
