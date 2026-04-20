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

class ButtonAcceptRejectOrder extends StatelessWidget {
  final OrderModel order;

  const ButtonAcceptRejectOrder({
    super.key,
    required this.order,
  });

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 5,
      runSpacing: 5,
      children: [
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

        ContainerSold(
          text: AppLanguageKeys.waitingAppointment,
          backGroundColor: AppColors.yelloContainerLoadingColor,
          onTap: () {
            final request = UpdateOrderStatusRequest(
              orderId: order.id ?? 0,
              status: OrderStatus.waitingAppointment,
            );


            context.read<OrderStatusCubit>().updateOrderStatus(
              updateOrderStatusRequest: request,
            );
          },
        ),

        const SizedBox(width: 20),
        ContainerSold(
          text: AppLanguageKeys.rejectRequest,
          backGroundColor: AppColors.redColor,
          onTap: () {

            final request = UpdateOrderStatusRequest(
              orderId: order.id ?? 0,
              status: OrderStatus.rejectedByProvider,
            );


            context.read<OrderStatusCubit>().updateOrderStatus(
              updateOrderStatusRequest: request,
            );
          },
        ),
      ],
    );
  }
}