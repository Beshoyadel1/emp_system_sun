import 'package:dio/dio.dart';
import 'package:emp_system_sun/features/store_page/data/request/delete_provider_work_time_request/delete_provider_work_time_request.dart';
import '../../../../../core/api/dio_function/api_constants.dart';
import '../../../../../core/pages_widgets/general_widgets/snakbar.dart';
import '../../../../../core/api/dio_function/dio_controller.dart';
import '../../../../../core/api/dio_function/failures.dart';
import '../../../../../core/language/language_constant.dart';

Future<void> deleteProviderWorkTimeFunction({
  required DeleteProviderWorkTimeRequest deleteProviderWorkTimeRequest,
}) async {
  try {
    await Network.postDataWithBodyAndParams(
      {},
      deleteProviderWorkTimeRequest.toJson(),
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