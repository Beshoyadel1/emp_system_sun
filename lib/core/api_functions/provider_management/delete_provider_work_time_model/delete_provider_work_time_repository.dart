import 'package:dio/dio.dart';
import '../../../../core/api_functions/provider_management/delete_provider_work_time_model/delete_provider_work_time_request.dart';
import '../../../../core/api/dio_function/api_constants.dart';
import '../../../../core/pages_widgets/general_widgets/snakbar.dart';
import '../../../../core/api/dio_function/dio_controller.dart';
import '../../../../core/api/dio_function/failures.dart';
import '../../../../core/language/language_constant.dart';

Future<void> deleteProviderWorkTimeFunction({
  required DeleteProviderWorkTimeRequest deleteProviderWorkTimeRequest,
}) async {
  try {
    await Network.postDataWithBodyAndParams(
      {},
      deleteProviderWorkTimeRequest.toJson(), // params
        ApiLink.deleteProviderWorkTime
    );
    AppSnackBar.showSuccess(AppLanguageKeys.deleteProviderWorkTimeSuccess);
  } catch (e) {
    AppSnackBar.showError(
      e is DioException
          ? responseOfStatusCode(e.response?.statusCode)
          : e.toString(),
    );
  }
}