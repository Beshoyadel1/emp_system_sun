import 'dart:convert';
import 'package:dio/dio.dart';
import '../../../../../../core/api_functions/general/car/car_model/create_car_model/create_car_model_request.dart';
import '../../../../../../core/api/dio_function/api_constants.dart';
import '../../../../../../core/api/dio_function/dio_controller.dart';
import '../../../../../../core/api/dio_function/failures.dart';
import '../../../../../../core/language/language_constant.dart';
import '../../../../../../core/pages_widgets/general_widgets/snakbar.dart';

Future<void> createCarModelFunction({required CreateCarModelRequest createCarModelRequest}) async {
  try {
    String jsonString = json.encode(createCarModelRequest.toJson());

    await Network.postDataWithBody(
      jsonString,
      ApiLink.createCarModel,
    ).then((value) {
      AppSnackBar.showSuccess(AppLanguageKeys.createCarModelSuccessfully);
    });

  } catch (e) {
    AppSnackBar.showError(
      e is DioException
          ? responseOfStatusCode(e.response?.statusCode)
          : e.toString(),
    );
  }
}

