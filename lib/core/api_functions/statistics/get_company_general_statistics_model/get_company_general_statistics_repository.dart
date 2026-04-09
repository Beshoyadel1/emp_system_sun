import 'package:dio/dio.dart';
import '../../../../core/api_functions/statistics/get_company_general_statistics_model/get_company_general_statistics_request.dart';
import '../../../../core/api/dio_function/api_constants.dart';
import '../../../../core/pages_widgets/general_widgets/snakbar.dart';
import '../../../../core/api/dio_function/dio_controller.dart';
import '../../../../core/api/dio_function/failures.dart';
import '../../../../core/language/language_constant.dart';

Future<void> getCompanyGeneralStatisticsFunction({
  required GetCompanyGeneralStatisticsRequest getCompanyGeneralStatisticsRequest,
}) async {
  try {
    await Network.postDataWithBodyAndParams(
      {},
      getCompanyGeneralStatisticsRequest.toJson(), // params
        ApiLink.getCompanyGeneralStatistics
    );
    AppSnackBar.showSuccess(AppLanguageKeys.getCompanyGeneralStatisticsSuccessfully);
  } catch (e) {
    AppSnackBar.showError(
      e is DioException
          ? responseOfStatusCode(e.response?.statusCode)
          : e.toString(),
    );
  }
}
