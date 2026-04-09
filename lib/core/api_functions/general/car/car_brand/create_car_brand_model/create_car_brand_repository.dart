import 'dart:convert';
import 'package:dio/dio.dart';
import '../../../../../../core/api/dio_function/api_constants.dart';
import '../../../../../../core/api/dio_function/dio_controller.dart';
import '../../../../../../core/api/dio_function/failures.dart';
import '../../../../../../core/language/language_constant.dart';
import '../../../../../../core/api_functions/general/car/car_brand/create_car_brand_model/create_car_brand_request.dart';
import '../../../../../../core/pages_widgets/general_widgets/snakbar.dart';

Future<void> createCarBrandFunction({required CreateCarBrandRequest createCarBrandRequest}) async {
  try {
    String jsonString = json.encode(createCarBrandRequest.toJson());

    await Network.postDataWithBody(
      jsonString,
      ApiLink.createCarBrand,
    ).then((value) {
      AppSnackBar.showSuccess(AppLanguageKeys.createCarBrandSuccessfully);
    });

  } catch (e) {
    AppSnackBar.showError(
      e is DioException
          ? responseOfStatusCode(e.response?.statusCode)
          : e.toString(),
    );
  }
}

