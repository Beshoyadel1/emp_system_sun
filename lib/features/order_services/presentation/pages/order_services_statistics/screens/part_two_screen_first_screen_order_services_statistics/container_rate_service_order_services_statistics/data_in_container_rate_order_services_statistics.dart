import 'package:flutter/cupertino.dart';
import '../../../../../../../../../features/order_services/presentation/pages/order_services_statistics/screens/part_two_screen_first_screen_order_services_statistics/container_rate_service_order_services_statistics/first_row_in_data_in_container_rate_order_services_statistics.dart';
import '../../../../../../../../../features/order_services/presentation/pages/order_services_statistics/screens/part_two_screen_first_screen_order_services_statistics/container_rate_service_order_services_statistics/second_row_in_data_in_container_rate_service_order_services_statistics.dart';

class DataInContainerRateOrderServicesStatistics extends StatelessWidget {
  const DataInContainerRateOrderServicesStatistics({super.key});

  @override
  Widget build(BuildContext context) {
    return const Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        FirstRowInDataInContainerRateOrderServicesStatistics(),
        SecondRowInDataInContainerRateServiceOrderServicesStatistics()
      ],
    );
  }
}
