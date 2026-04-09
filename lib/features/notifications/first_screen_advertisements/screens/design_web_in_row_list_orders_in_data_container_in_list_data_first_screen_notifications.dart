import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../../../core/language/language_constant.dart';
import '../../../../../../features/notifications/first_screen_advertisements/logic/select_order_notification_cubit.dart';
import '../../../../../../features/notifications/custom_widget/container_list_orders_in_data_container_in_list_data_first_screen_notifications_widget.dart';

class DesignWebInRowListOrdersInDataContainerInListDataFirstScreenNotifications
    extends StatelessWidget {
  const DesignWebInRowListOrdersInDataContainerInListDataFirstScreenNotifications(
      {super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SelectOrderNotificationCubit, int>(
      builder: (context, selectedIndex) {
        return Row(
          spacing: 5,
          children: List.generate(items.length, (index) {
            return ContainerListOrdersInDataContainerInListDataFirstScreenNotificationsWidget(
              text: items[index],
              isSelect: selectedIndex == index,
              onTap: () =>
                  context.read<SelectOrderNotificationCubit>().select(index),
            );
          }),
        );
      },
    );
  }
}

final items = [
  AppLanguageKeys.allOrders,
  AppLanguageKeys.newOrders,
  AppLanguageKeys.underService,
  AppLanguageKeys.completedOrders,
];
