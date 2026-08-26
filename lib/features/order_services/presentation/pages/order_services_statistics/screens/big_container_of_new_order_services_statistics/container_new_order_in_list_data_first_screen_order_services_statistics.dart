import 'package:flutter/cupertino.dart';
import '../../../../../../../../../core/theming/colors.dart';
import '../../../../../../../../../features/order_services/presentation/pages/order_services_statistics/screens/big_container_of_new_order_services_statistics/data_container_in_list_data_first_screen_order_services_statistics.dart';


class ContainerNewOrderInListDataFirstScreenOrderServicesStatistics extends StatelessWidget {
  final void Function()? onTap;
  final int serviceId;

  const ContainerNewOrderInListDataFirstScreenOrderServicesStatistics(
      {super.key, this.onTap,required this.serviceId});

  @override
  Widget build(BuildContext context) {
    return Container(
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
      child: DataContainerInListDataFirstScreenOrderServicesStatistics(
        onTap: onTap,
        serviceId: serviceId,
      ),
    );
  }
}
