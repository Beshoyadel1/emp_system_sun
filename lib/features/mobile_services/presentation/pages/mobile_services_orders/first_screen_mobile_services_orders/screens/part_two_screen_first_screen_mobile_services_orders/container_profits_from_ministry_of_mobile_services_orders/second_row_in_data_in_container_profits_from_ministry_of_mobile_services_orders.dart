import 'package:emp_system_sun/features/internal_services/presentation/cubit/loading_dashboard/loading_dashboard_cubit.dart';
import 'package:emp_system_sun/features/internal_services/presentation/cubit/loading_dashboard/loading_dashboard_state.dart';
import 'package:emp_system_sun/features/mobile_services/presentation/pages/mobile_services_orders/first_screen_mobile_services_orders/screens/part_two_screen_first_screen_mobile_services_orders/container_profits_from_ministry_of_mobile_services_orders/four_part_circle_mobile_services_orders.dart';
import 'package:emp_system_sun/features/mobile_services/presentation/pages/mobile_services_orders/first_screen_mobile_services_orders/screens/part_two_screen_first_screen_mobile_services_orders/container_profits_from_ministry_of_mobile_services_orders/services_legend_list_mobile_services_orders.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SecondRowInDataInContainerProfitsFromMinistryOfMobileServicesOrders
    extends StatelessWidget {
  const SecondRowInDataInContainerProfitsFromMinistryOfMobileServicesOrders({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<InternalOrdersCubit, InternalOrdersState>(
      builder: (context, state) {
        final services = state.services;
        return Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          spacing: 10,
          children: [
            Flexible(
              flex: 1,
              child: FourPartCircleMobileServicesOrders(
                services: services,
              ),
            ),
            Flexible(
              flex: 1,
              child: ServicesLegendListMobileServicesOrders(
                services: services,
              ),
            ),
          ],
        );
      },
    );
  }
}
