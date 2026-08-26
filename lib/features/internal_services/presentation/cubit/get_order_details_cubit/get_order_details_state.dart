import '../../../../../../../features/internal_services/data/model/get_provider_orders_model/order_details_model.dart';

abstract class GetOrderDetailsState {}

class GetOrderDetailsInitial extends GetOrderDetailsState {}

class GetOrderDetailsLoading extends GetOrderDetailsState {}

class GetOrderDetailsSuccess extends GetOrderDetailsState {
  final OrderDetailsModel orderDetails;

  GetOrderDetailsSuccess({
    required this.orderDetails,
  });
}

class GetOrderDetailsError extends GetOrderDetailsState {
  final String message;

  GetOrderDetailsError({
    required this.message,
  });
}