import 'package:flutter/cupertino.dart';
import '../../../../../../../core/api/dio_function/api_constants.dart';
import '../../../../../../../features/internal_services/internal_orders/first_screen_internal_orders/screens/big_container_of_new_orders/first_row_in_data_container_in_list_data_first_screen_internal_orders.dart';
import 'part_container_big_container_of_new_orders/second_part_data_container_in_list_data_first_screen_internal_orders.dart';

class DataContainerInListDataFirstScreenInternalOrders extends StatelessWidget {
  final void Function()? onTap;
  final bool? isLoading;

  const DataContainerInListDataFirstScreenInternalOrders(
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
         const  SecondPartDataContainerInListDataFirstScreenInternalOrders()
        ],
      ),
    );
  }
}
