import 'dart:convert';
import 'package:dio/dio.dart';
import '../../../../core/api_functions/user/update_user_model/update_user_request.dart';
import '../../../../core/api/dio_function/api_constants.dart';
import '../../../../core/pages_widgets/general_widgets/snakbar.dart';
import '../../../../core/api/dio_function/dio_controller.dart';
import '../../../../core/api/dio_function/failures.dart';
import '../../../../core/language/language_constant.dart';

Future<void> updateUserFunction({required UpdateUserRequest updateUserRequest}) async {
  try {
    String jsonString = json.encode(updateUserRequest.toJson());
    await Network.postDataWithBody(
      jsonString,
        ApiLink.updateUser,
    ).then((value) {
      AppSnackBar.showSuccess(AppLanguageKeys.updateUserSuccessfully);
    });

  } catch (e) {
    AppSnackBar.showError(
      e is DioException
          ? responseOfStatusCode(e.response?.statusCode)
          : e.toString(),
    );
  }
}

