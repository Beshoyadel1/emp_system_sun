import 'dart:convert';
import 'package:dio/dio.dart';
import '../../../../core/api_functions/harage/update_harage_model/update_harage_request.dart';
import '../../../../core/api/dio_function/api_constants.dart';
import '../../../../core/pages_widgets/general_widgets/snakbar.dart';
import '../../../../core/api/dio_function/dio_controller.dart';
import '../../../../core/api/dio_function/failures.dart';
import '../../../../core/language/language_constant.dart';

Future<void> updateHarageFunction({required UpdateHarageRequest updateHarageRequest}) async {
  try {
    String jsonString = json.encode(updateHarageRequest.toJson());

    await Network.postDataWithBody(
      jsonString,
      ApiLink.updateHarage,
    ).then((value) {
      AppSnackBar.showSuccess(AppLanguageKeys.updateHarageSuccessfully);
    });

  } catch (e) {
    AppSnackBar.showError(
      e is DioException
          ? responseOfStatusCode(e.response?.statusCode)
          : e.toString(),
    );
  }
}