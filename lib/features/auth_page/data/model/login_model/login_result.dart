import 'package:emp_system_sun/features/auth_page/data/model/create_user_model/create_user_request.dart';

class LoginResult {
  final bool success;
  final CreateUserRequest? user;

  LoginResult({
    required this.success,
    this.user,
  });
}