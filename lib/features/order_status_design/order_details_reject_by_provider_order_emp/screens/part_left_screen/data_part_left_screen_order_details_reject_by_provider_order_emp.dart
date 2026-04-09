import '../../../../../../../../features/internal_services/custom_widget/container_return_to_page_setting.dart';
import 'package:flutter/material.dart';
import '../../../../../../../../features/order_status_design/order_details_reject_by_provider_order_emp/screens/part_left_screen/container_contact_with_customer_order_details_reject_by_provider_order_emp.dart';
import '../../../../../../../../features/order_status_design/order_details_reject_by_provider_order_emp/screens/part_left_screen/data_time_line_tile_order_details_reject_by_provider_order_emp.dart';
import '../../../../../../../../core/language/language_constant.dart';

class DataPartLeftScreenOrderDetailsRejectByProviderOrderEmp extends StatelessWidget {
  const DataPartLeftScreenOrderDetailsRejectByProviderOrderEmp({super.key});

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
        const ContainerContactWithCustomerOrderDetailsRejectByProviderOrderEmp(),
        const DataTimeLineTileOrderDetailsRejectByProviderOrderEmp()
    ],
    );
  }
}