import 'package:dio/dio.dart';
import 'package:emp_system_sun/features/internal_services/data/response/get_provider_main_service_statistics_response/statistics_response.dart';

import '../../model/get_provider_main_service_statistics_model/data_points_model.dart';
import '../../../../../core/api/dio_function/failures.dart';
import '../../../../../core/pages_widgets/general_widgets/snakbar.dart';
import '../../model/get_provider_main_service_statistics_model/sub_service_summaries_model.dart';
import '../../request/get_provider_main_service_statistics_request/get_provider_main_service_statistics_request.dart';
import '../../../../../core/api/dio_function/api_constants.dart';
import '../../../../../core/api/dio_function/dio_controller.dart';

Future<StatisticsResponse> getProviderMainServiceStatisticsFunction({
  GetProviderMainServiceStatisticsRequest? request,
}) async {
  try {
    final response = await Network.postDataWithBodyAndParams(
      {},
      request?.toJson() ?? {},
      ApiLink.getProviderMainServiceStatistics,
    );

    final data = response.data["data"] ?? {};

    final List servicesJson =
        data["subServiceSummaries"] ?? [];

    final services = servicesJson
        .map((e) => SubServiceSummariesModel.fromJson(e))
        .toList();

    final averageRate =
    (data["averageRate"] ?? 0).toDouble();

    final chartJson =
        data["salesChart"]?["dataPoints"] ?? [];

    final chartPoints = (chartJson as List)
        .map((e) => DataPointsModel.fromJson(e))
        .toList();

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

    return StatisticsResponse(
      services: [],
      averageRate: 0,
      chartPoints: [],
    );
  }
}