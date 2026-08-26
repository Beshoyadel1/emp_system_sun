import 'package:flutter/cupertino.dart';
import '../../../../../../../../../features/order_services/presentation/pages/order_services_statistics/screens/part_two_screen_first_screen_order_services_statistics/container_order_services_statistics/fast_line_with_fill_order_services_statistics.dart';
import '../../../../../../../../../features/order_services/presentation/pages/order_services_statistics/screens/part_two_screen_first_screen_order_services_statistics/container_order_services_statistics/first_row_in_data_in_container_order_services_statistics.dart';

class DataInContainerOrderServicesStatistics extends StatelessWidget {
  const DataInContainerOrderServicesStatistics({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      spacing: 10,
      children: [
        const FirstRowInDataInContainerOrderServicesStatistics(),
        FastLineWithFillOrderServicesStatistics(),
      ],
    );
  }
}
