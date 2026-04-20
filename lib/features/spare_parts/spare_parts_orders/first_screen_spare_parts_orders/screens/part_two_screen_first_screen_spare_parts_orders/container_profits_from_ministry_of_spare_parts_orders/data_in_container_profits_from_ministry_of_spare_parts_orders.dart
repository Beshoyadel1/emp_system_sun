import 'package:flutter/cupertino.dart';
import '../../../../../../../features/spare_parts/spare_parts_orders/first_screen_spare_parts_orders/screens/part_two_screen_first_screen_spare_parts_orders/container_profits_from_ministry_of_spare_parts_orders/first_row_in_data_in_container_profits_from_ministry_of_spare_parts_orders.dart';
import '../../../../../../../features/spare_parts/spare_parts_orders/first_screen_spare_parts_orders/screens/part_two_screen_first_screen_spare_parts_orders/container_profits_from_ministry_of_spare_parts_orders/second_row_in_data_in_container_profits_from_ministry_of_spare_parts_orders.dart';

class DataInContainerProfitsFromMinistryOfSparePartsOrders
    extends StatelessWidget {
  const DataInContainerProfitsFromMinistryOfSparePartsOrders({super.key});

  @override
  Widget build(BuildContext context) {
    return const Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      spacing: 10,
      children: [
        FirstRowInDataInContainerProfitsFromMinistryOfSparePartsOrders(),
        SecondRowInDataInContainerProfitsFromMinistryOfSparePartsOrders()
      ],
    );
  }
}
