import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../../../../features/internal_services/internal_orders/first_screen_internal_orders/logic/order_funcations/order_functions.dart';
import '../../../../../../../features/order_status_design/cubit/order_status_cubit/order_status_cubit.dart';
import '../../../../../../../features/order_status_design/cubit/order_status_cubit/order_status_state.dart';
import '../../../../../../../features/order_status_design/order_details_new_order_emp/order_details_new_order_emp.dart';
import '../../../../../../../features/order_status_design/order_details_on_the_way_emp/order_details_on_the_way_emp.dart';
import '../../../../../../../features/order_status_design/order_details_order_received_emp/order_details_order_received_emp.dart';
import '../../../../../../../features/order_status_design/order_details_under_service_emp/order_details_under_service_emp.dart';
import '../../../../../../../core/api/dio_function/api_constants.dart';
import '../../../../../../../core/language/language_constant.dart';
import '../../../../../../../core/pages_widgets/general_widgets/navigate_to_page_widget.dart';
import '../../../../../../../core/theming/assets.dart';
import '../../../../../../../features/internal_services/internal_orders/custom_widget/Container_of_second_part_data_container_in_list_data_first_screen_internal_orders_widget.dart';
import '../../../../../../../features/internal_services/internal_orders/first_screen_internal_orders/logic/get_provider_internal_order/get_provider_internal_order_cubit.dart';
import '../../../../../../../features/internal_services/internal_orders/first_screen_internal_orders/logic/get_provider_internal_order/get_provider_internal_order_state.dart';

class SecondPartDataContainerInListDataFirstScreenInternalOrders
    extends StatefulWidget {
  const SecondPartDataContainerInListDataFirstScreenInternalOrders({
    super.key,
  });

  @override
  State<SecondPartDataContainerInListDataFirstScreenInternalOrders>
  createState() =>
      _SecondPartDataContainerInListDataFirstScreenInternalOrdersState();
}

class _SecondPartDataContainerInListDataFirstScreenInternalOrdersState
    extends State<SecondPartDataContainerInListDataFirstScreenInternalOrders> {

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (_) =>
            GetProviderInternalOrderCubit()
              ..loadInternalOrders(
                serviceId: MainCategoryConstants
                    .maintenanceAndInternalServicesID,
              ),
          ),
          BlocProvider(
            create: (_) => OrderStatusCubit(),
          ),
        ],
        child: BlocListener<OrderStatusCubit, OrderStatusState>(
          listener: (context, state) {
            if (state is OrderStatusSuccess) {
              context.read<GetProviderInternalOrderCubit>().loadInternalOrders(
                serviceId:
                MainCategoryConstants.maintenanceAndInternalServicesID,
              );
            }
          },
          child: BlocBuilder<GetProviderInternalOrderCubit,
              GetProviderInternalOrderState>(
            builder: (context, state) {
              if (state is GetProviderInternalOrderLoading) {
                return const Center(child: CircularProgressIndicator());
              }

              if (state is GetProviderInternalOrderSuccess) {
                final orders = state.orders;

                return ListView.separated(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: orders.length,
                  separatorBuilder: (_, __) => const SizedBox(height: 5),
                  itemBuilder: (context, index) {
                    final order = orders[index];

                    final service = order.services?.isNotEmpty == true
                        ? order.services!.first
                        : null;

                    final serviceTitle = OrderFunctions.getServiceTitle(
                      context: context,
                      service: service,
                    );

                    return ContainerOfSecondPartDataContainerInListDataFirstScreenInternalOrdersWidget(
                      imagePathPart1: service?.image,
                      titlePart1: serviceTitle,
                      subTitlePart1: '',
                      imagePathPart2: AppImageKeys.car501,
                      textCarPart2: order.branchName ?? "",
                      titlePart2: order.providerName ?? "",
                      imagePathPart3: order.providerImage,
                      titlePart3: AppLanguageKeys.name,
                      subTitlePart3: order.username ?? "",
                      status: order.orderStatus,
                      timePart5: OrderFunctions.formatDate(order.orderDate),
                      pricePart6: order.totalPrice?.toString() ?? "0",
                      order: order,
                      serviceId:MainCategoryConstants.maintenanceAndInternalServicesID,
                    );
                  },
                );
              }

              if (state is GetProviderInternalOrderError) {
                return Center(child: Text(state.message));
              }

              return const SizedBox();
            },
          ),
        )
    );
  }
}
