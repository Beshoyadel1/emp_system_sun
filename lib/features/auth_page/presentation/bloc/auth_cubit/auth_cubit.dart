import 'dart:async';
import 'dart:math';
import 'package:emp_system_sun/core/services/auth_session.dart';
import 'package:emp_system_sun/features/notifications/data/notification_updates.dart';
import 'package:emp_system_sun/features/technical_support/data/model/chat_events/chat_events.dart';
import 'package:emp_system_sun/features/technical_support/presentation/bloc/employee_chat_cubit/employee_chat_cubit.dart';
import 'package:emp_system_sun/core/setup_git_it.dart';
import 'package:emp_system_sun/core/cubit/app_cubit/app_cubit.dart';
import 'package:emp_system_sun/core/utilies/map_of_all_app.dart';
import 'package:emp_system_sun/features/service_emp_view/presentation/cubit/employee_services_cubit/employee_services_cubit.dart';
import 'package:emp_system_sun/features/auth_page/data/model/login_model/login_result.dart';
import 'package:emp_system_sun/core/api/dio_function/api_constants.dart';
import 'package:emp_system_sun/core/language/language_constant.dart';
import 'package:emp_system_sun/core/theming/auth_local_storage.dart';
import 'package:emp_system_sun/core/services/fcm_service.dart';
import 'package:emp_system_sun/features/auth_page/data/datasource/change_password_datasource/change_password_repository.dart';
import 'package:emp_system_sun/features/auth_page/data/datasource/check_if_user_exist_or_not_datasource/check_if_user_exist_or_not_repository.dart';
import 'package:emp_system_sun/features/auth_page/data/datasource/create_user_datasource/create_user_repository.dart';
import 'package:emp_system_sun/features/auth_page/data/datasource/login_datasource/login_repository.dart';
import 'package:emp_system_sun/features/auth_page/data/datasource/send_verification_code_datasource/send_verification_code_datasource.dart';
import 'package:emp_system_sun/features/auth_page/data/datasource/update_user_datasource/update_user_repository.dart';
import 'package:emp_system_sun/features/auth_page/data/model/create_user_model/employee_details_request.dart';
import 'package:emp_system_sun/features/auth_page/data/model/create_user_model/employee_wrapper_request.dart';
import 'package:emp_system_sun/features/auth_page/data/request/change_password_request/change_password_request.dart';
import 'package:emp_system_sun/features/auth_page/data/request/check_if_user_exist_or_not_request/check_if_user_exist_or_not_request.dart';
import 'package:emp_system_sun/features/auth_page/data/model/create_user_model/create_user_request.dart';
import 'package:emp_system_sun/features/auth_page/data/request/login_request/login_request.dart';
import 'package:emp_system_sun/features/auth_page/data/request/send_verification_code_request/send_verification_code_request.dart';
import 'package:emp_system_sun/features/auth_page/domain/validate/facility_validator.dart';
import 'package:emp_system_sun/features/store_page/presentation/bloc/branch_cubit/branch_cubit.dart';
import 'package:emp_system_sun/features/store_page/presentation/bloc/work_time_cubit/work_time_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:emp_system_sun/features/notifications/presentation/bloc/notification_cubit/notification_cubit.dart';
import 'package:emp_system_sun/main.dart';
import 'auth_state.dart';

enum OtpMessagePurpose {
  verification,
  passwordReset,
}

String buildOtpMessage({
  required String otp,
  required String languageCode,
  required OtpMessagePurpose purpose,
}) {
  if (purpose == OtpMessagePurpose.passwordReset) {
    if (languageCode.toLowerCase() == 'ar') {
      return 'مرحبا بكم في صان، الرمز الخاص بكم لتغيير كلمة المرور هو $otp';
    }

    return 'Welcome to San, your password reset code is $otp';
  }

  return 'Your verification code is: $otp. '
      'Please do not share this code with anyone.';
}

class AuthCubit extends Cubit<AuthState> {
  AuthCubit({
    Future<LoginResult> Function({required LoginRequest loginRequest})?
        loginRequest,
    Future<UpdateUserResult> Function(
            {required CreateUserRequest createUserRequest})?
        updateRequest,
    Future<ChangePasswordResult> Function(
            {required ChangePasswordRequest changePasswordRequest})?
        passwordRequest,
    Future<String> Function()? tokenProvider,
    Future<void> Function(CreateUserRequest)? connectNotifications,
    Future<void> Function()? disconnectNotifications,
    Future<List<String>> Function(CreateUserRequest)? facilityCheck,
  })  : _loginRequest = loginRequest ?? loginFunction,
        _updateRequest = updateRequest ?? updateUserFunction,
        _passwordRequest = passwordRequest ?? changePasswordFunction,
        _tokenProvider = tokenProvider ??
            (() =>
                FcmService.instance.getToken(vapidKey: FcmConfig.webVapidKey)),
        _connectNotifications = connectNotifications ??
            ((user) => FcmService.instance.init(
                userId: user.userid ?? 0,
                userType: user.type ?? UserType.employeeUser)),
        _disconnectNotifications =
            disconnectNotifications ?? FcmService.instance.disconnect,
        _facilityCheck = facilityCheck,
        super(AuthInitial()) {
    _instances.add(this);
  }

  static final Set<AuthCubit> _instances = {};
  final Future<LoginResult> Function({required LoginRequest loginRequest})
      _loginRequest;
  final Future<UpdateUserResult> Function(
      {required CreateUserRequest createUserRequest}) _updateRequest;
  final Future<ChangePasswordResult> Function(
      {required ChangePasswordRequest changePasswordRequest}) _passwordRequest;
  final Future<String> Function() _tokenProvider;
  final Future<void> Function(CreateUserRequest) _connectNotifications;
  final Future<void> Function() _disconnectNotifications;
  final Future<List<String>> Function(CreateUserRequest)? _facilityCheck;
  Future<void>? _logoutFuture;

  bool _isCurrent(int version) => !isClosed && AuthSession.isCurrent(version);

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
    if (isClosed) return;
    final version = AuthSession.beginAttempt();
    emit(AuthLoading());
    await AuthSession.ready;
    if (!_isCurrent(version)) return;
    try {
      final saved = await AuthLocalStorage.getSession();
      if (!_isCurrent(version)) return;
      if (saved == null || (saved.user.email?.trim().isEmpty ?? true)) {
        await _forceLogout();
        return;
      }
      await _login(
        LoginRequest(
            user: saved.user.email!,
            password: saved.password,
            type: UserType.employeeUser),
        version,
        automatic: true,
      );
    } catch (_) {
      if (_isCurrent(version)) await _forceLogout();
    }
  }

  Future<void> login(LoginRequest request) async {
    if (isClosed) return;
    final version = AuthSession.beginAttempt();
    try {
      await AuthSession.ready;
    } catch (_) {
      return; // Cleanup must succeed before another account may log in.
    }
    if (!_isCurrent(version)) return;
    emit(AuthLoginLoading());
    await _login(request, version, automatic: false);
  }

  Future<void> _login(LoginRequest request, int version,
      {required bool automatic}) async {
    try {
      final token = await _tokenProvider();
      if (!_isCurrent(version)) return;
      final result = await _loginRequest(
          loginRequest: LoginRequest(
        user: request.user,
        password: request.password,
        type: UserType.employeeUser,
        fcmToken: token.isNotEmpty ? token : null,
      ));
      if (!_isCurrent(version)) return;
      if (!result.success || result.user == null) {
        if (automatic) {
          await _forceLogout();
        } else {
          emit(AuthLoginError(result.message));
        }
        return;
      }
      final user = result.user!;
      final saved = await AuthLocalStorage.saveSession(
        user: user,
        password: request.password,
        version: version,
      );
      if (!saved || !_isCurrent(version)) return;
      await AuthSession.runEffect(() async {
        if (!_isCurrent(version)) return;
        try {
          await _connectNotifications(user);
        } catch (e) {
          debugPrint('FCM Init note: $e');
        }
      });
      if (!_isCurrent(version)) return;
      if (!automatic) emit(AuthLoginSuccess(message: result.message));
      await _checkFacilityCompletion(user, version);
      if (!_isCurrent(version)) return;
      final ctx = navigatorKey.currentContext;
      if (ctx != null && ctx.mounted) {
        try {
          unawaited(BlocProvider.of<NotificationCubit>(ctx, listen: false)
              .getUserNotification());
        } catch (_) {}
      }
    } catch (e) {
      if (!_isCurrent(version)) return;
      if (automatic) {
        await _forceLogout();
      } else {
        emit(AuthLoginError(e.toString()));
      }
    }
  }

  void _resetTemporaryData() {
    _timer?.cancel();
    _timer = null;
    phoneNumber = '';
    verificationEmail = verificationPhone = null;
    otpCode = '';
    secondsRemaining = 30;
    isOtpError = isOtpSubmitting = isOtpResending = false;
    _pendingSignup = null;
    _isChangingPassword = false;
    isPasswordVisible = isConfirmPasswordVisible = false;
    _isConfirmPasswordObscure = true;
    _otpMessagePurpose = OtpMessagePurpose.verification;
    _otpLanguageCode = 'en';
  }

  Future<void> _forceLogout([NavigatorState? navigator]) async {
    if (_logoutFuture != null) return _logoutFuture!;
    final cleanup = AuthSession.endSession(() async {
      // Clear credentials even when notification teardown fails.
      await AuthLocalStorage.clearSession();
      NotificationUpdates.instance.reset();
      ChatEvents.instance.clearActiveHarages();
      ChatEvents.instance.activeChatUserId = null;
      ChatEvents.instance.activeChatUserType = null;
      if (getIt.isRegistered<EmployeeChatCubit>()) {
        getIt<EmployeeChatCubit>().reset();
      }
      try {
        await _disconnectNotifications();
      } catch (e) {
        debugPrint('FCM disconnect: $e');
      }
      final ctx = navigatorKey.currentContext;
      if (ctx != null && ctx.mounted) {
        try {
          BlocProvider.of<NotificationCubit>(ctx, listen: false).reset();
        } catch (_) {}
      }
      appPages.clear();
      if (getIt.isRegistered<EmployeeServicesCubit>()) {
        getIt<EmployeeServicesCubit>().reset();
      }
      if (getIt.isRegistered<AppCubit>()) {
        await getIt<AppCubit>().resetSession();
      }
    });
    _logoutFuture = cleanup;
    for (final cubit in _instances) {
      cubit._resetTemporaryData();
    }
    try {
      await cleanup;
      if (isClosed) return;
      final rootNavigator = navigator ?? navigatorKey.currentState;
      if (rootNavigator?.mounted == true) {
        rootNavigator!.popUntil((route) => route.isFirst);
      }
      emit(AuthUnauthenticated());
    } catch (e) {
      if (!isClosed) emit(AuthLogoutError(e.toString()));
    } finally {
      _logoutFuture = null;
    }
  }

  Future<void> logout([BuildContext? context]) async {
    if (isClosed || _logoutFuture != null) return;
    final navigator =
        context == null ? null : Navigator.of(context, rootNavigator: true);
    emit(AuthLoading());
    await _forceLogout(navigator);
  }

  Future<void> _checkFacilityCompletion(
      CreateUserRequest user, int version) async {
    List<String> missing;
    if (_facilityCheck != null) {
      missing = await _facilityCheck(user);
    } else {
      final branchCubit = BranchCubit();
      final workTimeCubit = UpdateWorkTimeCubit();
      try {
        await Future.wait([
          branchCubit.getProviderBranches(),
          workTimeCubit.getWorkTimes(),
        ]);
        if (!_isCurrent(version)) return;
        missing = FacilityValidator.validate(
          user: user,
          branchCubit: branchCubit,
          workTimeCubit: workTimeCubit,
        ).missingFields;
      } finally {
        await branchCubit.close();
        await workTimeCubit.close();
      }
    }
    if (!_isCurrent(version)) return;
    emit(
        missing.isEmpty ? AuthAuthenticated() : AuthIncompleteProfile(missing));
  }

  Future<void> reCheckFacility() async {
    final version = AuthSession.version;
    final user = await AuthLocalStorage.getUser();
    if (!_isCurrent(version)) return;
    if (user == null) {
      await _forceLogout();
      return;
    }
    await _checkFacilityCompletion(user, version);
  }

  Future<void> checkAuth() async {
    final version = AuthSession.version;
    final loggedIn = await AuthLocalStorage.isLoggedIn();
    if (!_isCurrent(version) || _logoutFuture != null) return;
    if (state is AuthUpdateLoading || state is AuthUpdateSuccess) return;
    if (loggedIn) {
      if (state is! AuthAuthenticated) await reCheckFacility();
    } else {
      emit(AuthUnauthenticated());
    }
  }

  Future<void> updateUser(
    CreateUserRequest request,
  ) async {
    if (isClosed) return;

    final version = AuthSession.version;

    emit(AuthUpdateLoading());

    try {
      final oldUser = await AuthLocalStorage.getUser();
      if (!_isCurrent(version)) return;

      if (oldUser == null) {
        emit(
          AuthUpdateError('User not found'),
        );
        return;
      }

      // =========================================================
      // EMPLOYEE MERGE
      // =========================================================

      final oldEmployee = oldUser.employeeDetails;
      final newEmployee = request.employeeDetails;

      final EmployeeWrapperRequest? mergedEmployee = newEmployee != null
          ? EmployeeWrapperRequest(
              employeeDetails: newEmployee.employeeDetails != null
                  ? EmployeeDetailsRequest(
                      id: newEmployee.employeeDetails?.id ??
                          oldEmployee?.employeeDetails?.id,
                      provid: newEmployee.employeeDetails?.provid ??
                          oldEmployee?.employeeDetails?.provid,
                      jobname: newEmployee.employeeDetails?.jobname ??
                          oldEmployee?.employeeDetails?.jobname,
                      joblatinname: newEmployee.employeeDetails?.joblatinname ??
                          oldEmployee?.employeeDetails?.joblatinname,
                      branchid: newEmployee.employeeDetails?.branchid ??
                          oldEmployee?.employeeDetails?.branchid,
                    )
                  : oldEmployee?.employeeDetails,

              // Keep old services if request doesn't provide them
              serviceIds: newEmployee.serviceIds.isNotEmpty
                  ? newEmployee.serviceIds
                  : oldEmployee?.serviceIds ?? const [],

              permissions: newEmployee.permissions ?? oldEmployee?.permissions,
            )
          : oldEmployee;

      // =========================================================
      // MERGED USER
      // =========================================================

      final mergedRequest = CreateUserRequest(
        userid: oldUser.userid,

        username: request.username ?? oldUser.username,

        phone: request.phone ?? oldUser.phone,

        email: request.email ?? oldUser.email,

        password: request.password ?? oldUser.password,

        birthDate: request.birthDate ?? oldUser.birthDate,

        // Keep original user type
        type: oldUser.type,

        nationality: request.nationality ?? oldUser.nationality,

        isActive: request.isActive ?? oldUser.isActive,

        joinDate: request.joinDate ?? oldUser.joinDate,

        referralCode: request.referralCode ?? oldUser.referralCode,

        image: request.image ?? oldUser.image,

        fcmToken: request.fcmToken ?? oldUser.fcmToken,

        currentCarId: request.currentCarId ?? oldUser.currentCarId,

        gander: request.gander ?? oldUser.gander,

        employeeDetails: mergedEmployee,

        providerDetails: request.providerDetails ?? oldUser.providerDetails,
        adminDetails: request.adminDetails ?? oldUser.adminDetails,
        companyDetails: request.companyDetails ?? oldUser.companyDetails,
        driverDetails: request.driverDetails ?? oldUser.driverDetails,
      );

      // =========================================================
      // API
      // =========================================================

      final result = await _updateRequest(
        createUserRequest: mergedRequest,
      );

      if (!_isCurrent(version)) return;

      if (result.success) {
        final saved = await AuthLocalStorage.updateSession(
          version: version,
          userId: oldUser.userid,
          user: mergedRequest,
        );
        if (!saved || !_isCurrent(version)) return;

        emit(
          AuthUpdateSuccess(
            result.message,
          ),
        );

        return;
      }

      emit(
        AuthUpdateError(
          result.message,
        ),
      );
    } catch (e) {
      if (!_isCurrent(version)) return;

      emit(
        AuthUpdateError(
          e.toString(),
        ),
      );
    }
  }

  String? verificationEmail;
  String? verificationPhone;

  String otpCode = "";

  Timer? _timer;
  int secondsRemaining = 30;

  bool isOtpError = false;
  bool isOtpSubmitting = false;
  bool isOtpResending = false;

  OtpMessagePurpose _otpMessagePurpose = OtpMessagePurpose.verification;
  String _otpLanguageCode = 'en';

  void startTimer() {
    final version = AuthSession.version;
    secondsRemaining = 30;

    _timer?.cancel();

    emit(AuthOtpTimer());

    _timer = Timer.periodic(
      const Duration(seconds: 1),
      (timer) {
        if (!_isCurrent(version)) {
          timer.cancel();
          return;
        }

        if (secondsRemaining <= 0) {
          timer.cancel();

          emit(AuthOtpExpired());
          return;
        }

        secondsRemaining--;

        emit(AuthOtpTimer());
      },
    );
  }

  void resetOtpError() {
    if (isClosed) return;

    if (isOtpError) {
      isOtpError = false;

      emit(
        AuthOtpReset(),
      );
    }
  }

  Future<void> validateOtp(String code) async {
    final version = AuthSession.version;
    if (!_isCurrent(version) || isOtpSubmitting) return;

    final enteredOtp = code.trim();

    if (enteredOtp.length != 4) {
      isOtpError = true;

      emit(
        AuthOtpError(
          AppLanguageKeys.wrongCode,
        ),
      );

      return;
    }

    if (enteredOtp != otpCode) {
      isOtpError = true;

      emit(
        AuthOtpError(
          AppLanguageKeys.wrongCode,
        ),
      );

      return;
    }

    // ==========================================
    // OTP CORRECT
    // ==========================================

    isOtpError = false;

    // SIGNUP
    if (_pendingSignup != null) {
      await completeSignupAfterOtp();
      return;
    }

    // FORGOT PASSWORD
    isOtpSubmitting = true;
    emit(AuthOtpVerifying());
    _timer?.cancel();
    isOtpSubmitting = false;
    emit(AuthOtpSuccess());
  }

  Future<void> resendOtp({String? languageCode}) async {
    final version = AuthSession.version;
    if (!_isCurrent(version) || isOtpResending) return;

    final phone = verificationPhone;

    if (phone == null || phone.trim().isEmpty) {
      emit(
        AuthOtpError(
          AppLanguageKeys.phoneNumberNotFound,
        ),
      );
      return;
    }

    final newOtp = (1000 + Random().nextInt(9000)).toString();
    final currentLanguageCode = languageCode ?? _otpLanguageCode;
    final message = buildOtpMessage(
      otp: newOtp,
      languageCode: currentLanguageCode,
      purpose: _otpMessagePurpose,
    );

    isOtpError = false;
    isOtpResending = true;
    emit(AuthOtpResendLoading());

    try {
      final result = await sendVerificationCodeFunction(
        request: SendVerificationCodeRequest(
          user: phone,
          message: message,
        ),
      );

      if (!_isCurrent(version)) return;

      if (result) {
        otpCode = newOtp;
        _otpLanguageCode = currentLanguageCode;
        isOtpResending = false;
        startTimer();

        emit(
          AuthOtpResendSuccess(),
        );
      } else {
        isOtpResending = false;

        emit(
          AuthOtpError(
            AppLanguageKeys.somethingWentWrong,
          ),
        );
      }
    } catch (e) {
      if (!_isCurrent(version)) return;

      isOtpResending = false;

      emit(
        AuthOtpError(
          e.toString(),
        ),
      );
    }
  }

  void updatePhone(String phone) {
    phoneNumber = phone;
    emit(AuthInitial());
  }

  Future<bool> sendOtp({
    required String email,
    required String phone,
    OtpMessagePurpose purpose = OtpMessagePurpose.verification,
    String languageCode = 'en',
  }) async {
    final version = AuthSession.version;
    if (!_isCurrent(version)) return false;

    verificationEmail = email.trim();
    verificationPhone = phone.trim();

    final random = Random();

    final newOtp = (1000 + random.nextInt(9000)).toString();

    final message = buildOtpMessage(
      otp: newOtp,
      languageCode: languageCode,
      purpose: purpose,
    );

    try {
      final sent = await _sendOtpToPhoneVariations(
        phone: phone.trim(),
        message: message,
      );

      if (!_isCurrent(version)) return false;

      if (!sent) {
        return false;
      }

      otpCode = newOtp;
      isOtpError = false;
      _otpMessagePurpose = purpose;
      _otpLanguageCode = languageCode;

      startTimer();

      return true;
    } catch (e) {
      if (!_isCurrent(version)) return false;

      return false;
    }
  }

  Future<void> checkIfUserExistOrNot({
    required String email,
    required String languageCode,
  }) async {
    final version = AuthSession.version;
    if (!_isCurrent(version)) return;

    emit(
      CheckIfUserExistOrNotLoading(),
    );

    try {
      final result = await checkIfUserExistOrNotFunction(
        request: CheckIfUserExistOrNotRequest(
          user: email,
          type: UserType.employeeUser,
        ),
      );

      if (!_isCurrent(version)) return;

      if (result == null || result.isEmpty) {
        emit(
          CheckIfUserExistOrNotError(
            AppLanguageKeys.userNotFound,
          ),
        );
        return;
      }

      final user = result.first;

      if (user.value != true) {
        emit(
          CheckIfUserExistOrNotNotFound(
            user,
          ),
        );
        return;
      }

      final phone = user.phone?.trim();

      if (phone == null || phone.isEmpty) {
        emit(
          CheckIfUserExistOrNotError(
            AppLanguageKeys.phoneNumberNotFoundForThisAccount,
          ),
        );
        return;
      }

      final sent = await sendOtp(
        email: email,
        phone: phone,
        purpose: OtpMessagePurpose.passwordReset,
        languageCode: languageCode,
      );

      if (!_isCurrent(version)) return;

      if (sent) {
        emit(
          CheckIfUserExistOrNotSuccess(
            user,
          ),
        );

        return;
      }

      emit(
        CheckIfUserExistOrNotError(
          AppLanguageKeys.failedToSendVerificationCode,
        ),
      );
    } catch (e) {
      if (!_isCurrent(version)) return;

      emit(
        CheckIfUserExistOrNotError(
          e.toString(),
        ),
      );
    }
  }

  List<String> _getPhoneVariations(String phone) {
    final original = phone.trim();

    final List<String> phones = [];

    // 1. Original
    phones.add(original);

    // 2. Remove 966
    if (original.startsWith('966')) {
      final without966 = original.substring(3);

      if (without966.isNotEmpty) {
        phones.add(without966);

        // 3. Remove 966 + add 0
        phones.add('0$without966');
      }
    }

    return phones.toSet().toList();
  }

  Future<bool> _sendOtpToPhoneVariations({
    required String phone,
    required String message,
  }) async {
    final version = AuthSession.version;
    final phones = _getPhoneVariations(phone);

    for (final phoneNumber in phones) {
      if (!_isCurrent(version)) return false;

      final result = await sendVerificationCodeFunction(
        request: SendVerificationCodeRequest(
          user: phoneNumber,
          message: message,
        ),
      );
      if (!_isCurrent(version)) return false;

      if (result) {
        verificationPhone = phoneNumber;
        return true;
      }
    }

    return false;
  }

  bool _isChangingPassword = false;

  Future<void> changePassword({
    required String user,
    required String password,
    bool updateStoredPassword = false,
  }) async {
    if (isClosed || _isChangingPassword) return;

    final version = AuthSession.version;

    _isChangingPassword = true;
    emit(ChangePasswordLoading());

    try {
      final savedUser =
          updateStoredPassword ? await AuthLocalStorage.getUser() : null;
      if (!_isCurrent(version)) return;
      final result = await _passwordRequest(
        changePasswordRequest: ChangePasswordRequest(
          user: user,
          password: password,
          type: UserType.employeeUser,
        ),
      );

      if (!AuthSession.isCurrent(version)) return;
      // A disposed password flow may still update its own session, but never
      // credentials from a later login (even another login to the same email).
      if (result.success && updateStoredPassword && savedUser != null) {
        await AuthLocalStorage.updateSession(
          version: version,
          userId: savedUser.userid,
          email: user,
          password: password,
        );
      }

      if (!_isCurrent(version)) return;

      if (result.success) {
        emit(
          ChangePasswordSuccess(
            result.message,
          ),
        );
      } else {
        emit(
          ChangePasswordError(
            result.message,
          ),
        );
      }
    } catch (e) {
      if (!_isCurrent(version)) return;

      emit(
        ChangePasswordError(
          e.toString(),
        ),
      );
    } finally {
      if (AuthSession.isCurrent(version)) _isChangingPassword = false;
    }
  }

  CreateUserRequest? _pendingSignup;

  CreateUserRequest? get pendingSignup => _pendingSignup;

  void clearPendingSignup() {
    _pendingSignup = null;
  }

  Future<void> signup(CreateUserRequest request) async {
    final version = AuthSession.version;
    if (!_isCurrent(version)) return;

    emit(AuthSignupLoading());

    try {
      // =========================================================
      // 1. GET & VALIDATE DATA
      // =========================================================

      final email = request.email?.trim() ?? '';
      final phone = request.phone?.trim() ?? '';

      if (email.isEmpty || phone.isEmpty) {
        emit(
          AuthSignupError(
            AppLanguageKeys.enterYourData,
          ),
        );
        return;
      }

      // =========================================================
      // 2. CHECK EMAIL FORMAT
      // =========================================================

      if (!isValidEmail(email)) {
        emit(
          AuthSignupError(
            AppLanguageKeys.pleaseEnterValidEmail,
          ),
        );
        return;
      }

      // =========================================================
      // 3. CHECK IF EMAIL ALREADY EXISTS
      // =========================================================

      print('=================================');
      print('CHECK SIGNUP EMAIL');
      print('EMAIL => $email');
      print('=================================');

      final existingUsers = await checkIfUserExistOrNotFunction(
        request: CheckIfUserExistOrNotRequest(
          user: email,
          type: UserType.employeeUser,
        ),
      );

      if (!_isCurrent(version)) return;

      print(
        'CHECK SIGNUP EMAIL RESULT => $existingUsers',
      );

      // =========================================================
      // 4. CHECK API RESULT
      // =========================================================

      if (existingUsers == null || existingUsers.isEmpty) {
        emit(
          AuthSignupError(
            AppLanguageKeys.somethingWentWrong,
          ),
        );
        return;
      }

      final user = existingUsers.first;

      print(
        'EMAIL EXISTS => ${user.value}',
      );

      // =========================================================
      // 5. EMAIL ALREADY EXISTS
      // =========================================================

      if (user.value == true) {
        emit(
          AuthSignupError(
            AppLanguageKeys.emailExist,
          ),
        );
        return;
      }

      // =========================================================
      // 6. EMAIL AVAILABLE
      // Save request BEFORE sending OTP
      // =========================================================

      _pendingSignup = request;

      // =========================================================
      // 7. SEND OTP
      // =========================================================

      final sent = await sendOtp(
        email: email,
        phone: phone,
      );

      if (!_isCurrent(version)) return;

      // =========================================================
      // 8. OTP FAILED
      // =========================================================

      if (!sent) {
        _pendingSignup = null;

        emit(
          AuthSignupError(
            AppLanguageKeys.failedToSendVerificationCode,
          ),
        );

        return;
      }

      // =========================================================
      // 9. OTP SENT SUCCESSFULLY
      // =========================================================

      emit(
        AuthSignupSuccess(
          AppLanguageKeys.verificationCodeSent,
        ),
      );
    } catch (e) {
      if (!_isCurrent(version)) return;

      _pendingSignup = null;

      print(
        'SIGNUP ERROR => $e',
      );

      emit(
        AuthSignupError(
          e.toString(),
        ),
      );
    }
  }

  Future<void> completeSignupAfterOtp() async {
    final version = AuthSession.version;
    if (!_isCurrent(version) || isOtpSubmitting) return;

    final request = _pendingSignup;

    if (request == null) {
      isOtpSubmitting = false;
      emit(
        AuthSignupError(
          AppLanguageKeys.somethingWentWrong,
        ),
      );
      return;
    }

    isOtpSubmitting = true;
    emit(AuthSignupLoading());

    try {
      final result = await createUserFunction(
        createUserRequest: request,
      );

      if (!_isCurrent(version)) return;

      if (!result.success) {
        isOtpSubmitting = false;
        emit(
          AuthSignupError(
            result.message,
          ),
        );
        return;
      }

      _pendingSignup = null;
      _timer?.cancel();
      isOtpSubmitting = false;

      emit(
        AuthSignupCompleted(
          result.message,
        ),
      );
    } catch (e) {
      if (!_isCurrent(version)) return;

      isOtpSubmitting = false;
      emit(
        AuthSignupError(
          e.toString(),
        ),
      );
    }
  }

  @override
  Future<void> close() {
    _timer?.cancel();
    _instances.remove(this);
    return super.close();
  }

// ================= Validators ================

  bool isValidEmail(String email) {
    final emailRegex = RegExp(
      r'^[\w\-.]+@([\w-]+\.)+[\w-]{2,4}$',
    );

    return emailRegex.hasMatch(email);
  }

// =========================================================
// SIGNUP EMPLOYEE
// Check Email + Phone -> Create User
// NO OTP
// =========================================================
}
