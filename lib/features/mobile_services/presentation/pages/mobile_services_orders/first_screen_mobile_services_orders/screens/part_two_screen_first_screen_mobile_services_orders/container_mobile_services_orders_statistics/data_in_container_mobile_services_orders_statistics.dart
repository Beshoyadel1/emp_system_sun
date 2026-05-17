import 'package:emp_system_sun/features/mobile_services/presentation/pages/mobile_services_orders/first_screen_mobile_services_orders/screens/part_two_screen_first_screen_mobile_services_orders/container_mobile_services_orders_statistics/fast_line_with_fill_mobile_services_orders.dart';
import 'package:emp_system_sun/features/mobile_services/presentation/pages/mobile_services_orders/first_screen_mobile_services_orders/screens/part_two_screen_first_screen_mobile_services_orders/container_mobile_services_orders_statistics/first_row_in_data_in_container_mobile_services_orders_statistics.dart';
import 'package:flutter/cupertino.dart';

class DataInContainerMobileServicesOrdersStatistics extends StatelessWidget {
  const DataInContainerMobileServicesOrdersStatistics({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      spacing: 10,
      children: [
        const FirstRowInDataInContainerMobileServicesOrdersStatistics(),
        FastLineWithFillMobileServicesOrders(),
      ],
    );
  }
}
