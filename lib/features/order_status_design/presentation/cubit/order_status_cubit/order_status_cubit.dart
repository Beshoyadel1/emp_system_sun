import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../../../../../../features/order_status_design/data/datasource/update_order_status_datasource/update_order_status_repository.dart';
import '../../../../../../../../../features/order_status_design/data/request/update_order_status_request.dart';
import '../../../../../../../../../features/order_status_design/presentation/cubit/order_status_cubit/order_status_state.dart';

class OrderStatusCubit extends Cubit<OrderStatusState> {
  OrderStatusCubit() : super(OrderStatusInitial());

  Future<void> updateOrderStatus({
    required int orderId,
    required int status,
  }) async {
    emit(OrderStatusLoading());

    final request = UpdateOrderStatusRequest(
      orderId: orderId,
      status: status,
    );

    final bool isSuccess = await updateOrderStatusFunction(
      updateOrderStatusRequest: request,
    );

    if (isSuccess) {
      emit(OrderStatusSuccess());
    } else {
      emit(
        OrderStatusError(
          "Failed to update order status",
        ),
      );
    }
  }
}