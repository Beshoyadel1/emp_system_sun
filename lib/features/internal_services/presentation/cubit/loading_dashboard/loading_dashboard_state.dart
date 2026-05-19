import '../../../../../../../../../features/internal_services/data/model/get_provider_main_service_statistics_model/data_points_model.dart';
import '../../../../../../../../../features/internal_services/data/model/get_provider_main_service_statistics_model/sub_service_summaries_model.dart';

class InternalOrdersState {

  final List<SubServiceSummariesModel> services;
  final double averageRate;
  final List<DataPointsModel> chartPoints;

  const InternalOrdersState({
    this.services = const [],
    this.averageRate = 0.0,
    this.chartPoints=const []
  });

  InternalOrdersState copyWith({
    bool? isLoading,
    bool? isLoaded,
    List<SubServiceSummariesModel>? services,
    List<DataPointsModel>? chartPoints,
    double? averageRate,
  }) {
    return InternalOrdersState(
      services: services ?? this.services,
      chartPoints: chartPoints ?? this.chartPoints,
      averageRate: averageRate ?? this.averageRate,
    );
  }
}