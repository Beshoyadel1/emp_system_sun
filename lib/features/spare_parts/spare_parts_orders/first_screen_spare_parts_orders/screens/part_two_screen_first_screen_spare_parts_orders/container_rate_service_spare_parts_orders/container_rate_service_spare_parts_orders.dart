import 'package:flutter/cupertino.dart';
import '../../../../../../../../features/spare_parts/spare_parts_orders/first_screen_spare_parts_orders/screens/part_two_screen_first_screen_spare_parts_orders/container_rate_service_spare_parts_orders/data_in_container_rate_service_spare_parts_orders.dart';
import '../../../../../../../../core/theming/colors.dart';

class ContainerRateServiceSparePartsOrders extends StatelessWidget {
  const ContainerRateServiceSparePartsOrders({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 200,
      padding: const EdgeInsetsGeometry.all(10),
      decoration: BoxDecoration(
        color: AppColors.whiteColor,
        borderRadius: const BorderRadius.all(Radius.circular(20)),
        border: Border.all(color: AppColors.greyColor.withOpacity(0.3)),
        boxShadow: [
          BoxShadow(
            color: AppColors.darkColor.withOpacity(0.1),
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: const DataInContainerRateServiceSparePartsOrders(),
    );
  }
}
