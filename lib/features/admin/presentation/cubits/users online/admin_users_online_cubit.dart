import 'package:events_jo/features/admin/domain/repos/admin_repo.dart';
import 'package:events_jo/features/admin/presentation/cubits/users%20online/admin_users_online_states.dart';
import 'package:events_jo/features/auth/domain/entities/app_user.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AdminUsersOnlineCubit extends Cubit<AdminUsersOnlineStates> {
  final AdminRepo adminRepo;

  AdminUsersOnlineCubit({required this.adminRepo})
      : super(AdminUsersOnlineInit());

  //listen to online users stream
  List<AppUser> getAllOnlineUsersStream() {
    //loading...
    emit(AdminUsersOnlineLoading());

    List<AppUser> usersOnline = [];

    //start listening
    adminRepo.getAllOnlineUsersStream().listen(
      (users) async {
        usersOnline = users;

        //done
        emit(AdminUsersOnlineLoaded(users));
      },
      onError: (error) {
        //error
        emit(AdminUsersOnlineError(error.toString()));
      },
    );
    return usersOnline;
  }
}
