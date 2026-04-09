abstract class NewOrdersState {}

class NewOrdersInitial extends NewOrdersState {}

class NewOrderDetails extends NewOrdersState {}

class ChangeIndexState extends NewOrdersState {}

class NewOrdersLoading extends NewOrdersState {}

class NewOrdersLoaded extends NewOrdersState {
  final List<dynamic> orders;

  NewOrdersLoaded(this.orders);
}

class NewOrdersError extends NewOrdersState {
  final String message;

  NewOrdersError(this.message);
}
