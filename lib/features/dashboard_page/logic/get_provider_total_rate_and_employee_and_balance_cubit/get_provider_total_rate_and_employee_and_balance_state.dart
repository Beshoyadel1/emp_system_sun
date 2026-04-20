import '../../../../core/api_functions/statistics/get_provider_total_rate_and_employee_and_balance_model/get_provider_total_rate_and_employee_and_balance_model.dart';

abstract class GetProviderTotalRateAndEmployeeAndBalanceState {}

class GetProviderTotalRateAndEmployeeAndBalanceInitial
    extends GetProviderTotalRateAndEmployeeAndBalanceState {}

class GetProviderTotalRateAndEmployeeAndBalanceLoading
    extends GetProviderTotalRateAndEmployeeAndBalanceState {}

class GetProviderTotalRateAndEmployeeAndBalanceSuccess
    extends GetProviderTotalRateAndEmployeeAndBalanceState {
  final GetProviderTotalRateAndEmployeeAndBalanceModel data;

  GetProviderTotalRateAndEmployeeAndBalanceSuccess(this.data);
}

class GetProviderTotalRateAndEmployeeAndBalanceError
    extends GetProviderTotalRateAndEmployeeAndBalanceState {
  final String message;

  GetProviderTotalRateAndEmployeeAndBalanceError(this.message);
}