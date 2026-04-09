import 'dart:convert';
import 'package:dio/dio.dart';
import '../../../../../../core/api_functions/general/car/car_brand/update_car_brand_model/update_car_brand_request.dart';
import '../../../../../../core/api/dio_function/api_constants.dart';
import '../../../../../../core/api/dio_function/dio_controller.dart';
import '../../../../../../core/api/dio_function/failures.dart';
import '../../../../../../core/language/language_constant.dart';
import '../../../../../../core/pages_widgets/general_widgets/snakbar.dart';

Future<void> updateCarBrandFunction({required UpdateCarBrandRequest updateCarBrandRequest}) async {
  try {
    String jsonString = json.encode(updateCarBrandRequest.toJson());

    await Network.postDataWithBody(
      jsonString,
      ApiLink.updateCarBrand,
    ).then((value) {
      AppSnackBar.showSuccess(AppLanguageKeys.updateCarBrandSuccessfully);
    });

  } catch (e) {
    AppSnackBar.showError(
      e is DioException
          ? responseOfStatusCode(e.response?.statusCode)
          : e.toString(),
    );
  }
}