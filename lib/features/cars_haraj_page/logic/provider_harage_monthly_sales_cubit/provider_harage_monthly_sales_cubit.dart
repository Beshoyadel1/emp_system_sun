import '../../../../../core/api_functions/statistics/get_provider_harage_sold_cars_by_type_model/get_provider_harage_sold_cars_by_type_model.dart';
import '../../../../../core/api_functions/statistics/get_provider_harage_sold_cars_by_type_model/get_provider_harage_sold_cars_by_type_repository.dart';
import '../../../../../core/api_functions/statistics/get_provider_harage_sold_cars_by_type_model/get_provider_harage_sold_cars_by_type_request.dart';

import '../../../../../core/api_functions/statistics/get_provider_harage_monthly_sales_model/get_provider_harage_monthly_sales_response.dart';
import '../../../../../core/api_functions/statistics/get_provider_harage_sales_chart_model/get_provider_harage_data_points_response.dart';
import '../../../../../core/api_functions/statistics/get_provider_harage_sales_chart_model/get_provider_harage_sales_chart_repository.dart';
import '../../../../../core/api_functions/statistics/get_provider_harage_sales_chart_model/get_provider_harage_sales_chart_request.dart';
import '../../../../../core/api_functions/statistics/get_provider_harage_monthly_sales_model/get_provider_harage_monthly_sales_repository.dart';
import '../../../../../core/api_functions/statistics/get_provider_harage_monthly_sales_model/get_provider_harage_monthly_sales_request.dart';
import 'provider_harage_monthly_sales_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProviderHarageStatisticsCubit
    extends Cubit<ProviderHarageStatisticsState> {
  ProviderHarageStatisticsCubit() : super(ProviderHarageStatisticsInitial());

  Future<void> loadStatistics({
    int? providerId,
    int? branchId,
    String? startDate,
    String? endDate,
  }) async {
    emit(ProviderHarageStatisticsLoading());

    try {
      final results = await Future.wait([
        getProviderHarageMonthlySalesFunction(
          getProviderHarageMonthlySalesRequest:
              GetProviderHarageMonthlySalesRequest(
            providerId: providerId ?? 0,
            branchId: branchId ?? 0,
          ),
        ),
        getProviderHarageSalesChartFunction(
          getProviderHarageSalesChartRequest:
              GetProviderHarageSalesChartRequest(
            providerId: providerId ?? 0,
            branchId: branchId ?? 0,
            startDate: startDate ?? "",
            endDate: endDate ?? "",
          ),
        ),
        getProviderHarageSoldCarsByTypeFunction(
          getProviderHarageSoldCarsByTypeRequest:
              GetProviderHarageSoldCarsByTypeRequest(
            providerId: providerId ?? 0,
            branchId: branchId ?? 0,
          ),
        ),
      ]);

      final monthlyResponse =
          results[0] as GetProviderHarageMonthlySalesResponse?;
      final chartResponse = results[1] as GetProviderHarageDataPointsResponse?;
      final soldCarsByType =
          results[2] as GetProviderHarageSoldCarsByTypeModel?;

      if (monthlyResponse == null ||
          chartResponse == null ||
          soldCarsByType == null) {
       // emit(ProviderHarageStatisticsError('Failed to load statistics'));
        return;
      }

      emit(
        ProviderHarageStatisticsSuccess(
          monthlySales: monthlyResponse.monthlySales,
          chartData: chartResponse.dataPoints,
          soldCarsByType: soldCarsByType,
        ),
      );
    } catch (e) {
      emit(ProviderHarageStatisticsError(e.toString()));
    }
  }
}
