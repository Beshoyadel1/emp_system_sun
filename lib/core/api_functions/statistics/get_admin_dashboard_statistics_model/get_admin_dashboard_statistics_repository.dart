import 'package:dio/dio.dart';
import '../../../../core/api_functions/statistics/get_admin_dashboard_statistics_model/get_admin_dashboard_statistics_request.dart';
import '../../../../core/api/dio_function/api_constants.dart';
import '../../../../core/pages_widgets/general_widgets/snakbar.dart';
import '../../../../core/api/dio_function/dio_controller.dart';
import '../../../../core/api/dio_function/failures.dart';
import '../../../../core/language/language_constant.dart';

Future<void> getAdminDashboardStatisticsFunction({
  required GetAdminDashboardStatisticsRequest getAdminDashboardStatisticsRequest,
}) async {
  try {
    await Network.postDataWithBodyAndParams(
      {},
      getAdminDashboardStatisticsRequest.toJson(), // params
        ApiLink.getAdminDashboardStatistics
    );
    AppSnackBar.showSuccess(AppLanguageKeys.getAdminDashboardStatisticsSuccessfully);
  } catch (e) {
    AppSnackBar.showError(
      e is DioException
          ? responseOfStatusCode(e.response?.statusCode)
          : e.toString(),
    );
  }
}