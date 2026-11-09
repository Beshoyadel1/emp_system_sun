import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../../../../../../features/order_status_design/data/datasource/update_order_status_datasource/update_order_status_repository.dart';
import '../../../../../../../../../features/order_status_design/data/request/update_order_status_request.dart';
import '../../../../../../../../../features/order_status_design/presentation/cubit/order_status_cubit/order_status_state.dart';
import 'package:emp_system_sun/core/theming/auth_local_storage.dart';
import 'package:emp_system_sun/core/api/dio_function/api_constants.dart';

class OrderStatusCubit extends Cubit<OrderStatusState> {
  OrderStatusCubit() : super(OrderStatusInitial());

  Future<void> updateOrderStatus({
    required int orderId,
    required int status,
    List<int>? employeeIds,
  }) async {
    final user = await AuthLocalStorage.getUser();
    if (user == null) {
      emit(OrderStatusError('User not found'));
      return;
    }
    final delegated = user.type == UserType.providerUser ||
        user.employeeDetails?.permissions?.acceptAndRefuseAndAssignOrders ==
            true;
    if ((employeeIds != null ||
            status == OrderStatus.waitingAppointment ||
            status == OrderStatus.rejectedByProvider) &&
        !delegated) {
      emit(
          OrderStatusError('This action requires order delegation permission'));
      return;
    }
    emit(OrderStatusLoading());
    final request = UpdateOrderStatusRequest(
      orderId: orderId,
      status: status,
      employeeIds: employeeIds,
      changedById: user.userid,
      changedByType: user.type,
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
