import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:emp_system_sun/features/auth_page/data/model/create_user_model/create_user_request.dart';
import 'package:flutter/cupertino.dart';
import '../../../../../core/api/dio_function/api_constants.dart';
import '../../../../../core/pages_widgets/general_widgets/snakbar.dart';
import '../../../../../core/api/dio_function/dio_controller.dart';
import '../../../../../core/api/dio_function/failures.dart';
import '../../../../../core/language/language_constant.dart';

Future<bool> updateUserFunction({
  required CreateUserRequest createUserRequest,
}) async {
  try {
    print("URL => ${ApiLink.updateUser}");
    print("BODY => ${createUserRequest.toJson()}");

    final response = await Network.postDataWithBody(
      createUserRequest.toJson(),
      ApiLink.updateUser,
    );

    print("STATUS => ${response.statusCode}");
    print("URI => ${response.realUri}");
    print("HEADERS => ${response.headers.map}");
    print("DATA => ${response.data}");

    final body = response.data.toString().trim();

    if (body == "Done") {
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

  } on DioException catch (e, stackTrace) {

    print("❌ DIO ERROR");
    print("MESSAGE => ${e.message}");
    print("STATUS => ${e.response?.statusCode}");
    print("REAL URI => ${e.response?.realUri}");
    print("HEADERS => ${e.response?.headers.map}");
    print("DATA => ${e.response?.data}");

    debugPrint(stackTrace.toString());

    AppSnackBar.showError(
      responseOfStatusCode(e.response?.statusCode),
    );

    return false;
  } catch (e, stackTrace) {

    debugPrint(stackTrace.toString());

    AppSnackBar.showError(e.toString());

    return false;
  }
}