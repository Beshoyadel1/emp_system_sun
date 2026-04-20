import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../../../../core/api/dio_function/api_constants.dart';
import '../../../../../../../core/language/language_constant.dart';
import '../../../../../../../core/theming/assets.dart';
import '../../../../../../../features/internal_services/internal_orders/custom_widget/Container_of_second_part_data_container_in_list_data_first_screen_internal_orders_widget.dart';
import '../../../../../../../features/internal_services/internal_orders/first_screen_internal_orders/logic/get_provider_internal_order/get_provider_internal_order_cubit.dart';
import '../../../../../../../features/internal_services/internal_orders/first_screen_internal_orders/logic/get_provider_internal_order/get_provider_internal_order_state.dart';
import '../../../../../../../features/internal_services/internal_orders/first_screen_internal_orders/logic/order_funcations/order_functions.dart';

class SecondPartDataContainerInListDataFirstScreenSparePartsOrders
    extends StatefulWidget {
  const SecondPartDataContainerInListDataFirstScreenSparePartsOrders({
    super.key,
  });

  @override
  State<SecondPartDataContainerInListDataFirstScreenSparePartsOrders>
  createState() =>
      _SecondPartDataContainerInListDataFirstScreenSparePartsOrdersState();
}

class _SecondPartDataContainerInListDataFirstScreenSparePartsOrdersState extends State<SecondPartDataContainerInListDataFirstScreenSparePartsOrders> {

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => GetProviderInternalOrderCubit()
        ..loadInternalOrders(
            serviceId: MainCategoryConstants.carSparePartsID
        ),
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
                    serviceId: MainCategoryConstants.carSparePartsID,
                  );
                }
            );
          }

          return const SizedBox();
        },
      ),
    );
  }
}
