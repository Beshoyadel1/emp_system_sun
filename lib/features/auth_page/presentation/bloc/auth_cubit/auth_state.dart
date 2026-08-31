
import 'package:emp_system_sun/features/auth_page/data/model/check_if_user_exist_or_not_model/check_if_user_exist_or_not_model.dart';
import 'package:emp_system_sun/features/auth_page/data/model/create_user_model/create_user_request.dart';

abstract class AuthState {}

class CheckIfUserExistOrNotLoading extends AuthState {}

class CheckIfUserExistOrNotSuccess extends AuthState {
  final CheckIfUserExistOrNotModel data;

  CheckIfUserExistOrNotSuccess(this.data);
}

class CheckIfUserExistOrNotNotFound extends AuthState {
  final CheckIfUserExistOrNotModel data;

  CheckIfUserExistOrNotNotFound(this.data);
}

class CheckIfUserExistOrNotError extends AuthState {
  final String error;

  CheckIfUserExistOrNotError(this.error);
}

class ChangePasswordLoading extends AuthState {}

class ChangePasswordSuccess extends AuthState {
  final String message;

  ChangePasswordSuccess(this.message);
}

class ChangePasswordError extends AuthState {
  final String message;

  ChangePasswordError(this.message);
}
class AuthSignupCompleted extends AuthState {
  final String message;

  AuthSignupCompleted(this.message);
}

class AuthSignupOtpSent extends AuthState {}
class AuthOtpResendSuccess extends AuthState {}

final class AuthInitial extends AuthState {}

final class AuthLoadingState extends AuthState {}

final class AuthDoneState extends AuthState {}

class AuthShowLogin extends AuthState {}

class AuthShowSignup extends AuthState {}

class AuthPasswordVisibilityChanged extends AuthState {}

class AuthShowRestPassword extends AuthState {}

class AuthLoginLoading extends AuthState {}

class AuthLoginSuccess extends AuthState {

  final CreateUserRequest? user;
  final String? message;

  AuthLoginSuccess({
    this.user,
     this.message,
  });
}

class AuthLoginError extends AuthState {
  final String message;
  AuthLoginError(this.message);
}

class AuthSignupLoading extends AuthState {}

class AuthSignupSuccess extends AuthState {

  final String message;

  AuthSignupSuccess(this.message);
}

class AuthSignupError extends AuthState {

  final String message;

  AuthSignupError(this.message);
}


class AuthLoading extends AuthState {}

class AuthAuthenticated extends AuthState {}

class AuthUnauthenticated extends AuthState {}

class AuthOtpGenerated extends AuthState {}


class AuthOtpTimer extends AuthState {}

class AuthOtpExpired extends AuthState {}

class AuthOtpError extends AuthState {
  final String message;
  AuthOtpError(this.message);
}
class AuthOtpSuccess extends AuthState {}

class AuthOtpReset extends AuthState {}

class AuthUpdateLoading extends AuthState {}

class AuthUpdateSuccess extends AuthState {

  final String message;

  AuthUpdateSuccess(this.message);
}
class AuthUpdateError extends AuthState {
  final String error;
  AuthUpdateError(this.error);
}
class AuthIncompleteProfile extends AuthState {
  final List<String> missing;

  AuthIncompleteProfile(this.missing);
}
class AuthChangePasswordSuccess extends AuthState {}