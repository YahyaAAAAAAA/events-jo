import 'package:events_jo/features/admin/domain/repos/admin_repo.dart';
import 'package:events_jo/features/admin/presentation/cubits/owners%20online/admin_owners_online_states.dart';
import 'package:events_jo/features/auth/domain/entities/app_user.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AdminOwnersOnlineCubit extends Cubit<AdminOwnersOnlineStates> {
  final AdminRepo adminRepo;

  AdminOwnersOnlineCubit({required this.adminRepo})
      : super(AdminOwnersOnlineInit());

  //listen to online owners stream
  List<AppUser> getAllOnlineOwnersStream() {
    //loading...
    emit(AdminOwnersOnlineLoading());

    List<AppUser> ownersOnline = [];

    //start listening
    adminRepo.getAllOnlineOwnersStream().listen(
      (owners) async {
        ownersOnline = owners;

        //done
        emit(AdminOwnersOnlineLoaded(owners));
      },
      onError: (error) {
        //error
        emit(AdminOwnersOnlineError(error.toString()));
      },
    );
    return ownersOnline;
  }
}
