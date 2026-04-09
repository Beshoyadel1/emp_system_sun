import 'dart:convert';
import 'package:dio/dio.dart';
import '../../../../core/api_functions/rates/update_rate_model/update_rate_request.dart';
import '../../../../core/api/dio_function/api_constants.dart';
import '../../../../core/pages_widgets/general_widgets/snakbar.dart';
import '../../../../core/api/dio_function/dio_controller.dart';
import '../../../../core/api/dio_function/failures.dart';
import '../../../../core/language/language_constant.dart';

Future<void> updateRateFunction({required UpdateRateRequest updateRateRequest}) async {
  try {
    String jsonString = json.encode(updateRateRequest.toJson());

    await Network.postDataWithBody(
      jsonString,
      ApiLink.updateRate,
    ).then((value) {
      AppSnackBar.showSuccess(AppLanguageKeys.updateRateSuccessfully);
    });

  } catch (e) {
    AppSnackBar.showError(
      e is DioException
          ? responseOfStatusCode(e.response?.statusCode)
          : e.toString(),
    );
  }
}