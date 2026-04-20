import '../../../../../../core/api_functions/user/create_user_model/create_user_request.dart';

class LoginResult {
  final bool success;
  final CreateUserRequest? user;

  LoginResult({
    required this.success,
    this.user,
  });
}