import 'package:dio/dio.dart';
import '../../../../core/language/language_constant.dart';
import '../../../../core/api_functions/statistics/get_maintenance_report_model/get_maintenance_report_request.dart';
import '../../../../core/api/dio_function/api_constants.dart';
import '../../../../core/pages_widgets/general_widgets/snakbar.dart';
import '../../../../core/api/dio_function/dio_controller.dart';
import '../../../../core/api/dio_function/failures.dart';

Future<void> getMaintenanceReportFunction({
  required GetMaintenanceReportRequest getMaintenanceReportRequest,
}) async {
  try {
    await Network.postDataWithBodyAndParams(
      {},
      getMaintenanceReportRequest.toJson(), // params
      ApiLink.getMaintenanceReport,
    );
    AppSnackBar.showSuccess(AppLanguageKeys.getMaintenanceReportSuccessfully);
  } catch (e) {
    AppSnackBar.showError(
      e is DioException
          ? responseOfStatusCode(e.response?.statusCode)
          : e.toString(),
    );
  }
}
