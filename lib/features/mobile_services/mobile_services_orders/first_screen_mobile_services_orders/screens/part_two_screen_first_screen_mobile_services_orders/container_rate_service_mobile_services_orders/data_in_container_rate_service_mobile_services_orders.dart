import 'package:flutter/cupertino.dart';
import '../../../../../../../../features/spare_parts/spare_parts_orders/first_screen_spare_parts_orders/screens/part_two_screen_first_screen_spare_parts_orders/container_rate_service_spare_parts_orders/first_row_in_data_in_container_rate_service_spare_parts_orders.dart';
import '../../../../../../../../features/spare_parts/spare_parts_orders/first_screen_spare_parts_orders/screens/part_two_screen_first_screen_spare_parts_orders/container_rate_service_spare_parts_orders/second_row_in_data_in_container_rate_service_spare_parts_orders.dart';

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
