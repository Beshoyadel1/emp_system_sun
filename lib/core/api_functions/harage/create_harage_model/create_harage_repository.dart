import 'dart:convert';
import 'package:dio/dio.dart';
import '../../../../core/api_functions/harage/create_harage_model/create_harage_request.dart';
import '../../../../core/api/dio_function/api_constants.dart';
import '../../../../core/pages_widgets/general_widgets/snakbar.dart';
import '../../../../core/api/dio_function/dio_controller.dart';
import '../../../../core/api/dio_function/failures.dart';
import '../../../../core/language/language_constant.dart';


Future<void> createHarageFunction({required CreateHarageRequest createHarageRequest}) async {
  try {
    String jsonString = json.encode(createHarageRequest.toJson());

    await Network.postDataWithBody(
      jsonString,
        ApiLink.createHarage
    ).then((value) {
      AppSnackBar.showSuccess(AppLanguageKeys.createHarageSuccessfully);
    });

  } catch (e) {
    AppSnackBar.showError(
      e is DioException
          ? responseOfStatusCode(e.response?.statusCode)
          : e.toString(),
    );
  }
}

