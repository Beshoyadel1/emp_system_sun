import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../../../../../../../core/api_functions/order/get_provider_orders_model/order_model.dart';
import '../../../../../../../features/order_status_design/order_details_reject_by_company_order_emp/screens/data_container_in_list_order_details_reject_by_company_order_emp.dart';
import '../../../../../../../features/order_status_design/order_details_reject_by_provider_order_emp/screens/data_container_in_list_order_details_reject_by_provider_order_emp.dart';
import '../../../../../../core/theming/colors.dart';

class ListDataOrderDetailsRejectByCompanyOrderEmp extends StatelessWidget {
  final OrderModel order;
  const ListDataOrderDetailsRejectByCompanyOrderEmp({super.key,required this.order});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsetsGeometry.all(10),
      decoration: BoxDecoration(
        color: AppColors.whiteColor,
        borderRadius: const BorderRadius.all(Radius.circular(20)),
        border: Border.all(
            color: AppColors.greyColor.withOpacity(0.3)
        ),
        boxShadow: [
          BoxShadow(
            color: AppColors.darkColor.withOpacity(0.1),
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: DataContainerInListOrderDetailsRejectByCompanyOrderEmp(
          order:order
      ),
    );
  }
}
