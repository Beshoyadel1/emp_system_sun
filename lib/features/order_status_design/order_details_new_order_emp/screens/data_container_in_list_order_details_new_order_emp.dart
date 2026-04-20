import 'package:emp_system_sun/features/order_status_design/custom_widget/container_return_to_page_setting.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../../../../core/api_functions/order/get_provider_orders_model/order_model.dart';
import '../../../../../../../core/pages_widgets/general_widgets/snakbar.dart';
import '../../../../../../../features/order_status_design/cubit/order_status_cubit/order_status_cubit.dart';
import '../../../../../../../features/order_status_design/cubit/order_status_cubit/order_status_state.dart';
import '../../../../../../../features/order_status_design/custom_widget/container_sold.dart';
import '../../../../../../../features/order_status_design/custom_widget/title_with_sub_title_in_order_details_emp.dart';
import '../../../../../../../features/order_status_design/order_details_new_order_emp/screens/custom_container_order.dart';
import '../../../../../../../features/order_status_design/order_details_new_order_emp/screens/part_left_screen/button_accept_reject_order.dart';
import '../../../../../../../features/order_status_design/order_details_new_order_emp/screens/part_left_screen/container_contact_with_customer_order_details_new_order_emp.dart';
import '../../../../../../../features/order_status_design/order_details_new_order_emp/screens/part_left_screen/data_time_line_tile_order_details_new_order_emp.dart';
import '../../../../../../../features/order_status_design/order_details_new_order_emp/sub/dialog_reject_order/dialog_reject_order.dart';
import '../../../../../../core/language/language_constant.dart';
import '../../../../../../core/theming/colors.dart';

class DataContainerInListOrderDetailsNewOrderEmp extends StatelessWidget {
  final OrderModel order;
  const DataContainerInListOrderDetailsNewOrderEmp({super.key,required this.order});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    bool isMobile = size.width <= 950;
    return Padding(
      padding: const EdgeInsets.all(15.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: 30,
        children: [
          if(isMobile)
            ContainerReturnToPageSetting(
              text: AppLanguageKeys.back,
              onTap: (){
                Navigator.pop(context);
              },
            ),
          const TitleWithSubTitleInOrderDetailsEmp(),
          CustomContainerOrder(
              order:order
          ),
          if (isMobile)
            const Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              spacing: 30,
              children: [
                 ContainerContactWithCustomerOrderDetailsNewOrderEmp(),
                 DataTimeLineTileOrderDetailsNewOrderEmp()
              ],
            ),
          BlocProvider(
            create: (_) => OrderStatusCubit(),
            child: BlocListener<OrderStatusCubit, OrderStatusState>(
              listener: (context, state) {
                if (!context.mounted) return;

                if (state is OrderStatusSuccess) {
                  AppSnackBar.showSuccess(
                    AppLanguageKeys.updateOrderStatusSuccessfully,
                  );

                  Navigator.pop(context, true);
                }

                if (state is OrderStatusError) {
                  AppSnackBar.showError(state.message);
                }
              },
              child: BlocBuilder<OrderStatusCubit, OrderStatusState>(
                builder: (context, state) {
                  return Stack(
                    children: [
                      BlocProvider(
                        create: (_) => OrderStatusCubit(),
                        child: BlocListener<OrderStatusCubit, OrderStatusState>(
                          listener: (context, state) {
                            if (!context.mounted) return;

                            if (state is OrderStatusSuccess) {
                              AppSnackBar.showSuccess(
                                AppLanguageKeys.updateOrderStatusSuccessfully,
                              );

                              /// 🔥 أهم سطر
                              Navigator.pop(context, true);
                            }

                            if (state is OrderStatusError) {
                              AppSnackBar.showError(state.message);
                            }
                          },
                          child: BlocBuilder<OrderStatusCubit, OrderStatusState>(
                            builder: (context, state) {
                              return Stack(
                                children: [
                                  ButtonAcceptRejectOrder(order: order),

                                  if (state is OrderStatusLoading)
                                    const Center(child: CircularProgressIndicator()),
                                ],
                              );
                            },
                          ),
                        ),
                      ),

                      if (state is OrderStatusLoading)
                        const Center(child: CircularProgressIndicator()),
                    ],
                  );
                },
              ),
            ),
          )
        ],
      ),
    );
  }
}
