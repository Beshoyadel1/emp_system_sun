import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../logic/loading_dashboard/loading_dashboard_cubit.dart';
import '../../../logic/loading_dashboard/loading_dashboard_state.dart';
import '../../../../../../../../features/internal_services/internal_orders/first_screen_internal_orders/screens/part_two_screen_first_screen_internal_orders/container_interior_services_statistics/FastLineWithFill.dart';
import '../../../../../../../../features/internal_services/internal_orders/first_screen_internal_orders/screens/part_two_screen_first_screen_internal_orders/container_interior_services_statistics/first_row_in_data_in_container_interior_services_statistics.dart';

class DataInContainerInteriorServicesStatistics extends StatelessWidget {
  const DataInContainerInteriorServicesStatistics({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      spacing: 10,
      children: [
        const FirstRowInDataInContainerInteriorServicesStatistics(),
        FastLineWithFill(),
      ],
    );
  }
}
