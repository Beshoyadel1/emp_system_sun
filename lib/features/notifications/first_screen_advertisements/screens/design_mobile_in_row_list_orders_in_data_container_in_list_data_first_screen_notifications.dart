import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../../../core/language/language_constant.dart';
import '../../../../../../features/notifications/first_screen_advertisements/logic/select_order_notification_cubit.dart';
import '../../../../../../features/notifications/custom_widget/container_list_orders_in_data_container_in_list_data_first_screen_notifications_widget.dart';

class DesignMobileInRowListOrdersInDataContainerInListDataFirstScreenNotifications
    extends StatelessWidget {
  const DesignMobileInRowListOrdersInDataContainerInListDataFirstScreenNotifications(
      {super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SelectOrderNotificationCubit, int>(
      builder: (context, selectedIndex) {
        return Column(
          spacing: 8,
          children: List.generate(
            (items.length / 2).ceil(),
            (rowIndex) {
              final start = rowIndex * 2;
              final end = (start + 2 < items.length) ? start + 2 : items.length;
              final rowItems = items.sublist(start, end);

              return Row(
                mainAxisAlignment: MainAxisAlignment.center,
                spacing: 8,
                children: rowItems.map((text) {
                  final index = items.indexOf(text);
                  return Expanded(
                    child:
                        ContainerListOrdersInDataContainerInListDataFirstScreenNotificationsWidget(
                      text: text,
                      isSelect: selectedIndex == index,
                      onTap: () => context
                          .read<SelectOrderNotificationCubit>()
                          .select(index),
                    ),
                  );
                }).toList(),
              );
            },
          ),
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
