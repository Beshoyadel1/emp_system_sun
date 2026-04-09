import 'package:dio/dio.dart';
import '../../../../core/api_functions/utility_and_extras/get_car_model/get_car_request.dart';
import '../../../../core/api/dio_function/api_constants.dart';
import '../../../../core/pages_widgets/general_widgets/snakbar.dart';
import '../../../../core/api/dio_function/dio_controller.dart';
import '../../../../core/api/dio_function/failures.dart';
import '../../../../core/language/language_constant.dart';

Future<void> getCarFunction({
  required GetCarRequest getCarRequest,
}) async {
  try {
    await Network.postDataWithBodyAndParams(
      {},
      getCarRequest.toJson(), // params
      ApiLink.getCar,
    );
    AppSnackBar.showSuccess(AppLanguageKeys.getCarSuccessfully);
  } catch (e) {
    AppSnackBar.showError(
      e is DioException
          ? responseOfStatusCode(e.response?.statusCode)
          : e.toString(),
    );
  }
}