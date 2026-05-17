abstract class OrderStatusState {}

class OrderStatusInitial extends OrderStatusState {}

class OrderStatusLoading extends OrderStatusState {}

class OrderStatusSuccess extends OrderStatusState {}

class OrderStatusError extends OrderStatusState {
  final String message;

  OrderStatusError(this.message);
}