import '../../../../../../../core/api_functions/statistics/get_provider_main_service_statistics_model/data_points_request.dart';
import '../../../../../../../core/api_functions/statistics/get_provider_main_service_statistics_model/sub_service_summaries_request.dart';

class InternalOrdersState {

  final List<SubServiceSummariesRequest> services;
  final double averageRate;
  final List<DataPointsRequest> chartPoints;

  const InternalOrdersState({
    this.services = const [],
    this.averageRate = 0.0,
    this.chartPoints=const []
  });

  InternalOrdersState copyWith({
    bool? isLoading,
    bool? isLoaded,
    List<SubServiceSummariesRequest>? services,
    List<DataPointsRequest>? chartPoints,
    double? averageRate,
  }) {
    return InternalOrdersState(
      services: services ?? this.services,
      chartPoints: chartPoints ?? this.chartPoints,
      averageRate: averageRate ?? this.averageRate,
    );
  }
}