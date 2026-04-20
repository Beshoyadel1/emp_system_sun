import 'package:emp_system_sun/features/order_status_design/custom_widget/container_return_to_page_setting.dart';
import 'package:flutter/material.dart';
import '../../../../../../../../features/order_status_design/order_details_cancel_order_emp/screens/part_left_screen/container_contact_with_customer_order_details_cancel_order_emp.dart';
import '../../../../../../../../features/order_status_design/order_details_cancel_order_emp/screens/part_left_screen/data_time_line_tile_order_details_cancel_order_emp.dart';
import '../../../../../../../../core/language/language_constant.dart';

class DataPartLeftScreenOrderDetailsCancelOrderEmp extends StatelessWidget {
  const DataPartLeftScreenOrderDetailsCancelOrderEmp({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      spacing: 20,
      children: [
        ContainerReturnToPageSetting(
          text: AppLanguageKeys.back,
          onTap: (){
              Navigator.pop(context);
          },
        ),
        const ContainerContactWithCustomerOrderDetailsCancelOrderEmp(),
        const DataTimeLineTileOrderDetailsCancelOrderEmp()
    ],
    );
  }
}