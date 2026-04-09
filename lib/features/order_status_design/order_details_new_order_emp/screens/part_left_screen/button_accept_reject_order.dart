import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../../../core/api/dio_function/api_constants.dart';
import '../../../../../../core/api_functions/order/get_provider_orders_model/order_model.dart';
import '../../../../../../core/api_functions/order/update_order_status_model/update_order_status_request.dart';
import '../../../../../../core/language/language_constant.dart';
import '../../../../../../core/theming/colors.dart';
import '../../../../../../features/order_status_design/cubit/order_status_cubit/order_status_cubit.dart';
import '../../../../../../features/order_status_design/custom_widget/container_sold.dart';
import '../../../../../../features/order_status_design/order_details_new_order_emp/sub/dialog_reject_order/dialog_reject_order.dart';

class ButtonAcceptRejectOrder extends StatelessWidget {
  final OrderModel order;

  const ButtonAcceptRejectOrder({
    super.key,
    required this.order,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        /// Work in progress
        ContainerSold(
          text: AppLanguageKeys.workInProgress,
          backGroundColor: AppColors.lightRedColor,
          onTap: () {
            context.read<OrderStatusCubit>().updateOrderStatus(
              updateOrderStatusRequest: UpdateOrderStatusRequest(
                orderId: order.id ?? 0,
                status: OrderStatus.workInProgress,
              ),
            );
          },
        ),

        const SizedBox(width: 20),

        /// Waiting appointment
        ContainerSold(
          text: AppLanguageKeys.waitingAppointment,
          backGroundColor: AppColors.yelloContainerLoadingColor,
          onTap: () {
            final request = UpdateOrderStatusRequest(
              orderId: order.id ?? 0,
              status: OrderStatus.waitingAppointment,
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

        const SizedBox(width: 20),

        /// Reject
        ContainerSold(
          text: AppLanguageKeys.rejectRequest,
          backGroundColor: AppColors.redColor,
          onTap: () {
            // showDialog(
            //   context: context,
            //   builder: (dialogContext) => BlocProvider.value(
            //     value: context.read<OrderStatusCubit>(),
            //     child: const DialogRejectOrder(),
            //   ),
            // );
            final request = UpdateOrderStatusRequest(
              orderId: order.id ?? 0,
              status: OrderStatus.rejectedByProvider,
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