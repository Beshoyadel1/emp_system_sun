import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../../../../features/spare_parts/spare_parts_orders/first_screen_spare_parts_orders/screens/part_two_screen_first_screen_spare_parts_orders/container_profits_from_ministry_of_spare_parts_orders/four_part_circle_spare_parts_orders.dart';
import '../../../../../../../features/spare_parts/spare_parts_orders/first_screen_spare_parts_orders/screens/part_two_screen_first_screen_spare_parts_orders/container_profits_from_ministry_of_spare_parts_orders/services_legend_list_spare_parts_orders.dart';
import '../../../../../../../features/internal_services/internal_orders/first_screen_internal_orders/logic/loading_dashboard/loading_dashboard_cubit.dart';
import '../../../../../../../features/internal_services/internal_orders/first_screen_internal_orders/logic/loading_dashboard/loading_dashboard_state.dart';

class SecondRowInDataInContainerProfitsFromMinistryOfSparePartsOrders
    extends StatelessWidget {
  const SecondRowInDataInContainerProfitsFromMinistryOfSparePartsOrders({
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
              child: FourPartCircleSparePartsOrders(
                services: services,
              ),
            ),
            Flexible(
              flex: 1,
              child: ServicesLegendListSparePartsOrders(
                services: services,
              ),
            ),
          ],
        );
      },
    );
  }
}
