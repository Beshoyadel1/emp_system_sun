import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:emp_system_sun/core/api_functions/user/create_user_model/create_user_request.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../../core/language/language_constant.dart';
import '../../../../core/api/dio_function/failures.dart';
import '../../../../core/api_functions/user/login_model/login_request.dart';
import '../../../../core/api/dio_function/api_constants.dart';
import '../../../../core/pages_widgets/general_widgets/snakbar.dart';
import '../../../../core/api/dio_function/dio_controller.dart';

class AuthLocalStorage {
  static const String userKey = "user_data";

  /// ✅ Save user
  static Future<void> saveUser(CreateUserRequest user) async {
    final prefs = await SharedPreferences.getInstance();

    final jsonString = jsonEncode(user.toJson());

    await prefs.setString(userKey, jsonString);
  }

  /// ✅ Get user
  static Future<CreateUserRequest?> getUser() async {
    final prefs = await SharedPreferences.getInstance();

    final data = prefs.getString(userKey);

    if (data == null) return null;

    final jsonMap = jsonDecode(data);

    return CreateUserRequest.fromJson(jsonMap);
  }

  /// ✅ Clear
  static Future<void> clearUser() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(userKey);
  }
}

Future<CreateUserRequest?> loginFunction({
  required LoginRequest loginRequest,
}) async {
  try {
    String jsonString = json.encode(loginRequest.toJson());

    final response = await Network.postDataWithBody(
      jsonString,
      ApiLink.loginUser,
    );

    final data = response.data;

    if (data is String && data == "Wrong Password") {
      AppSnackBar.showError(AppLanguageKeys.wrongPasswordKey);
      return null;
    }

    if (data is String && data == "No User") {
      AppSnackBar.showError(AppLanguageKeys.wrongUsername);
      return null;
    }

    /// ✅ success
    if (data is List && data.isNotEmpty) {
      final user = CreateUserRequest.fromJson(data.first);

      // /// 🔥 DEBUG مهم
      // print("LOGIN RESPONSE: ${jsonEncode(data.first)}");

      /// 🔥 SAVE USER
      await AuthLocalStorage.saveUser(user);
      //
      // /// 🔥 CHECK DATA
      // print("ProviderId: ${user.employeeWrapper?.employeeDetails?.provid}");
      // print("EmployeeId: ${user.employeeWrapper?.employeeDetails?.id}");

      AppSnackBar.showSuccess(
        AppLanguageKeys.accountLoginSuccessfully,
      );

      return user;
    }

    return null;
  } catch (e) {
    AppSnackBar.showError(
      e is DioException
          ? responseOfStatusCode(e.response?.statusCode)
          : e.toString(),
    );
    return null;
  }
}