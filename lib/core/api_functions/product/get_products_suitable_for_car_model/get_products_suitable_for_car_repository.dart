import 'package:dio/dio.dart';
import '../../../../core/api_functions/product/get_products_suitable_for_car_model/get_products_suitable_for_car_request.dart';
import '../../../../core/api/dio_function/api_constants.dart';
import '../../../../core/pages_widgets/general_widgets/snakbar.dart';
import '../../../../core/api/dio_function/dio_controller.dart';
import '../../../../core/api/dio_function/failures.dart';
import '../../../../core/language/language_constant.dart';

Future<void> getProductsSuitableForCarFunction({
  required GetProductsSuitableForCarRequest getProductsSuitableForCarRequest,
}) async {
  try {
    await Network.postDataWithBodyAndParams(
      {},
      getProductsSuitableForCarRequest.toJson(), // params
      ApiLink.getProductsSuitableForCar,
    );
    AppSnackBar.showSuccess(AppLanguageKeys.getProductsSuitableForCarSuccess);
  } catch (e) {
    AppSnackBar.showError(
      e is DioException
          ? responseOfStatusCode(e.response?.statusCode)
          : e.toString(),
    );
  }
}