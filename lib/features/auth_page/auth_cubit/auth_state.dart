import '../../../../core/api_functions/user/create_user_model/create_user_request.dart';

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

  AuthLoginSuccess([this.user]);
}

class AuthLoginError extends AuthState {
  final String message;
  AuthLoginError(this.message);
}

class AuthSignupLoading extends AuthState {}

class AuthSignupSuccess extends AuthState {}

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