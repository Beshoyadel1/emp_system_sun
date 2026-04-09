import 'dart:convert';
import 'package:dio/dio.dart';
import '../../../../core/language/language_constant.dart';
import '../../../../core/api_functions/user/create_user_model/create_user_request.dart';
import '../../../../core/api/dio_function/api_constants.dart';
import '../../../../core/pages_widgets/general_widgets/snakbar.dart';
import '../../../../core/api/dio_function/dio_controller.dart';
import '../../../../core/api/dio_function/failures.dart';

Future<bool> createUserFunction({
  required CreateUserRequest createUserRequest,
}) async {
  try {
    String jsonString = json.encode(createUserRequest.toJson());

    final value = await Network.postDataWithBody(
      jsonString,
      ApiLink.createUser,
    );

    final body = value.data.toString().trim();

    if (body == "Done") {
      AppSnackBar.showSuccess(
        AppLanguageKeys.accountCreatedSuccessfully,
      );
      return true;
    }

    if (body == "EmailExist") {
      AppSnackBar.showError(
        AppLanguageKeys.emailExist,
      );
      return false;
    }
    if (body == "PhoneExist") {
      AppSnackBar.showError(
        AppLanguageKeys.phoneExist,
      );
      return false;
    }
    AppSnackBar.showError(
      AppLanguageKeys.somethingWentWrong,
    );
    return false;

  } catch (e) {
    AppSnackBar.showError(
      e is DioException
          ? responseOfStatusCode(e.response?.statusCode)
          : e.toString(),
    );
    return false;
  }
}
