import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../../core/api_functions/order/update_order_status_model/update_order_status_repository.dart';
import '../../../../../core/api_functions/order/update_order_status_model/update_order_status_request.dart';
import '../../../../../features/order_status_design/cubit/order_status_cubit/order_status_state.dart';

class OrderStatusCubit extends Cubit<OrderStatusState> {
  OrderStatusCubit() : super(OrderStatusInitial());

  Future<void> updateOrderStatus({
    required UpdateOrderStatusRequest updateOrderStatusRequest,
  }) async {

    emit(OrderStatusLoading());

    final bool isSuccess = await updateOrderStatusFunction(
      updateOrderStatusRequest: updateOrderStatusRequest,
    );


    if (isSuccess) {
      emit(OrderStatusSuccess());
    } else {
      emit(OrderStatusError("Failed to update order status"));
    }
  }
}
