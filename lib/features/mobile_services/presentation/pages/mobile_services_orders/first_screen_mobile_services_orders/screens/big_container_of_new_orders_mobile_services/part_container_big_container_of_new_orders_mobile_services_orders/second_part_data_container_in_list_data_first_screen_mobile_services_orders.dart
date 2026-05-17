import 'package:emp_system_sun/core/api/dio_function/api_constants.dart';
import 'package:emp_system_sun/core/language/language_constant.dart';
import 'package:emp_system_sun/core/theming/assets.dart';
import 'package:emp_system_sun/core/theming/colors.dart';
import 'package:emp_system_sun/core/theming/text_styles.dart';
import 'package:emp_system_sun/features/internal_services/presentation/cubit/get_provider_internal_order/get_provider_internal_order_cubit.dart';
import 'package:emp_system_sun/features/internal_services/presentation/cubit/get_provider_internal_order/get_provider_internal_order_state.dart';
import 'package:emp_system_sun/features/internal_services/presentation/cubit/order_funcations/order_functions.dart';
import 'package:emp_system_sun/features/internal_services/presentation/pages/internal_orders/custom_widget/Container_of_second_part_data_container_in_list_data_first_screen_internal_orders_widget.dart';
import 'package:emp_system_sun/features/order_status_design/presentation/cubit/order_status_cubit/order_status_cubit.dart';
import 'package:emp_system_sun/features/order_status_design/presentation/cubit/order_status_cubit/order_status_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SecondPartDataContainerInListDataFirstScreenMobileServicesOrders
    extends StatefulWidget {
  const SecondPartDataContainerInListDataFirstScreenMobileServicesOrders({
    super.key,
  });

  @override
  State<SecondPartDataContainerInListDataFirstScreenMobileServicesOrders>
  createState() =>
      _SecondPartDataContainerInListDataFirstScreenMobileServicesOrdersState();
}

class _SecondPartDataContainerInListDataFirstScreenMobileServicesOrdersState extends State<SecondPartDataContainerInListDataFirstScreenMobileServicesOrders> {



  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (_) =>
            GetProviderInternalOrderCubit()
              ..loadInternalOrders(
                serviceId: MainCategoryConstants
                    .mobileServicesAndTransportationID,
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
                MainCategoryConstants.mobileServicesAndTransportationID,
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
                if (state.orders.isEmpty) {
                  return const Center(
                    child:  TextInAppWidget(
                      text: AppLanguageKeys.empty,
                      textSize: 15,
                      textColor: AppColors.greyColor,
                    ),
                  );
                }
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
                      serviceId:MainCategoryConstants.mobileServicesAndTransportationID,
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
