import 'dart:async';
import 'dart:convert';
import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/api/dio_function/api_constants.dart';
import '../../../../core/api_functions/user/update_user_model/update_user_repository.dart';
import '../../../../features/auth_page/auth_cubit/FacilityValidator.dart';
import '../../../../features/store_page/logic/branch_cubit/branch_cubit.dart';
import '../../../../features/store_page/logic/work_time_cubit/work_time_cubit.dart';
import '../../../../core/api_functions/user/check_if_user_exist_or_not_model/check_if_user_exist_or_not_repository.dart';
import '../../../../core/api_functions/user/check_if_user_exist_or_not_model/check_if_user_exist_or_not_request.dart';
import '../../../../core/pages_widgets/general_widgets/navigate_to_page_widget.dart';
import '../../../../features/auth_page/change_password/change_password_page.dart';
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
  static AuthCubit get(context) => BlocProvider.of(context);

  String phoneNumber = "";

  bool _isConfirmPasswordObscure = true;

  bool get isConfirmPasswordObscure => _isConfirmPasswordObscure;
  bool isPasswordVisible = false;
  bool isConfirmPasswordVisible = false;

  void togglePasswordVisibility() {
    isPasswordVisible = !isPasswordVisible;
    emit(AuthPasswordVisibilityChanged());
  }

  void toggleConfirmPasswordVisibility() {
    isConfirmPasswordVisible = !isConfirmPasswordVisible;
    emit(AuthPasswordVisibilityChanged());
  }

  Future<void> init() async {
    emit(AuthLoading());

    final user = await AuthLocalStorage.getUser();

    if (user == null) {
      emit(AuthUnauthenticated());
      return;
    }

    await _checkFacilityCompletion(user);
  }

  Timer? _timer;
  int secondsRemaining = 30;
  String otpCode = "";

  void generateOtp() {
    final random = Random();
    otpCode = (1000 + random.nextInt(9000)).toString();

    print("OTP CODE: $otpCode");

    startTimer();
    emit(AuthOtpGenerated());
  }

  void startTimer() {
    secondsRemaining = 30;
    _timer?.cancel();

    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (secondsRemaining == 0) {
        timer.cancel();
        emit(AuthOtpExpired());
      } else {
        secondsRemaining--;
        emit(AuthOtpTimer());
      }
    });
  }

  bool isOtpError = false;

  void validateOtp(String code, BuildContext context,String email) {
    if (code == otpCode) {
      isOtpError = false;
      emit(AuthOtpSuccess());

      Navigator.pop(context);
      Navigator.push(
        context,
        NavigateToPageWidget(ChangePasswordPage(email: email)),
      );
    } else {
      isOtpError = true;
      emit(AuthOtpError(AppLanguageKeys.wrongCode));
    }
  }

  void resetOtpError() {
    if (isOtpError) {
      isOtpError = false;
      emit(AuthOtpReset());
    }
  }
  void resendOtp() {
    generateOtp();
    isOtpError = false;
    emit(AuthOtpGenerated());
  }

  void updatePhone(String phone) {
    phoneNumber = phone;
    emit(AuthInitial());
  }


  Future<void> checkIfUserExistOrNot({
    required String email,
    required String phone,
  }) async {
    emit(AuthLoginLoading());

    final result = await checkIfUserExistOrNotFunction(
      request: CheckIfUserExistOrNotRequest(
        user: email,
        type: UserType.providerUser,
      ),
    );

    if (result != null && result.isNotEmpty) {
      final user = result.first;

      if (user.value == true &&
          user.phone == phone) {

        emit(AuthLoginSuccess());

      } else {
        emit(AuthLoginError(AppLanguageKeys.emailOrPhoneInvalid));
      }

    } else {
      emit(AuthLoginError(AppLanguageKeys.userNotFound));
    }
  }

  void showLogin() => emit(AuthShowLogin());
  void showSignup() => emit(AuthShowSignup());
  void showRestPassword() => emit(AuthShowRestPassword());



  Future<void> login(LoginRequest request) async {
    emit(AuthLoginLoading());

    final user = await loginFunction(loginRequest: request);

    if (user != null) {
      await AuthLocalStorage.saveUser(user);

      await _checkFacilityCompletion(user);
    } else {
      emit(AuthLoginError(AppLanguageKeys.loginFailed));
    }
  }
  Future<void> _checkFacilityCompletion(CreateUserRequest user) async {
    final branchCubit = BranchCubit();
    final workTimeCubit = UpdateWorkTimeCubit();

    await Future.wait([
      branchCubit.getProviderBranches(),
      workTimeCubit.getWorkTimes(),
    ]);

    if (isClosed) return;

    final result = FacilityValidator.validate(
      user: user,
      branchCubit: branchCubit,
      workTimeCubit: workTimeCubit,
    );

    if (isClosed) return;

    if (result.isValid) {
      emit(AuthAuthenticated());
    } else {
      emit(AuthIncompleteProfile(result.missingFields));
    }
  }

  static Future<void> saveUserFromRequest(CreateUserRequest request) async {
    await AuthLocalStorage.saveUser(request);
  }

  Future<void> checkAuth() async {
    final isLoggedIn = await AuthLocalStorage.isLoggedIn();
    if (state is AuthUpdateLoading || state is AuthUpdateSuccess) {
      return;
    }

    if (state is AuthAuthenticated && isLoggedIn) {
      return;
    }

    if (isLoggedIn) {
      emit(AuthAuthenticated());
    } else {
      emit(AuthUnauthenticated());
    }
  }
  Future<void> reCheckFacility() async {
    final user = await AuthLocalStorage.getUser();

    if (user == null) {
      emit(AuthUnauthenticated());
      return;
    }

    final branchCubit = BranchCubit();
    final workTimeCubit = UpdateWorkTimeCubit();

    await Future.wait([
      branchCubit.getProviderBranches(),
      workTimeCubit.getWorkTimes(),
    ]);

    final result = FacilityValidator.validate(
      user: user,
      branchCubit: branchCubit,
      workTimeCubit: workTimeCubit,
    );

    if (result.isValid) {
      emit(AuthAuthenticated());
    } else {
      emit(AuthIncompleteProfile(result.missingFields));
    }
  }
  Future<void> updateUser(CreateUserRequest request) async {
    if (isClosed) return;

    emit(AuthUpdateLoading());

    try {
      final oldUser = await AuthLocalStorage.getUser();

      print("========== REQUEST ==========");
      print(jsonEncode(request.toJson()));

      final bool isSuccess = await updateUserFunction(
        createUserRequest: request,
      );

      if (isClosed) return;

      if (isSuccess) {
        final updatedUser = CreateUserRequest(
          userid: oldUser?.userid,
          username: request.username ?? oldUser?.username,
          phone: request.phone ?? oldUser?.phone,
          email: request.email ?? oldUser?.email,
          age: request.age ?? oldUser?.age,
          gander: request.gander ?? oldUser?.gander,
          image: request.image ?? oldUser?.image,
          type: oldUser?.type,
          isActive: oldUser?.isActive,
          joinDate: oldUser?.joinDate,
          providerDetails:
          request.providerDetails ?? oldUser?.providerDetails,
        );

        await AuthLocalStorage.saveUser(updatedUser);

        emit(AuthUpdateSuccess());
      } else {
        emit(AuthUpdateError("Update failed"));
      }
    } catch (e) {
      print("🔥 ERROR: $e");
      if (isClosed) return;
      emit(AuthUpdateError(e.toString()));
    }
  }

  Future<void> logout() async {
    emit(AuthLoading()); // optional loading

    await AuthLocalStorage.clearUser();

    emit(AuthUnauthenticated());
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
  Future<void> changePassword(ChangePasswordRequest request) async {
    emit(AuthLoginLoading());

    final bool isSuccess =
    await changePasswordFunction(changePasswordRequest: request);

    if (isSuccess) {
      await AuthLocalStorage.clearUser();

      emit(AuthChangePasswordSuccess()); // ✅ مهم
    } else {
      emit(AuthLoginError("Change password failed"));
    }
  }

  Future<void> signup(CreateUserRequest request) async {
    if (isClosed) return;

    emit(AuthSignupLoading());

    final bool isSuccess =
    await createUserFunction(createUserRequest: request);

    if (isClosed) return;

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