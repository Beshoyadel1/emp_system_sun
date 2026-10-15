import 'dart:convert';
import 'package:dio/dio.dart';
import '../../../../../core/api/dio_function/api_constants.dart';
import '../../../../../core/api/dio_function/dio_controller.dart';
import '../../../../../core/api/dio_function/failures.dart';
import '../../../../../core/language/language_constant.dart';
import '../../../../../features/auth_page/data/model/create_user_model/create_user_request.dart';
import '../../../../../features/auth_page/data/model/login_model/login_result.dart';
import '../../request/login_request/login_request.dart';


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
        body["success"] ?? body["status"] ?? false;

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

    final rawData = body["data"];
    final List data = rawData is List ? rawData : (rawData is Map ? [rawData] : []);

    if (data.isEmpty) {

      return LoginResult(
        success: false,
        message: AppLanguageKeys.noUserData,
      );
    }

    final user =
    CreateUserRequest.fromJson(
      data.first,
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
