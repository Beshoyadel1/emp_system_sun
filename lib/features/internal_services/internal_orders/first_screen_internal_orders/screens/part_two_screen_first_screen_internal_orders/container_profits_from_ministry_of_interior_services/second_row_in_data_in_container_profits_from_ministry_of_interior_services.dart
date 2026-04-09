import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../../../../../features/internal_services/internal_orders/first_screen_internal_orders/screens/part_two_screen_first_screen_internal_orders/container_profits_from_ministry_of_interior_services/services_legend_list.dart';
import '../../../logic/loading_dashboard/loading_dashboard_cubit.dart';
import '../../../logic/loading_dashboard/loading_dashboard_state.dart';
import '../../../../../../../../features/internal_services/internal_orders/first_screen_internal_orders/screens/part_two_screen_first_screen_internal_orders/container_profits_from_ministry_of_interior_services/FourPartCircle.dart';

class SecondRowInDataInContainerProfitsFromMinistryOfInteriorServices
    extends StatelessWidget {
  const SecondRowInDataInContainerProfitsFromMinistryOfInteriorServices({
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
              child: FourPartDoughnut(
                services: services,
              ),
            ),
            Flexible(
              flex: 1,
              child: ServicesLegendList(
                services: services,
              ),
            ),
          ],
        );
      },
    );
  }
}
