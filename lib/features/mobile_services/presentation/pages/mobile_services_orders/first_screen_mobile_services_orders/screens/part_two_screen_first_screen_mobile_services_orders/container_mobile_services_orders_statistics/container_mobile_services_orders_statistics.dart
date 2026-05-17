import 'package:emp_system_sun/core/theming/colors.dart';
import 'package:emp_system_sun/features/mobile_services/presentation/pages/mobile_services_orders/first_screen_mobile_services_orders/screens/part_two_screen_first_screen_mobile_services_orders/container_mobile_services_orders_statistics/data_in_container_mobile_services_orders_statistics.dart';
import 'package:flutter/cupertino.dart';

class ContainerMobileServicesOrdersStatistics extends StatelessWidget {
  const ContainerMobileServicesOrdersStatistics({super.key});

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
      child: const DataInContainerMobileServicesOrdersStatistics(),
    );
  }
}
