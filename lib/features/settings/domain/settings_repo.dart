import 'package:events_jo/config/enums/user_type_enum.dart';

abstract class SettingsRepo {
  Future<String?> updateUserName(String newName);

  Future<UserType?> updateUserType(UserType initType, UserType newType);

  Future<String?> updateUserEmail(String newEmail, String oldEmail);
}
