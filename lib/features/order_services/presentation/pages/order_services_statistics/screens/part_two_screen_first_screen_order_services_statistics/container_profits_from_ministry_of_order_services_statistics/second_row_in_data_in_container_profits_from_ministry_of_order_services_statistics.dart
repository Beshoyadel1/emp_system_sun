import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../../../../internal_services/presentation/cubit/loading_dashboard/loading_dashboard_cubit.dart';
import '../../../../../../../internal_services/presentation/cubit/loading_dashboard/loading_dashboard_state.dart';
import '../../../../../../../../../features/order_services/presentation/pages/order_services_statistics/screens/part_two_screen_first_screen_order_services_statistics/container_profits_from_ministry_of_order_services_statistics/four_part_circle_order_services_statistics.dart';
import '../../../../../../../../../features/order_services/presentation/pages/order_services_statistics/screens/part_two_screen_first_screen_order_services_statistics/container_profits_from_ministry_of_order_services_statistics/services_legend_list_order_services_statistics.dart';

class SecondRowInDataInContainerProfitsFromMinistryOfOrderServicesStatistics
    extends StatelessWidget {
  const SecondRowInDataInContainerProfitsFromMinistryOfOrderServicesStatistics({
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
              child: FourPartCircleOrderServicesStatistics(
                services: services,
              ),
            ),
            Flexible(
              flex: 1,
              child: ServicesLegendListOrderServicesStatistics(
                services: services,
              ),
            ),
          ],
        );
      },
    );
  }
}
