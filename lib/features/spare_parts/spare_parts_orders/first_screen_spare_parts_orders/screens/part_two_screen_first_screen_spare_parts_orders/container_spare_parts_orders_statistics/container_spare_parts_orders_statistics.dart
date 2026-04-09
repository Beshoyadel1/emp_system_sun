import 'package:flutter/cupertino.dart';
import '../../../../../../../../features/spare_parts/spare_parts_orders/first_screen_spare_parts_orders/screens/part_two_screen_first_screen_spare_parts_orders/container_spare_parts_orders_statistics/data_in_container_spare_parts_orders_statistics.dart';
import '../../../../../../../../features/internal_services/internal_orders/first_screen_internal_orders/screens/part_two_screen_first_screen_internal_orders/container_interior_services_statistics/data_in_container_interior_services_statistics.dart';
import '../../../../../../../../core/theming/colors.dart';

class ContainerSparePartsOrdersStatistics extends StatelessWidget {
  const ContainerSparePartsOrdersStatistics({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsetsGeometry.all(20),
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
      child: const DataInContainerSparePartsOrdersStatistics(),
    );
  }
}
