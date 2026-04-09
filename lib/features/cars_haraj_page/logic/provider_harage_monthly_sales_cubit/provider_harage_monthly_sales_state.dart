import '../../../../../core/api_functions/statistics/get_provider_harage_sales_chart_model/harag_data_points_model.dart';
import '../../../../../core/api_functions/statistics/get_provider_harage_monthly_sales_model/harag_monthly_sale_model.dart';
import '../../../../../core/api_functions/statistics/get_provider_harage_sold_cars_by_type_model/get_provider_harage_sold_cars_by_type_model.dart';

abstract class ProviderHarageStatisticsState {}

class ProviderHarageStatisticsInitial
    extends ProviderHarageStatisticsState {}

class ProviderHarageStatisticsLoading
    extends ProviderHarageStatisticsState {}

class ProviderHarageStatisticsSuccess
    extends ProviderHarageStatisticsState {
  final List<HaragMonthlySaleModel> monthlySales;
  final List<HaragDataPointsModel> chartData;
  final GetProviderHarageSoldCarsByTypeModel soldCarsByType;

  ProviderHarageStatisticsSuccess({
    required this.monthlySales,
    required this.chartData,
    required this.soldCarsByType,
  });
}

class ProviderHarageStatisticsError
    extends ProviderHarageStatisticsState {
  final String message;

  ProviderHarageStatisticsError(this.message);
}
