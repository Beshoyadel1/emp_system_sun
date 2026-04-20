import 'package:flutter/cupertino.dart';
import '../../../../../../../features/spare_parts/spare_parts_orders/first_screen_spare_parts_orders/screens/part_two_screen_first_screen_spare_parts_orders/container_spare_parts_orders_statistics/fast_line_with_fill_spare_parts_orders.dart';
import '../../../../../../../features/spare_parts/spare_parts_orders/first_screen_spare_parts_orders/screens/part_two_screen_first_screen_spare_parts_orders/container_spare_parts_orders_statistics/first_row_in_data_in_container_spare_parts_orders_statistics.dart';

class DataInContainerSparePartsOrdersStatistics extends StatelessWidget {
  const DataInContainerSparePartsOrdersStatistics({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      spacing: 10,
      children: [
        const FirstRowInDataInContainerSparePartsOrdersStatistics(),
        FastLineWithFillSparePartsOrders(),
      ],
    );
  }
}
