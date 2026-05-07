import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import '../../../../../../core/api_functions/user/create_user_model/create_user_request.dart';
import '../../../../core/api/dio_function/api_constants.dart';
import '../../../../core/pages_widgets/general_widgets/snakbar.dart';
import '../../../../core/api/dio_function/dio_controller.dart';
import '../../../../core/api/dio_function/failures.dart';
import '../../../../core/language/language_constant.dart';

Future<bool> updateUserFunction({
  required CreateUserRequest createUserRequest,
}) async {
  try {
    final jsonMap = createUserRequest.toJson();
    final jsonString = json.encode(jsonMap);

    final response = await Network.postDataWithBody(
      jsonString,
      ApiLink.updateUser,
    );

    final body = response.data.toString().trim();

    if (body == "Done") {
      // AppSnackBar.showSuccess(
      //   AppLanguageKeys.accountCreatedSuccessfully,
      // );
      return true;
    }

    if (body == "EmailExist") {
      AppSnackBar.showError(AppLanguageKeys.emailExist);
      return false;
    }

    if (body == "PhoneExist") {
      AppSnackBar.showError(AppLanguageKeys.phoneExist);
      return false;
    }

    debugPrint("❌ Unknown response: $body");

    AppSnackBar.showError(AppLanguageKeys.somethingWentWrong);
    return false;

  } catch (e, stackTrace) {
    debugPrint("❌ UPDATE USER ERROR:");
    debugPrint(e.toString());
    debugPrint(stackTrace.toString());

    AppSnackBar.showError(
      e is DioException
          ? responseOfStatusCode(e.response?.statusCode)
          : e.toString(),
    );

    return false;
  }
}
