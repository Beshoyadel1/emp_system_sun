import 'package:emp_system_sun/core/api_functions/order/get_provider_orders_model/order_model.dart';
import 'package:equatable/equatable.dart';

abstract class GetProviderInternalOrderState extends Equatable {
  const GetProviderInternalOrderState();

  @override
  List<Object?> get props => [];
}

class GetProviderInternalOrderInitial
    extends GetProviderInternalOrderState {}

class GetProviderInternalOrderLoading
    extends GetProviderInternalOrderState {}

class GetProviderInternalOrderSuccess extends GetProviderInternalOrderState {
  final List<OrderModel> orders;
  final int currentPage;
  final int pageCount;
  final int totalCount;

  const GetProviderInternalOrderSuccess(
      this.orders, {
        this.currentPage = 1,
        this.pageCount = 1,
        this.totalCount = 0,
      });

  @override
  List<Object?> get props => [orders, currentPage, pageCount, totalCount];
}

class GetProviderInternalOrderError
    extends GetProviderInternalOrderState {
  final String message;

  const GetProviderInternalOrderError(this.message);

  @override
  List<Object?> get props => [message];
}