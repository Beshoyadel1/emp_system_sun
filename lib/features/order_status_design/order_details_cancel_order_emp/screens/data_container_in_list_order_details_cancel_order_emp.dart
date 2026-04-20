import 'package:emp_system_sun/features/order_status_design/custom_widget/container_return_to_page_setting.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../../../../../../../core/api_functions/order/get_provider_orders_model/order_model.dart';
import '../../../../../../../features/order_status_design/order_details_new_order_emp/screens/custom_container_order.dart';
import '../../../../../../features/order_status_design/custom_widget/title_with_sub_title_in_order_details_emp.dart';
import '../../../../../../features/order_status_design/order_details_new_order_emp/screens/part_left_screen/container_contact_with_customer_order_details_new_order_emp.dart';
import '../../../../../../features/order_status_design/order_details_new_order_emp/screens/part_left_screen/data_time_line_tile_order_details_new_order_emp.dart';
import '../../../../../../core/language/language_constant.dart';

class DataContainerInListOrderDetailsCancelOrderEmp extends StatelessWidget {
  final OrderModel order;

  const DataContainerInListOrderDetailsCancelOrderEmp({super.key,required this.order});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    bool isMobile = size.width <= 950;
    return Padding(
      padding: const EdgeInsets.all(15.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: 30,
        children: [
          if(isMobile)
            ContainerReturnToPageSetting(
              text: AppLanguageKeys.back,
              onTap: (){
                Navigator.pop(context);
              },
            ),
          const TitleWithSubTitleInOrderDetailsEmp(),
          CustomContainerOrder(
              order:order
          ),
          if (isMobile)
            const Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              spacing: 30,
              children: [
                 ContainerContactWithCustomerOrderDetailsNewOrderEmp(),
                 DataTimeLineTileOrderDetailsNewOrderEmp()
              ],
            ),
        ],
      ),
    );
  }
}
