import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../../../../core/api/dio_function/api_constants.dart';
import '../../../../../../../features/spare_parts/spare_parts_orders/first_screen_spare_parts_orders/screens/part_two_screen_first_screen_spare_parts_orders/container_spare_parts_orders_statistics/container_spare_parts_orders_statistics.dart';
import '../../../../../features/mobile_services/mobile_services_orders/first_screen_mobile_services_orders/screens/part_two_screen_first_screen_mobile_services_orders/container_profits_from_ministry_of_mobile_services_orders/container_profits_from_ministry_of_mobile_services_orders.dart';
import '../../../../../features/mobile_services/mobile_services_orders/first_screen_mobile_services_orders/screens/part_two_screen_first_screen_mobile_services_orders/container_rate_service_mobile_services_orders/container_rate_service_mobile_services_orders.dart';
import '../../../../../features/internal_services/internal_orders/first_screen_internal_orders/logic/loading_dashboard/loading_dashboard_cubit.dart';
import '../../../../../features/spare_parts/spare_parts_orders/first_screen_spare_parts_orders/screens/list_data_first_screen_spare_parts_orders.dart';
import '../../../../../core/utilies/map_of_all_app.dart';
import '../../../../../core/theming/colors.dart';

class FirstScreenSparePartsOrders extends StatelessWidget {
  const FirstScreenSparePartsOrders({super.key});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    bool isMobile = size.width <= ValuesOfAllApp.mobileWidth+200;
    return BlocProvider(
      create: (_) => InternalOrdersCubit()
        ..getStatistics(
          mainServiceId: MainCategoryConstants.carSparePartsID,
        ),
      child: Scaffold(
        backgroundColor: AppColors.scaffoldColor,
        body: SafeArea(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Expanded(
                flex: 2,
                child: Padding(
                  padding: EdgeInsets.all(20),
                  child: SingleChildScrollView(
                    child: ListDataFirstScreenSparePartsOrders(),
                  ),
                ),
              ),
              if ((!isMobile))
                const Expanded(
                  flex: 1,
                  child: Padding(
                    padding: EdgeInsets.all(10.0),
                    child: SingleChildScrollView(
                      child: SizedBox(
                        width: 500,
                        child: Column(
                          spacing: 20,
                          children: [
                            ContainerProfitsFromMinistryOfSparePartsOrders(),
                            ContainerSparePartsOrdersStatistics(),
                            ContainerRateServiceSparePartsOrders(),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
