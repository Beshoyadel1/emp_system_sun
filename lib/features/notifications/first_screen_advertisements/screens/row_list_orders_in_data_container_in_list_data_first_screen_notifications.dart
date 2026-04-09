import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../../../features/notifications/first_screen_advertisements/screens/design_mobile_in_row_list_orders_in_data_container_in_list_data_first_screen_notifications.dart';
import '../../../../../../features/notifications/first_screen_advertisements/screens/design_web_in_row_list_orders_in_data_container_in_list_data_first_screen_notifications.dart';
import '../../../../../../features/notifications/first_screen_advertisements/logic/select_order_notification_cubit.dart';

class RowListOrdersInDataContainerInListDataFirstScreenNotifications
    extends StatelessWidget {
  const RowListOrdersInDataContainerInListDataFirstScreenNotifications(
      {super.key});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    bool isTab = size.width > 600;

    return BlocProvider(
      create: (_) => SelectOrderNotificationCubit(),
      child: isTab
          ? DesignWebInRowListOrdersInDataContainerInListDataFirstScreenNotifications()
          : DesignMobileInRowListOrdersInDataContainerInListDataFirstScreenNotifications(),
    );
  }
}
