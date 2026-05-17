import 'package:emp_system_sun/features/mobile_services/presentation/pages/mobile_services_orders/first_screen_mobile_services_orders/screens/part_two_screen_first_screen_mobile_services_orders/container_rate_service_mobile_services_orders/first_row_in_data_in_container_rate_service_mobile_services_orders.dart';
import 'package:emp_system_sun/features/mobile_services/presentation/pages/mobile_services_orders/first_screen_mobile_services_orders/screens/part_two_screen_first_screen_mobile_services_orders/container_rate_service_mobile_services_orders/second_row_in_data_in_container_rate_service_mobile_services_orders.dart';
import 'package:flutter/cupertino.dart';

class DataInContainerRateServiceSparePartsOrders extends StatelessWidget {
  const DataInContainerRateServiceSparePartsOrders({super.key});

  @override
  Widget build(BuildContext context) {
    return const Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        FirstRowInDataInContainerRateServiceSparePartsOrders(),
        SecondRowInDataInContainerRateServiceSparePartsOrders()
      ],
    );
  }
}
