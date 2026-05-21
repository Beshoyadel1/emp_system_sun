
import 'package:emp_system_sun/features/auth_page/data/model/create_user_model/create_user_request.dart';

abstract class AuthState {}


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