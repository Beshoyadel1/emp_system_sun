import 'package:flutter/cupertino.dart';
import 'package:emp_system_sun/features/internal_services/presentation/pages/internal_orders/first_screen_internal_orders/screens/big_container_of_new_orders/first_row_in_data_container_in_list_data_first_screen_internal_orders.dart';
import 'package:emp_system_sun/features/spare_parts/presentation/pages/spare_parts_orders/first_screen_spare_parts_orders/screens/big_container_of_new_orders_spare_parts/part_container_big_container_of_new_orders_spare_parts_orders/second_part_data_container_in_list_data_first_screen_spare_parts_orders.dart';

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
