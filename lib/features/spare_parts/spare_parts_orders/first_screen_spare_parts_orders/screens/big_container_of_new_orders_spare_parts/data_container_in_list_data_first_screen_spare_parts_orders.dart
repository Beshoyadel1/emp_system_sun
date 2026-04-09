import 'package:flutter/cupertino.dart';
import '../../../../../../../features/spare_parts/spare_parts_orders/first_screen_spare_parts_orders/screens/big_container_of_new_orders_spare_parts/part_container_big_container_of_new_orders_spare_parts_orders/second_part_data_container_in_list_data_first_screen_spare_parts_orders.dart';
import '../../../../../../../features/internal_services/internal_orders/first_screen_internal_orders/screens/big_container_of_new_orders/part_container_big_container_of_new_orders/second_part_data_container_in_list_data_first_screen_internal_orders.dart';
import '../../../../../../../features/internal_services/internal_orders/first_screen_internal_orders/screens/big_container_of_new_orders/first_row_in_data_container_in_list_data_first_screen_internal_orders.dart';

class DataContainerInListDataFirstScreenSparePartsOrders extends StatelessWidget {
  final void Function()? onTap;
  final bool? isLoading;

  const DataContainerInListDataFirstScreenSparePartsOrders(
      {super.key, this.onTap, this.isLoading = false});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(15.0),
      child: Column(
        spacing: 30,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          FirstRowInDataContainerInListDataFirstScreenInternalOrders(
            onTap: onTap,
          ),
         const  SecondPartDataContainerInListDataFirstScreenSparePartsOrders()
        ],
      ),
    );
  }
}
