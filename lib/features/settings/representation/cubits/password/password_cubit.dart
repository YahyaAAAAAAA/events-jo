import 'package:events_jo/features/settings/domain/repos/settings_repo.dart';
import 'package:events_jo/features/settings/representation/cubits/password/password_states.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PasswordCubit extends Cubit<PasswordStates> {
  final SettingsRepo settingsRepo;

  PasswordCubit({required this.settingsRepo}) : super(PasswordInitial());

  //change user's password
  Future<void> updateUserPassword(
      String newPassword, String oldPassword) async {
    //loading...
    emit(PasswordLoading());

    try {
      //change password
      final password =
          await settingsRepo.updateUserPassword(newPassword, oldPassword);

      if (password == newPassword) {
        //message
        emit(PasswordUpdated('Password changed successfully'));

        //done
        emit(PasswordLoaded());
      }
    } catch (e) {
      //error
      emit(PasswordError(e.toString()));
    }
  }
}
