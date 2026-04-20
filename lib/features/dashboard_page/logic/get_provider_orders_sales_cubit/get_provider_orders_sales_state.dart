import '../../../../core/api_functions/statistics/get_provider_orders_sales_model/get_provider_orders_sales_model.dart';

abstract class GetProviderOrdersSalesState {}

class GetProviderOrdersSalesInitial
    extends GetProviderOrdersSalesState {}

class GetProviderOrdersSalesLoading
    extends GetProviderOrdersSalesState {}

class GetProviderOrdersSalesSuccess
    extends GetProviderOrdersSalesState {
  final GetProviderOrdersSalesModel data;

  GetProviderOrdersSalesSuccess(this.data);
}

class GetProviderOrdersSalesError
    extends GetProviderOrdersSalesState {
  final String message;

  GetProviderOrdersSalesError(this.message);
}