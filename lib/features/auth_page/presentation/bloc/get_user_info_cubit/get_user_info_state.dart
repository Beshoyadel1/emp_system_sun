import 'package:emp_system_sun/features/auth_page/data/model/create_user_model/create_user_request.dart';

abstract class GetUserInfoState {}

final class GetUserInfoInitial extends GetUserInfoState {}

final class GetUserInfoLoading extends GetUserInfoState {}

final class GetUserInfoSuccess extends GetUserInfoState {
  final CreateUserRequest user;

  GetUserInfoSuccess({
    required this.user,
  });
}

final class GetUserInfoError extends GetUserInfoState {
  final String message;

  GetUserInfoError({
    required this.message,
  });
}