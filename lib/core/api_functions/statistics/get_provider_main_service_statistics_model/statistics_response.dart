import '../../../../core/api_functions/statistics/get_provider_main_service_statistics_model/data_points_request.dart';
import '../../../../core/api_functions/statistics/get_provider_main_service_statistics_model/sub_service_summaries_request.dart';

class StatisticsResponse {
  final List<SubServiceSummariesRequest> services;
  final double averageRate;
  final List<DataPointsRequest> chartPoints;

  StatisticsResponse({
    required this.services,
    required this.averageRate,
    required this.chartPoints,
  });
}
