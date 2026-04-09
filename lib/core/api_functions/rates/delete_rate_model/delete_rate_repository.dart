import 'package:dio/dio.dart';
import '../../../../core/api_functions/rates/delete_rate_model/delete_rate_request.dart';
import '../../../../core/api/dio_function/api_constants.dart';
import '../../../../core/pages_widgets/general_widgets/snakbar.dart';
import '../../../../core/api/dio_function/dio_controller.dart';
import '../../../../core/api/dio_function/failures.dart';
import '../../../../core/language/language_constant.dart';

Future<void> deleteRateFunction({
  required DeleteRateRequest deleteRateRequest,
}) async {
  try {
    await Network.postDataWithBodyAndParams(
      {},
      deleteRateRequest.toJson(), // params
      ApiLink.deleteRate,
    );
    AppSnackBar.showSuccess(AppLanguageKeys.deleteRateSuccessfully);
  } catch (e) {
    AppSnackBar.showError(
      e is DioException
          ? responseOfStatusCode(e.response?.statusCode)
          : e.toString(),
    );
  }
}