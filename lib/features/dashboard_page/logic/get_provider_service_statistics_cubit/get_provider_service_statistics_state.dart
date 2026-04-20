import '../../../../core/api_functions/statistics/get_provider_service_statistics_model/provider_statistics_model.dart';

abstract class GetProviderServiceStatisticsState {}

class GetProviderServiceStatisticsInitial
    extends GetProviderServiceStatisticsState {}

class GetProviderServiceStatisticsLoading
    extends GetProviderServiceStatisticsState {}

class GetProviderServiceStatisticsSuccess
    extends GetProviderServiceStatisticsState {
  final ProviderStatisticsModel data;

  GetProviderServiceStatisticsSuccess(this.data);
}

class GetProviderServiceStatisticsError
    extends GetProviderServiceStatisticsState {
  final String message;

  GetProviderServiceStatisticsError(this.message);
}