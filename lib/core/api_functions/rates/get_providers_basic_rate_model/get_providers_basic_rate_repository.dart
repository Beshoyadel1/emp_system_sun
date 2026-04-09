import 'package:dio/dio.dart';
import '../../../../core/api_functions/rates/get_providers_basic_rate_model/get_providers_basic_rate_request.dart';
import '../../../../core/api/dio_function/api_constants.dart';
import '../../../../core/pages_widgets/general_widgets/snakbar.dart';
import '../../../../core/api/dio_function/dio_controller.dart';
import '../../../../core/api/dio_function/failures.dart';
import '../../../../core/language/language_constant.dart';

Future<void> getProvidersBasicRateFunction({
  required GetProvidersBasicRateRequest getProvidersBasicRateRequest,
}) async {
  try {
    await Network.postDataWithBodyAndParams(
      {},
      getProvidersBasicRateRequest.toJson(), // params
      ApiLink.getProvidersBasicRate,
    );
    AppSnackBar.showSuccess(AppLanguageKeys.getProvidersBasicRateSuccessfully);
  } catch (e) {
    AppSnackBar.showError(
      e is DioException
          ? responseOfStatusCode(e.response?.statusCode)
          : e.toString(),
    );
  }
}