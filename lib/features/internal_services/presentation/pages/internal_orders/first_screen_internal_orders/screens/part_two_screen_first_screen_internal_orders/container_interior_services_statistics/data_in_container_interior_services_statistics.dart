import 'package:flutter/cupertino.dart';
import '../../../../../../../../../features/internal_services/presentation/pages/internal_orders/first_screen_internal_orders/screens/part_two_screen_first_screen_internal_orders/container_interior_services_statistics/FastLineWithFill.dart';
import '../../../../../../../../../features/internal_services/presentation/pages/internal_orders/first_screen_internal_orders/screens/part_two_screen_first_screen_internal_orders/container_interior_services_statistics/first_row_in_data_in_container_interior_services_statistics.dart';

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
