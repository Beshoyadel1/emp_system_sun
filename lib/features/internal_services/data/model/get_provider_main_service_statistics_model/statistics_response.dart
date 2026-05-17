import 'package:emp_system_sun/features/internal_services/data/model/get_provider_main_service_statistics_model/data_points_request.dart';
import 'package:emp_system_sun/features/internal_services/data/model/get_provider_main_service_statistics_model/sub_service_summaries_request.dart';

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
