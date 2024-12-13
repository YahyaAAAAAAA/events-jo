import 'package:events_jo/config/utils/global_snack_bar.dart';
import 'package:events_jo/features/auth/domain/entities/app_user.dart';
import 'package:events_jo/config/enums/user_type_enum.dart';
import 'package:events_jo/features/auth/domain/repos/auth_repo.dart';
import 'package:events_jo/features/auth/representation/cubits/auth_states.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AuthCubit extends Cubit<AuthStates> {
  final AuthRepo authRepo;
  AppUser? _currentUser;

  AuthCubit({required this.authRepo}) : super(AuthInitial());

  // check if auth
  void checkAuth() async {
    //loading...
    emit(AuthLoading(message: "Welcome Back"));

    final AppUser? user = await authRepo.getCurrentUser();

    if (user != null) {
      _currentUser = user;
      emit(Authenticated(user));
    } else {
      emit(Unauthenticated());
    }
  }

  //get current user
  AppUser? get currentUser => _currentUser;

  //login with email+pass
  Future<void> login(
    BuildContext context, {
    required String email,
    required String pw,
  }) async {
    try {
      //show loading state
      emit(AuthLoading(message: "Welcome Back"));

      //check info
      final check = checkLoginInfo(
        context,
        email: email,
        pw: pw,
      );

      //info invalid
      if (check == false) {
        emit(Unauthenticated());
        return;
      }

      //get user
      final user = await authRepo.loginWithEmailPassword(email, pw);

      if (user != null) {
        _currentUser = user;
        emit(Authenticated(user));
      } else {
        emit(Unauthenticated());
      }
    } catch (e) {
      emit(AuthError(e.toString()));
      emit(Unauthenticated());
    }
  }

  //register with email+pass
  Future<void> regitser(
    BuildContext context, {
    required String name,
    required String email,
    required String pw,
    required String confirmPw,
    required double latitude,
    required double longitude,
    required UserType type,
  }) async {
    try {
      //show loading state
      emit(AuthLoading(message: "Welcome to EventsJo"));

      //check info
      final check = checkRegisterInfo(
        context,
        email: email,
        name: name,
        pw: pw,
        confirmPw: confirmPw,
      );

      //info invalid
      if (check == false) {
        emit(Unauthenticated());
        return;
      }

      //register and save user
      final user = await authRepo.registerWithEmailPassword(
          name, email, pw, latitude, longitude, type);

      if (user != null) {
        //done
        _currentUser = user;
        emit(Authenticated(user));
      } else {
        //user doesn't exist
        emit(Unauthenticated());
      }
    } catch (e) {
      //error
      emit(AuthError(e.toString()));
      emit(Unauthenticated());
    }
  }

  //logout
  Future<void> logout(String id, UserType userType) async {
    emit(AuthLoading(message: "Logging Out"));

    await authRepo.logout(id, userType);

    emit(Unauthenticated());
  }

  //validate user's register input
  bool checkRegisterInfo(
    BuildContext context, {
    required String email,
    required String name,
    required String pw,
    required String confirmPw,
  }) {
    //name empty
    if (name.isEmpty) {
      GSnackBar.show(
        context: context,
        text: 'Please enter a name',
      );

      return false;
    }

    //email empty
    if (email.isEmpty) {
      GSnackBar.show(
        context: context,
        text: 'Please enter an email',
      );

      return false;
    }

    //password empty
    if (pw.isEmpty) {
      GSnackBar.show(
        context: context,
        text: 'Please enter a password',
      );

      return false;
    }

    //confirm password empty
    if (confirmPw.isEmpty) {
      GSnackBar.show(
        context: context,
        text: 'Please confirm your password',
      );

      return false;
    }

    //passwords dont match
    if (pw != confirmPw) {
      GSnackBar.show(
        context: context,
        text: 'Passwords dont match',
      );

      return false;
    }

    return true;
  }

  //validate user's login input
  bool checkLoginInfo(
    BuildContext context, {
    required String email,
    required String pw,
  }) {
    //name empty
    if (email.isEmpty) {
      GSnackBar.show(
        context: context,
        text: 'Please enter an email',
      );
      return false;
    }

    //password empty
    if (pw.isEmpty) {
      GSnackBar.show(
        context: context,
        text: 'Please enter a password',
      );
      return false;
    }

    return true;
  }
}
