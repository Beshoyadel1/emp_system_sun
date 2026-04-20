import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../../../../core/api_functions/user/create_user_model/create_user_request.dart';
import '../../../../core/language/language_constant.dart';
import '../../../../core/api/dio_function/failures.dart';
import '../../../../core/api_functions/user/login_model/login_request.dart';
import '../../../../core/api/dio_function/api_constants.dart';
import '../../../../core/pages_widgets/general_widgets/snakbar.dart';
import '../../../../core/api/dio_function/dio_controller.dart';


class AuthLocalStorage {
  static const String userKey = "user_data";

  static Future<void> saveUser(CreateUserRequest user) async {
    final prefs = await SharedPreferences.getInstance();
    final jsonString = json.encode(user.toJson());

    //print("SAVING USER: $jsonString");

    await prefs.setString(userKey, jsonString);
  }

  static Future<CreateUserRequest?> getUser() async {
    final prefs = await SharedPreferences.getInstance();
    final data = prefs.getString(userKey);

   // print("STORED USER: $data");

    if (data == null || data.isEmpty) return null;

    return CreateUserRequest.fromJson(json.decode(data));
  }

  static Future<bool> isLoggedIn() async {
    final prefs = await SharedPreferences.getInstance();
    final data = prefs.getString(userKey);

    //print("CHECK RAW DATA: $data");

    return data != null && data.isNotEmpty;
  }

  static Future<void> clearUser() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(userKey);
  }
}

Future<CreateUserRequest?> loginFunction({
  required LoginRequest loginRequest,
}) async {
  try {
    final response = await Network.postDataWithBody(
      json.encode(loginRequest.toJson()),
      ApiLink.loginUser,
    );

    final data = response.data;

    if (data is String) {
      if (data == "Wrong Password") {
        AppSnackBar.showError(AppLanguageKeys.wrongPasswordKey);
        return null;
      }

      if (data == "No User") {
        AppSnackBar.showError(AppLanguageKeys.wrongUsername);
        return null;
      }
    }

    if (data is List && data.isNotEmpty) {
      final user = CreateUserRequest.fromJson(data.first);

      await AuthLocalStorage.saveUser(user);
      //print("USER SAVED ✅");

      // AppSnackBar.showSuccess(
      //   AppLanguageKeys.accountLoginSuccessfully,
      // );

      return user;
    }

    AppSnackBar.showError("Unexpected response");
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