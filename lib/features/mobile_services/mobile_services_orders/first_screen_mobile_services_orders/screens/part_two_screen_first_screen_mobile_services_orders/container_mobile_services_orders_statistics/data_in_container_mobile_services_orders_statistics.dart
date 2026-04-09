import 'package:flutter/cupertino.dart';
import '../../../../../../../../features/mobile_services/mobile_services_orders/first_screen_mobile_services_orders/screens/part_two_screen_first_screen_mobile_services_orders/container_mobile_services_orders_statistics/fast_line_with_fill_mobile_services_orders.dart';
import '../../../../../../../../features/mobile_services/mobile_services_orders/first_screen_mobile_services_orders/screens/part_two_screen_first_screen_mobile_services_orders/container_mobile_services_orders_statistics/first_row_in_data_in_container_mobile_services_orders_statistics.dart';
import '../../../../../../../../features/spare_parts/spare_parts_orders/first_screen_spare_parts_orders/screens/part_two_screen_first_screen_spare_parts_orders/container_spare_parts_orders_statistics/fast_line_with_fill_spare_parts_orders.dart';
import '../../../../../../../../features/spare_parts/spare_parts_orders/first_screen_spare_parts_orders/screens/part_two_screen_first_screen_spare_parts_orders/container_spare_parts_orders_statistics/first_row_in_data_in_container_spare_parts_orders_statistics.dart';

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
