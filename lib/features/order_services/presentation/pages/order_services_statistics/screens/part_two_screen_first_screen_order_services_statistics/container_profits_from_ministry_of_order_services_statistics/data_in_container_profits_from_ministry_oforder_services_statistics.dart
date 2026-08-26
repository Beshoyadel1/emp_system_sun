import 'package:flutter/cupertino.dart';
import '../../../../../../../../../features/order_services/presentation/pages/order_services_statistics/screens/part_two_screen_first_screen_order_services_statistics/container_profits_from_ministry_of_order_services_statistics/first_row_in_data_in_container_profits_from_ministry_of_order_services_statistics.dart';
import '../../../../../../../../../features/order_services/presentation/pages/order_services_statistics/screens/part_two_screen_first_screen_order_services_statistics/container_profits_from_ministry_of_order_services_statistics/second_row_in_data_in_container_profits_from_ministry_of_order_services_statistics.dart';

class DataInContainerProfitsFromMinistryOforderServicesStatistics
    extends StatelessWidget {
  const DataInContainerProfitsFromMinistryOforderServicesStatistics({super.key});

  @override
  Widget build(BuildContext context) {
    return const Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      spacing: 10,
      children: [
        FirstRowInDataInContainerProfitsFromMinistryOfOrderServicesStatistics(),
        SecondRowInDataInContainerProfitsFromMinistryOfOrderServicesStatistics()
      ],
    );
  }
}
