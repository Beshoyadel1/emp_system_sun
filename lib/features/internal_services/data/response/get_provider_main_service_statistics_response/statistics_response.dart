import 'package:emp_system_sun/features/internal_services/data/model/get_provider_main_service_statistics_model/data_points_model.dart';
import 'package:emp_system_sun/features/internal_services/data/model/get_provider_main_service_statistics_model/sub_service_summaries_model.dart';

class StatisticsResponse {
  final List<SubServiceSummariesModel> services;
  final double averageRate;
  final List<DataPointsModel> chartPoints;

  StatisticsResponse({
    required this.services,
    required this.averageRate,
    required this.chartPoints,
  });
}
