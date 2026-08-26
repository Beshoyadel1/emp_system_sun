import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../../../../../../core/theming/colors.dart';
import '../../../../../../../../../core/utilies/map_of_all_app.dart';
import '../../../../internal_services/presentation/cubit/loading_dashboard/loading_dashboard_cubit.dart';
import '../../../../../../../../../features/order_services/presentation/pages/order_services_statistics/screens/list_data_order_services_statistics.dart';
import '../../../../../../../../../features/order_services/presentation/pages/order_services_statistics/screens/part_two_screen_first_screen_order_services_statistics/container_order_services_statistics/container_order_services_statistics.dart';
import '../../../../../../../../../features/order_services/presentation/pages/order_services_statistics/screens/part_two_screen_first_screen_order_services_statistics/container_profits_from_ministry_of_order_services_statistics/container_profits_from_ministry_of_order_services_statistics.dart';
import '../../../../../../../../../features/order_services/presentation/pages/order_services_statistics/screens/part_two_screen_first_screen_order_services_statistics/container_rate_service_order_services_statistics/container_rate_order_services_statistics.dart';


class OrderServicesStatistics extends StatelessWidget {
  final int serviceId;
  const OrderServicesStatistics({super.key,required this.serviceId});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    bool isMobile = size.width <= ValuesOfAllApp.mobileWidth + 200;
    return BlocProvider(
      create: (_) => InternalOrdersCubit()
        ..getStatistics(
          mainServiceId: serviceId,
        ),
      child: Scaffold(
        backgroundColor: AppColors.scaffoldColor,
        body: SafeArea(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
               Expanded(
                flex: 2,
                child: Padding(
                  padding: const EdgeInsets.all(20),
                  child: SingleChildScrollView(
                    child: ListDataOrderServicesStatistics(serviceId: serviceId),
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
                            ContainerProfitsFromMinistryOfOrderServicesStatistics(),
                            ContainerOrderServicesStatistics(),
                            ContainerRateOrderServicesStatistics(),
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
