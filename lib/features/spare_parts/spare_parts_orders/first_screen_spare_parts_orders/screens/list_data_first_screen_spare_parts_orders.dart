import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../../../../core/cubit/app_cubit/app_cubit.dart';
import '../../../../../../../features/mobile_services/mobile_services_orders/first_screen_mobile_services_orders/screens/part_two_screen_first_screen_mobile_services_orders/container_rate_service_mobile_services_orders/container_rate_service_mobile_services_orders.dart';
import '../../../../../../../features/spare_parts/spare_parts_orders/first_screen_spare_parts_orders/screens/part_two_screen_first_screen_spare_parts_orders/container_profits_from_ministry_of_spare_parts_orders/container_profits_from_ministry_of_spare_parts_orders.dart';
import '../../../../../../../features/spare_parts/spare_parts_orders/first_screen_spare_parts_orders/screens/part_two_screen_first_screen_spare_parts_orders/container_spare_parts_orders_statistics/container_spare_parts_orders_statistics.dart';
import '../../../../../core/utilies/map_of_all_app.dart';
import '../../../../../features/internal_services/internal_orders/first_screen_internal_orders/logic/loading_dashboard/loading_dashboard_cubit.dart';
import '../../../../../features/internal_services/internal_orders/first_screen_internal_orders/logic/loading_dashboard/loading_dashboard_state.dart';
import '../../../../../features/internal_services/internal_orders/first_screen_internal_orders/screens/part_two_screen_first_screen_internal_orders/container_interior_services_statistics/container_interior_services_statistics.dart';
import '../../../../../features/spare_parts/spare_parts_orders/first_screen_spare_parts_orders/screens/big_container_of_new_orders_spare_parts/container_new_order_in_list_data_first_screen_spare_parts.dart';
import '../../../../../features/spare_parts/spare_parts_orders/first_screen_spare_parts_orders/screens/container_image_title_with_sub_title_spare_parts_orders/first_row_with_two_container_image_and_two_text_spare_parts_orders.dart';

class ListDataFirstScreenSparePartsOrders extends StatelessWidget {
  const ListDataFirstScreenSparePartsOrders({super.key});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    bool isMobileCustom = size.width <= 720;
    bool isMobile = size.width <= ValuesOfAllApp.mobileWidth+200&&
        size.width>720;
    bool isTabletCustom = size.width > ValuesOfAllApp.mobileWidth &&
        size.width <= ValuesOfAllApp.customTabWidth;
    bool isTab = size.width > ValuesOfAllApp.tabWidth;
    return BlocBuilder<InternalOrdersCubit, InternalOrdersState>(
      builder: (context, state) {
        return Column(
          spacing: 10,
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            const FirstRowWithTwoContainerImageAndTwoTextSparePartsOrders(),
            ContainerNewOrderInListDataFirstScreenSpareParts(
              onTap: () {
                AppCubit.get(context).navigateToPage(PagesOfAllApp.sparePartsStaticsPageNumber);
              },
            ),
            if ((isMobile&&!isMobileCustom))
              const Column(
                spacing: 10,
                children: [
                  Row(
                    spacing: 10,
                    children: [
                      Expanded(child: ContainerProfitsFromMinistryOfSparePartsOrders()),
                      Expanded(child: ContainerRateServiceSparePartsOrders())
                    ],
                  ),
                  ContainerInteriorServicesStatistics(),
                ],
              ),

            if ((!isMobile&&isMobileCustom))
              const Column(
                spacing: 10,
                children: [
                  ContainerProfitsFromMinistryOfSparePartsOrders(),
                  ContainerRateServiceSparePartsOrders(),
                  ContainerSparePartsOrdersStatistics(),
                ],
              ),
          ],
        );
      },
    );
  }
}
