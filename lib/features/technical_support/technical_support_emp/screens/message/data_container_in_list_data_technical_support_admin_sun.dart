import 'package:flutter/cupertino.dart';
import '../../../../../../features/technical_support/technical_support_emp/screens/message/search_with_list_data_chat_admin_sun.dart';
import '../../../../../../features/technical_support/technical_support_emp/screens/message/title_message_with_number_admin_sun.dart';

class DataContainerInListDataTechnicalSupportAdminSun extends StatelessWidget {
  const DataContainerInListDataTechnicalSupportAdminSun({super.key});

  @override
  Widget build(BuildContext context) {
    return const Padding(
      padding:  EdgeInsets.all(15.0),
      child:  Column(
        spacing: 30,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          TitleMessageWithNumberAdminSun(),
          SearchWithListDataChatAdminSun()
        ],
      ),
    );
  }
}
