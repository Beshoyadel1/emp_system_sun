import 'package:flutter/cupertino.dart';
import '../../../../../../../features/internal_services/internal_orders/first_screen_internal_orders/screens/big_container_of_new_orders/data_container_in_list_data_first_screen_internal_orders.dart';
import '../../../../../../../core/theming/colors.dart';

class ContainerNewOrderInListDataFirstScreenInternalOrders
    extends StatelessWidget {
  final void Function()? onTap;

  const ContainerNewOrderInListDataFirstScreenInternalOrders(
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
      child: DataContainerInListDataFirstScreenInternalOrders(
        onTap: onTap,
      ),
    );
  }
}
