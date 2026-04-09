import 'package:flutter/cupertino.dart';
import '../../custom_widget/column_text_with_select_time_in_notification_widget.dart';
import '../../../../../../core/language/language_constant.dart';

class SearchTimeDesignInDataContainerInListDataFirstScreenNotifications
    extends StatelessWidget {
  const SearchTimeDesignInDataContainerInListDataFirstScreenNotifications(
      {super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      spacing: 10,
      children: [
        Flexible(
            child: ColumnTextWithSelectTimeInNotificationWidget(
                text: AppLanguageKeys.from)),
        Flexible(
            child: ColumnTextWithSelectTimeInNotificationWidget(
                text: AppLanguageKeys.to))
      ],
    );
  }
}
