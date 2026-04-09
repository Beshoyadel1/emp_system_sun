import 'package:dio/dio.dart';
import '../../../../core/api_functions/statistics/get_provider_main_service_statistics_model/data_points_request.dart';
import '../../../../core/api/dio_function/failures.dart';
import '../../../../core/language/language_constant.dart';
import '../../../../core/pages_widgets/general_widgets/snakbar.dart';
import '../../../../core/api_functions/statistics/get_provider_main_service_statistics_model/statistics_response.dart';
import '../../../../core/api_functions/statistics/get_provider_main_service_statistics_model/sub_service_summaries_request.dart';
import '../../../../core/api_functions/statistics/get_provider_main_service_statistics_model/get_provider_main_service_statistics_request.dart';
import '../../../../core/api/dio_function/api_constants.dart';
import '../../../../core/api/dio_function/dio_controller.dart';

Future<StatisticsResponse> getProviderMainServiceStatisticsFunction({
  GetProviderMainServiceStatisticsRequest? request,
}) async {
  try {
    final response = await Network.postDataWithBodyAndParams(
      {},
      request?.toJson() ?? {},
      ApiLink.getProviderMainServiceStatistics,
    );

    final data = response.data;

    final List servicesJson = data["subServiceSummaries"];

    final services = servicesJson.map((e) => SubServiceSummariesRequest.fromJson(e))
        .toList();
    final averageRate = (data["averageRate"] ?? 0).toDouble();

    final chartJson = data["salesChart"]?["dataPoints"] ?? [];

    final chartPoints =
        (chartJson as List).map((e) => DataPointsRequest.fromJson(e)).toList();

    AppSnackBar.showSuccess(
      AppLanguageKeys.getProviderMainServiceStatisticsSuccessfully,
    );
    return StatisticsResponse(
      services: services,
      averageRate: averageRate,
      chartPoints: chartPoints,
    );
  } catch (e) {
    AppSnackBar.showError(
      e is DioException
          ? responseOfStatusCode(e.response?.statusCode)
          : e.toString(),
    );
    return StatisticsResponse(services: [], averageRate: 0, chartPoints: []);
  }
}
