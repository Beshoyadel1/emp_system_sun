import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:emp_system_sun/features/auth_page/data/model/create_user_model/create_user_request.dart';
import 'package:flutter/cupertino.dart';
import '../../../../../core/api/dio_function/api_constants.dart';
import '../../../../../core/pages_widgets/general_widgets/snakbar.dart';
import '../../../../../core/api/dio_function/dio_controller.dart';
import '../../../../../core/api/dio_function/failures.dart';
import '../../../../../core/language/language_constant.dart';

class UpdateUserResult {
  final bool success;

  final String message;

  const UpdateUserResult({
    required this.success,
    required this.message,
  });
}
Future<UpdateUserResult> updateUserFunction({
  required CreateUserRequest createUserRequest,
}) async {

  try {

    final response = await Network.postDataWithBody(
      createUserRequest.toJson(),
      ApiLink.updateUser,
    );
    final Map<String, dynamic> body =
        response.data;

    final bool success =
        body["success"] ?? false;

    final String message =
        body["message"] ??
            AppLanguageKeys.somethingWentWrong;

    return UpdateUserResult(
      success: success,
      message: message,
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

    return UpdateUserResult(
      success: false,
      message: errorMessage,
    );

  } catch (e) {

    print("🔥 ERROR => $e");

    return UpdateUserResult(
      success: false,
      message: e.toString(),
    );
  }
}