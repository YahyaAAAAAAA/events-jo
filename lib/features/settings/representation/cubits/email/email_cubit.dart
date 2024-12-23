import 'package:events_jo/features/settings/domain/repos/settings_repo.dart';
import 'package:events_jo/features/settings/representation/cubits/email/email_states.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class EmailCubit extends Cubit<EmailStates> {
  final SettingsRepo settingsRepo;

  EmailCubit({required this.settingsRepo}) : super(EmailInitial());

  //change user's email
  Future<void> updateUserEmail(
      String newEmail, String oldEmail, String password) async {
    //loading...
    emit(EmailLoading());

    try {
      //change email
      final email =
          await settingsRepo.updateUserEmail(newEmail, oldEmail, password);

      if (email == newEmail) {
        //verification email sent
        emit(EmailVerificationSent(
            'Email verification sent, please re-login if you verified your email'));

        //done
        emit(EmailLoaded());
      }
    } catch (e) {
      //error
      emit(EmailError(e.toString()));
    }
  }
}
