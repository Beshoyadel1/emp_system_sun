import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../../../features/cars_haraj_page/model/internal_orders_filter/internal_orders_filter.dart';
import '../../../../../../features/internal_services/internal_orders/first_screen_internal_orders/logic/order_funcations/order_functions.dart';
import '../../../../../../features/internal_services/internal_orders/first_screen_internal_orders/logic/tabs_cubit/tabs_cubit.dart';
import '../../../../../../features/spare_parts/custom_widget/app_pagination.dart';
import '../../../../../../core/api/dio_function/api_constants.dart';
import '../../../../../../features/internal_services/internal_orders/first_screen_internal_orders/logic/get_provider_internal_order/get_provider_internal_order_cubit.dart';
import '../../../../../../features/internal_services/internal_orders/first_screen_internal_orders/logic/get_provider_internal_order/get_provider_internal_order_state.dart';
import '../../../../../../core/theming/assets.dart';
import '../../../../../../core/language/language_constant.dart';
import '../../../../../../features/internal_services/internal_orders/custom_widget/Container_of_second_part_data_container_in_list_data_first_screen_internal_orders_widget.dart';

class FilterDesignMobileServicesStatistics
    extends StatelessWidget {
  const FilterDesignMobileServicesStatistics({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<GetProviderInternalOrderCubit,
        GetProviderInternalOrderState>(
      builder: (context, state) {
        if (state is GetProviderInternalOrderLoading) {
          return const Center(child: CircularProgressIndicator());
        }

        if (state is GetProviderInternalOrderSuccess) {

          final selectedTab = context.watch<TabsCubit>().state;

          final allOrders = state.orders;

          final orders = InternalOrdersFilter.filterOrders(
            allOrders,
            selectedTab,
          );

          return Column(
            children: [
              Expanded(
                child: ListView.separated(
                  shrinkWrap: true,
                  //physics: const NeverScrollableScrollPhysics(),
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
                      );
                    }
                ),
              ),
              AppPagination(
                currentPage: state.currentPage,
                totalPages: state.pageCount,
                onPageChanged: (page) {
                  context.read<GetProviderInternalOrderCubit>().loadInternalOrders(
                    serviceId: MainCategoryConstants.mobileServicesAndTransportationID,
                    pageNumber: page,
                  );
                },
              )
            ],
          );
        }

        return const SizedBox();
      },
    );
  }
}
