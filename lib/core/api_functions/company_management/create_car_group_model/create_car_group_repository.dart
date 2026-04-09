import 'dart:convert';
import 'package:dio/dio.dart';
import '../../../../core/language/language_constant.dart';
import '../../../../core/api_functions/company_management/create_car_group_model/create_car_group_request.dart';
import '../../../../core/api/dio_function/api_constants.dart';
import '../../../../core/pages_widgets/general_widgets/snakbar.dart';
import '../../../../core/api/dio_function/dio_controller.dart';
import '../../../../core/api/dio_function/failures.dart';

Future<void> createCarGroupFunction({required CreateCarGroupRequest createCarGroupRequest}) async {
  try {
    String jsonString = json.encode(createCarGroupRequest.toJson());

    await Network.postDataWithBody(
      jsonString,
      ApiLink.createCarGroup,
    ).then((value) {
      AppSnackBar.showSuccess(AppLanguageKeys.createCarGroupSuccessfully);
    });

  } catch (e) {
    AppSnackBar.showError(
      e is DioException
          ? responseOfStatusCode(e.response?.statusCode)
          : e.toString(),
    );
  }
}