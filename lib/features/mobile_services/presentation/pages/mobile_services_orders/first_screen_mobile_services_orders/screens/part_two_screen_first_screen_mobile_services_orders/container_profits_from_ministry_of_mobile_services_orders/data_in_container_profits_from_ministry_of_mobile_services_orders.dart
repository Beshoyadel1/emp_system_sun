import 'package:emp_system_sun/features/mobile_services/presentation/pages/mobile_services_orders/first_screen_mobile_services_orders/screens/part_two_screen_first_screen_mobile_services_orders/container_profits_from_ministry_of_mobile_services_orders/first_row_in_data_in_container_profits_from_ministry_of_mobile_services_orders.dart';
import 'package:emp_system_sun/features/mobile_services/presentation/pages/mobile_services_orders/first_screen_mobile_services_orders/screens/part_two_screen_first_screen_mobile_services_orders/container_profits_from_ministry_of_mobile_services_orders/second_row_in_data_in_container_profits_from_ministry_of_mobile_services_orders.dart';
import 'package:flutter/cupertino.dart';

class DataInContainerProfitsFromMinistryOfMobileServicesOrders
    extends StatelessWidget {
  const DataInContainerProfitsFromMinistryOfMobileServicesOrders({super.key});

  @override
  Widget build(BuildContext context) {
    return const Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      spacing: 10,
      children: [
        FirstRowInDataInContainerProfitsFromMinistryOfMobileServicesOrders(),
        SecondRowInDataInContainerProfitsFromMinistryOfMobileServicesOrders()
      ],
    );
  }
}
