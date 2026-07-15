import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../../../core/theming/secure_storage.dart';
import '../../../../../core/api/dio_function/api_constants.dart';
import '../../../../../core/api/dio_function/dio_controller.dart';
import '../../../../../core/api/dio_function/failures.dart';
import '../../../../../core/language/language_constant.dart';
import '../../../../../features/auth_page/data/model/create_user_model/create_user_request.dart';
import '../../../../../features/auth_page/data/model/login_model/login_result.dart';
import '../../request/login_request/login_request.dart';

class AuthLocalStorage {
  static const String userKey = "user_data";
  static Future<void> saveUser(CreateUserRequest user) async {
    final prefs = await SharedPreferences.getInstance();
    final jsonString = json.encode(user.toJson());

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

    return data != null && data.isNotEmpty;
  }

  static Future<void> clearUser() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(userKey);
  }
}


Future<LoginResult> loginFunction({
  required LoginRequest loginRequest,
}) async {

  try {

    final response = await Network.postDataWithBody(
      json.encode(
        loginRequest.toJson(),
      ),
      ApiLink.loginUser,
    );

    final Map<String, dynamic> body =
        response.data;

    final bool success =
        body["success"] ?? false;

    final String message =
        body["message"] ??
            (
                success
                    ? AppLanguageKeys.accountLoginSuccessfully
                    : AppLanguageKeys.loginFailed
            );

    if (!success) {

      return LoginResult(
        success: false,
        message: message,
      );
    }

    final List data =
        body["data"] ?? [];

    if (data.isEmpty) {

      return LoginResult(
        success: false,
        message: "لا يوجد بيانات مستخدم",
      );
    }

    final user =
    CreateUserRequest.fromJson(
      data.first,
    );

    await AuthLocalStorage.saveUser(
      user,
    );
    await SecureStorage.savePassword(
      loginRequest.password,
    );

    return LoginResult(
      success: true,
      message: message,
      user: user,
    );

  } on DioException catch (e) {

    String errorMessage =
        AppLanguageKeys.somethingWentWrong;

    if (e.response?.data != null) {

      final data = e.response?.data;

      if (data is Map<String, dynamic>) {

        errorMessage =
            data["message"] ??
                responseOfStatusCode(
                  e.response?.statusCode,
                );
      }
    }

    return LoginResult(
      success: false,
      message: errorMessage,
    );

  } catch (e) {

    return LoginResult(
      success: false,
      message: e.toString(),
    );
  }
}