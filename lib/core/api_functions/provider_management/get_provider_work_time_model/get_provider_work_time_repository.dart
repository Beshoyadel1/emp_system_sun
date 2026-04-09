import 'package:dio/dio.dart';
import '../../../../core/api_functions/provider_management/get_provider_work_time_model/get_provider_work_time_request.dart';
import '../../../../core/api/dio_function/api_constants.dart';
import '../../../../core/pages_widgets/general_widgets/snakbar.dart';
import '../../../../core/api/dio_function/dio_controller.dart';
import '../../../../core/api/dio_function/failures.dart';
import '../../../../core/language/language_constant.dart';

Future<void> getProviderWorkTimeFunction({
  required GetProviderWorkTimeRequest getProviderWorkTimeRequest,
}) async {
  try {
    await Network.postDataWithBodyAndParams(
      {},
      getProviderWorkTimeRequest.toJson(), // params
      ApiLink.getProviderWorkTime,
    );
    AppSnackBar.showSuccess(AppLanguageKeys.getProviderWorkTimeSuccess);
  } catch (e) {
    AppSnackBar.showError(
      e is DioException
          ? responseOfStatusCode(e.response?.statusCode)
          : e.toString(),
    );
  }
}