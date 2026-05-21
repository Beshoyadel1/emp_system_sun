import 'dart:convert';
import 'package:dio/dio.dart';
import '../../model/create_user_model/create_user_request.dart';
import '../../../../../core/api/dio_function/api_constants.dart';
import '../../../../../core/api/dio_function/dio_controller.dart';
import '../../../../../core/api/dio_function/failures.dart';


class CreateUserResult {

  final bool success;
  final String message;

  CreateUserResult({
    required this.success,
    required this.message,
  });
}

Future<CreateUserResult> createUserFunction({
  required CreateUserRequest createUserRequest,
}) async {

  try {

    String jsonString = json.encode(
      createUserRequest.toJson(),
    );

    final response = await Network.postDataWithBody(
      jsonString,
      ApiLink.createUser,
    );

    final Map<String, dynamic> body = response.data;

    return CreateUserResult(
      success: body["success"] ?? false,
      message: body["message"] ?? "",
    );

  } on DioException catch (e) {

    String errorMessage = "حدث خطأ ما";

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

    return CreateUserResult(
      success: false,
      message: errorMessage,
    );

  } catch (e) {

    return CreateUserResult(
      success: false,
      message: e.toString(),
    );
  }
}