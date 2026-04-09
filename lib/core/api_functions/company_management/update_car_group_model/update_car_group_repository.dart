import 'dart:convert';
import 'package:dio/dio.dart';
import '../../../../core/api_functions/company_management/update_car_group_model/update_car_group_request.dart';
import '../../../../core/api/dio_function/api_constants.dart';
import '../../../../core/pages_widgets/general_widgets/snakbar.dart';
import '../../../../core/api/dio_function/dio_controller.dart';
import '../../../../core/api/dio_function/failures.dart';
import '../../../../core/language/language_constant.dart';


Future<void> updateCarGroupFunction({required UpdateCarGroupRequest updateCarGroupRequest}) async {
  try {
    String jsonString = json.encode(updateCarGroupRequest.toJson());

    await Network.postDataWithBody(
      jsonString,
      ApiLink.updateCarGroup,
    ).then((value) {
      AppSnackBar.showSuccess(AppLanguageKeys.updateCarGroupSuccessfully);
    });

  } catch (e) {
    AppSnackBar.showError(
      e is DioException
          ? responseOfStatusCode(e.response?.statusCode)
          : e.toString(),
    );
  }
}