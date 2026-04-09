import 'dart:convert';
import 'package:dio/dio.dart';
import '../../../../core/api_functions/rates/create_rate_model/create_rate_request.dart';
import '../../../../core/api/dio_function/api_constants.dart';
import '../../../../core/pages_widgets/general_widgets/snakbar.dart';
import '../../../../core/api/dio_function/dio_controller.dart';
import '../../../../core/api/dio_function/failures.dart';
import '../../../../core/language/language_constant.dart';

Future<void> createRateFunction({required CreateRateRequest createRateRequest}) async {
  try {
    String jsonString = json.encode(createRateRequest.toJson());

    await Network.postDataWithBody(
      jsonString,
      ApiLink.createRate,
    ).then((value) {
      AppSnackBar.showSuccess(AppLanguageKeys.createRateSuccessfully);
    });

  } catch (e) {
    AppSnackBar.showError(
      e is DioException
          ? responseOfStatusCode(e.response?.statusCode)
          : e.toString(),
    );
  }
}