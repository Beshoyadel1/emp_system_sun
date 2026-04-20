import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../../../../core/api/dio_function/api_constants.dart';
import '../../../../../../../core/api_functions/order/get_provider_orders_model/order_model.dart';
import '../../../../../../../core/api_functions/order/update_order_status_model/update_order_status_request.dart';
import '../../../../../../../core/language/language_constant.dart';
import '../../../../../../../core/theming/colors.dart';
import '../../../../../../../features/order_status_design/cubit/order_status_cubit/order_status_cubit.dart';
import '../../../../../../../features/order_status_design/custom_widget/container_sold.dart';

class ContainerReceivedRejectUser extends StatelessWidget {
  final OrderModel order;

  const ContainerReceivedRejectUser({
    super.key,
    required this.order,
  });

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 5,
      runSpacing: 5,
      children: [
        /// Work in progress
        ContainerSold(
          text: AppLanguageKeys.completedOrders,
          backGroundColor: AppColors.greenColor,
          onTap: () {
            context.read<OrderStatusCubit>().updateOrderStatus(
              updateOrderStatusRequest: UpdateOrderStatusRequest(
                orderId: order.id ?? 0,
                status: OrderStatus.orderCompleted,
              ),
            );
          },
        ),

        const SizedBox(width: 20),

        /// Waiting appointment
        ContainerSold(
          text: AppLanguageKeys.cancelledByUser,
          backGroundColor: AppColors.redColor,
          onTap: () {
            final request = UpdateOrderStatusRequest(
              orderId: order.id ?? 0,
              status: OrderStatus.cancelledByUser,
            );

            // print("========== BUTTON CLICK ==========");
            // print("Order ID: ${request.orderId}");
            // print("Status: ${request.status}");
            // print("=================================");

            context.read<OrderStatusCubit>().updateOrderStatus(
              updateOrderStatusRequest: request,
            );
          },
        ),
      ],
    );
  }
}