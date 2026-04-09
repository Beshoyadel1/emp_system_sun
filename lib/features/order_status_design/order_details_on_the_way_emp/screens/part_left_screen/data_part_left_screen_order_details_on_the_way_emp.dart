import 'package:emp_system_sun/features/internal_services/custom_widget/container_return_to_page_setting.dart';
import 'package:flutter/material.dart';
import '../../../../../../../features/order_status_design/order_details_on_the_way_emp/screens/part_left_screen/container_contact_with_customer_order_details_on_the_way_emp.dart';
import '../../../../../../../features/order_status_design/order_details_on_the_way_emp/screens/part_left_screen/data_time_line_tile_order_details_on_the_way_emp.dart';
import '../../../../../../../../core/language/language_constant.dart';


class DataPartLeftScreenOrderDetailsOnTheWayEmp extends StatelessWidget {
  const DataPartLeftScreenOrderDetailsOnTheWayEmp({super.key});

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
        const ContainerContactWithCustomerOrderDetailsOnTheWayEmp(),
        const DataTimeLineTileOrderDetailsOnTheWayEmp()
    ],
    );
  }
}