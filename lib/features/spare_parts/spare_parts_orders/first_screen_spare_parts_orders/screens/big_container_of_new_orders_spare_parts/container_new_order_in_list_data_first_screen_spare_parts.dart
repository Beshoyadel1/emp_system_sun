import 'package:flutter/cupertino.dart';
import '../../../../../../../features/spare_parts/spare_parts_orders/first_screen_spare_parts_orders/screens/big_container_of_new_orders_spare_parts/data_container_in_list_data_first_screen_spare_parts_orders.dart';
import '../../../../../../../core/theming/colors.dart';

class ContainerNewOrderInListDataFirstScreenSpareParts extends StatelessWidget {
  final void Function()? onTap;

  const ContainerNewOrderInListDataFirstScreenSpareParts(
      {super.key, this.onTap});

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
      child: DataContainerInListDataFirstScreenSparePartsOrders(
        onTap: onTap,
      ),
    );
  }
}
