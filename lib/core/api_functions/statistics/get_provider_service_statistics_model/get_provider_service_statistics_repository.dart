import 'package:dio/dio.dart';
import '../../../../core/api_functions/statistics/get_provider_service_statistics_model/get_provider_service_statistics_request.dart';
import '../../../../core/api/dio_function/api_constants.dart';
import '../../../../core/pages_widgets/general_widgets/snakbar.dart';
import '../../../../core/api/dio_function/dio_controller.dart';
import '../../../../core/api/dio_function/failures.dart';
import '../../../../core/language/language_constant.dart';

Future<void> getProviderServiceStatisticsFunction({
  required GetProviderServiceStatisticsRequest getProviderServiceStatisticsRequest,
}) async {
  try {
    await Network.postDataWithBodyAndParams(
      {},
      getProviderServiceStatisticsRequest.toJson(), // params
        ApiLink.getProviderServiceStatistics
    );
    AppSnackBar.showSuccess(AppLanguageKeys.getProviderServiceStatisticsSuccessfully);
  } catch (e) {
    AppSnackBar.showError(
      e is DioException
          ? responseOfStatusCode(e.response?.statusCode)
          : e.toString(),
    );
  }
}
