import 'package:flutter/cupertino.dart';
import '../../../../../../../../../core/theming/colors.dart';
import '../../../../../../../../../features/order_services/presentation/pages/order_services_statistics/screens/part_two_screen_first_screen_order_services_statistics/container_order_services_statistics/data_in_container_order_services_statistics.dart';

class ContainerOrderServicesStatistics extends StatelessWidget {
  const ContainerOrderServicesStatistics({super.key});

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
      child: const DataInContainerOrderServicesStatistics(),
    );
  }
}
