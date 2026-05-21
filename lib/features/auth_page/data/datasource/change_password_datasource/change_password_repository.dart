import 'dart:convert';
import 'package:dio/dio.dart';
import '../../../../../core/language/language_constant.dart';
import '../../request/change_password_request/change_password_request.dart';
import '../../../../../core/api/dio_function/api_constants.dart';
import '../../../../../core/pages_widgets/general_widgets/snakbar.dart';
import '../../../../../core/api/dio_function/dio_controller.dart';
import '../../../../../core/api/dio_function/failures.dart';

class ChangePasswordResult {

  final bool success;

  final String message;

  ChangePasswordResult({
    required this.success,
    required this.message,
  });
}
Future<ChangePasswordResult>
changePasswordFunction({
  required ChangePasswordRequest
  changePasswordRequest,
}) async {

  try {

    final response =
    await Network.postDataWithBody(

      changePasswordRequest.toJson(),

      ApiLink.changePassword,
    );

    final responseData =
        response.data;

    final bool success =
        responseData["success"] ?? false;

    final String message =
        responseData["message"] ??
            AppLanguageKeys
                .somethingWentWrong;

    return ChangePasswordResult(
      success: success,
      message: message,
    );

  } catch (e) {

    return ChangePasswordResult(

      success: false,

      message:

      e is DioException

          ? responseOfStatusCode(
        e.response?.statusCode,
      )

          : e.toString(),
    );
  }
}