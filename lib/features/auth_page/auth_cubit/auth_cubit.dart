import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/api_functions/user/change_password_model/change_password_repository.dart';
import '../../../../core/api_functions/user/change_password_model/change_password_request.dart';
import '../../../../core/api_functions/user/check_if_user_exist_model/check_if_user_exist_repository.dart';
import '../../../../core/api_functions/user/check_if_user_exist_model/check_if_user_exist_request.dart';
import '../../../../core/language/language_constant.dart';
import '../../../../core/api_functions/user/create_user_model/create_user_repository.dart';
import '../../../../core/api_functions/user/create_user_model/create_user_request.dart';
import '../../../../core/api_functions/user/login_model/login_repository.dart';
import '../../../../core/api_functions/user/login_model/login_request.dart';
import 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  AuthCubit() : super(AuthInitial());

  String otpCode = "";

  String phoneNumber = "";

  bool _isConfirmPasswordObscure = true;

  bool get isConfirmPasswordObscure => _isConfirmPasswordObscure;
  bool isPasswordVisible = false;

  void togglePasswordVisibility() {
    isPasswordVisible = !isPasswordVisible;
    emit(AuthPasswordVisibilityChanged());
  }
  void updatePhone(String phone) {
    phoneNumber = phone;
    emit(AuthInitial());
  }



  void toggleConfirmPasswordVisibility() {
    _isConfirmPasswordObscure = !_isConfirmPasswordObscure;
    emit(AuthPasswordVisibilityChanged());
  }

  void showLogin() => emit(AuthShowLogin());
  void showSignup() => emit(AuthShowSignup());
  void showRestPassword() => emit(AuthShowRestPassword());

  Future<void> login(LoginRequest request) async {
    emit(AuthLoginLoading());

    final user = await loginFunction(loginRequest: request);

    if (user != null) {
      emit(AuthLoginSuccess(user));
    } else {
      emit(AuthInitial());
    }
  }

  Future<void> checkEmailExist(CheckIfUserExistRequest checkIfUserExistRequest) async {
    emit(AuthLoginLoading());

    final bool isSuccess =
    await checkIfUserExistFunction(checkIfUserExistRequest: checkIfUserExistRequest);

    if (isSuccess) {
      emit(AuthLoginSuccess());
    } else {
      emit(AuthInitial());
    }
  }
  Future<void> changePassword(ChangePasswordRequest changePasswordRequest) async {
    emit(AuthLoginLoading());

    final bool isSuccess =
    await changePasswordFunction(changePasswordRequest: changePasswordRequest);

    if (isSuccess) {
      emit(AuthLoginSuccess());
    } else {
      emit(AuthInitial());
    }
  }
  Future<void> signup(CreateUserRequest request) async {
    emit(AuthSignupLoading());

    final bool isSuccess =
    await createUserFunction(createUserRequest: request);

    if (isSuccess) {
      emit(AuthSignupSuccess());
    } else {
      emit(AuthInitial());
    }
  }

  // ================= Validators =================

  String? nameValidator(String? value) {
    if (value == null || value.trim().isEmpty) {
      return AppLanguageKeys.authCompanyNameRequired;
    }
    return null;
  }

  String? emailValidator(String? value) {
    if (value == null || value.trim().isEmpty) {
      return AppLanguageKeys.authEmailRequired;
    } else if (!isValidEmail(value)) {
      return AppLanguageKeys.authEnterCorrectEmail;
    }
    return null;
  }

  String? passwordValidator(String? value) {
    if (value == null || value.trim().isEmpty) {
      return AppLanguageKeys.authPasswordRequired;
    } else if (value.length < 6) {
      return AppLanguageKeys.authWeakPassword;
    }
    return null;
  }

  String? phoneValidator(String? value) {
    if (value == null || value.trim().isEmpty) {
      return AppLanguageKeys.authPhoneNumberRequired;
    }

    final cleanNumber =
    value.replaceAll(RegExp(r'[^0-9]'), '');

    if (cleanNumber.length < 8 || cleanNumber.length > 15) {
      return AppLanguageKeys.authEnterCorrectPhoneNumber;
    }

    return null;
  }

  bool isValidEmail(String email) {
    final emailRegex = RegExp(
      r"^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9-]+\.[a-zA-Z]{2,}$",
    );
    return emailRegex.hasMatch(email.trim());
  }
}
