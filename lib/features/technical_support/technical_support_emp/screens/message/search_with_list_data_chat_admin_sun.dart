import 'package:flutter/cupertino.dart';
import '../../../../../../features/technical_support/custom_widget/row_message_support_widget.dart';
import '../../../../../../../core/theming/assets.dart';
import '../../../../../../../core/language/language_constant.dart';
import '../../../../../../../core/pages_widgets/text_form_field_widget.dart';
import '../../../../../../../core/theming/colors.dart';

class SearchWithListDataChatAdminSun extends StatefulWidget {
  const SearchWithListDataChatAdminSun({super.key});

  @override
  State<SearchWithListDataChatAdminSun> createState() =>
      _SearchWithListDataChatAdminSunState();
}

class _SearchWithListDataChatAdminSunState
    extends State<SearchWithListDataChatAdminSun> {
  final TextEditingController textFormController = TextEditingController();

  @override
  void dispose() {
    textFormController.dispose();
    super.dispose();
  }

  final List<Map<String, String>> data = const [
    {
      "image": AppImageKeys.support_message_emp1,
      "name": "الأدمن",
      "message": "تمام",
      "time": "12m"
    },
    {
      "image": AppImageKeys.support_message_emp2,
      "name": "المحاسب",
      "message": "شكرا أخي",
      "time": "12m"
    },
    {
      "image": AppImageKeys.support_message_emp3,
      "name": "الأدمن",
      "message": "رقم الطلب #444 فيه مشكلة",
      "time": "12m"
    },
    {
      "image": AppImageKeys.support_message_emp4,
      "name": "المحاسب",
      "message": "شكرا أخي",
      "time": "12m"
    },
    {
      "image": AppImageKeys.support_message_emp4,
      "name": "الأدمن",
      "message": "رقم الطلب #444 فيه مشكلة",
      "time": "12m"
    },
    {
      "image": AppImageKeys.support_message_emp4,
      "name": "المحاسب",
      "message": "شكرا أخي",
      "time": "12m"
    },
    {
      "image": AppImageKeys.support_message_emp4,
      "name": "الأدمن",
      "message": "رقم الطلب #444 فيه مشكلة",
      "time": "12m"
    },
  ];

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 400,
      child: Column(
        children: [
          TextFormFieldWidget(
            textFormController: textFormController,
            fillColor: AppColors.greyColorSearch,
            hintText: AppLanguageKeys.searchInMessages,
            hintTextSize: 11,
            hintTextColor: AppColors.darkColor.withOpacity(0.4),
            textSize: 12,
            contentPadding: const EdgeInsets.all(5),
            focusedBorderRadius: BorderRadius.circular(5),
            enabledBorderRadius: BorderRadius.circular(5),
          ),

          const SizedBox(height: 20),

          Expanded(
            child: ListView.separated(
              padding: EdgeInsets.zero,
              itemCount: data.length,
              separatorBuilder: (_, __) => const SizedBox(height: 10),
              itemBuilder: (context, index) {
                final item = data[index];

                return RowMessageSupportWidget(
                  imagePath: item["image"]!,
                  userName: item["name"]!,
                  message: item["message"]!,
                  time: item["time"]!,
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
