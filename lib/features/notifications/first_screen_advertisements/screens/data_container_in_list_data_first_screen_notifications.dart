import 'package:flutter/cupertino.dart';
import '../../../../../../features/notifications/first_screen_advertisements/screens/list_data_view_items_in_data_container_in_list_data_first_screen_notifications.dart';
import '../../../../../../features/notifications/first_screen_advertisements/screens/row_list_orders_in_data_container_in_list_data_first_screen_notifications.dart';
import '../../../../../../features/notifications/first_screen_advertisements/screens/search_time_design_in_data_container_in_list_data_first_screen_notifications.dart';
import '../../../../../../features/notifications/first_screen_advertisements/screens/first_part_title_in_data_container_in_list_data_first_screen_notifications.dart';

class DataContainerInListDataFirstScreenNotifications extends StatelessWidget {
  const DataContainerInListDataFirstScreenNotifications({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      spacing: 20,
      children: [
        FirstPartTitleInDataContainerInListDataFirstScreenNotifications(),
        RowListOrdersInDataContainerInListDataFirstScreenNotifications(),
        SearchTimeDesignInDataContainerInListDataFirstScreenNotifications(),
        ListDataViewItemsInDataContainerInListDataFirstScreenNotifications()
      ],
    );
  }
}
