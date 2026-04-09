import 'dart:convert';
import 'package:dio/dio.dart';
import '../../../../core/language/language_constant.dart';
import '../../../../core/api_functions/user/change_password_model/change_password_request.dart';
import '../../../../core/api/dio_function/api_constants.dart';
import '../../../../core/pages_widgets/general_widgets/snakbar.dart';
import '../../../../core/api/dio_function/dio_controller.dart';
import '../../../../core/api/dio_function/failures.dart';


Future<bool> changePasswordFunction({required ChangePasswordRequest changePasswordRequest}) async {
  try {
    String jsonString = json.encode(changePasswordRequest.toJson());

    final value=await Network.postDataWithBody(
      jsonString,
      ApiLink.changePassword,
    );
    final body = value.data.toString().trim();
    if (body == "Done") {
      AppSnackBar.showSuccess(AppLanguageKeys.changePasswordSuccessfully);
      return true;
    }
    else if (body == "No User") {
      AppSnackBar.showError(AppLanguageKeys.noUser);
      return false;
    }
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