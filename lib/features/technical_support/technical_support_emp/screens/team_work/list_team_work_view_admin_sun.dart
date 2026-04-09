import 'package:flutter/cupertino.dart';
import '../../../../../../features/technical_support/custom_widget/row_member_team_work_widget.dart';
import '../../../../../../../core/theming/assets.dart';

class ListTeamWorkViewAdminSun extends StatelessWidget {
  const ListTeamWorkViewAdminSun({super.key});

  final List<Map<String, String>> data = const [
    {
      "image": AppImageKeys.support_message_emp1,
      "title": "المدير التنفيذي",
      "name": "الاسم",
    },
    {
      "image": AppImageKeys.support_message_emp2,
      "title": "الأدمن",
      "name": "الاسم",
    },
    {
      "image": AppImageKeys.support_message_emp3,
      "title": "المحاسب",
      "name": "الاسم",
    },
    {
      "image": AppImageKeys.support_message_emp4,
      "title": "كاشير1",
      "name": "الاسم",
    },
    {
      "image": AppImageKeys.support_message_emp3,
      "title": "المحاسب",
      "name": "الاسم",
    },
    {
      "image": AppImageKeys.support_message_emp4,
      "title": "كاشير1",
      "name": "الاسم",
    },
  ];

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 300,
      child: ListView.separated(
        padding: EdgeInsets.zero,
        itemCount: data.length,
        separatorBuilder: (_, __) => const SizedBox(height: 20),
        itemBuilder: (context, index) {
          final item = data[index];

          return RowMemberTeamWorkWidget(
            imagePath: item["image"]!,
            title: item["title"]!,
            userName: item["name"]!,
          );
        },
      ),
    );
  }
}