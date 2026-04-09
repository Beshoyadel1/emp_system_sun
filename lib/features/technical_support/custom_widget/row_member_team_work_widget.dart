import 'package:flutter/cupertino.dart';
import '../../../../../../../core/theming/assets.dart';
import '../../../../../../../core/theming/colors.dart';
import '../../../../../../../core/theming/fonts.dart';
import '../../../../../../../core/theming/text_styles.dart';

class RowMemberTeamWorkWidget extends StatelessWidget {
  final String? imagePath,userName,title;
  const RowMemberTeamWorkWidget({
    super.key,
    this.title,
    this.imagePath,
    this.userName,
  });
  @override
  Widget build(BuildContext context) {
    return Row(
      spacing: 10,
      children: [
        Flexible(child: Image.asset(imagePath?? AppImageKeys.support_message_emp1)),
        Flexible(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            spacing: 5,
            children: [
              TextInAppWidget(
                text:title??'المدير التنفيذي',
                textSize: 15,
                fontWeightIndex: FontSelectionData.regularFontFamily,
                textColor: AppColors.blackColor,
              ),
              TextInAppWidget(
                text:userName?? 'الاسم',
                textSize: 11,
                fontWeightIndex: FontSelectionData.regularFontFamily,
                textColor: AppColors.greyColor,
              ),
            ],
          ),
        )
      ],
    );
  }
}