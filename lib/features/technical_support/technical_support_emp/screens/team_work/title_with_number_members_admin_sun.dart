import 'package:flutter/cupertino.dart';
import '../../../../../../../core/theming/colors.dart';
import '../../../../../../../core/theming/fonts.dart';
import '../../../../../../../core/theming/text_styles.dart';
import '../../../../../../../core/language/language_constant.dart';

class TitleWithNumberMembersAdminSun extends StatelessWidget {
  const TitleWithNumberMembersAdminSun({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      spacing: 20,
      children: [
        const TextInAppWidget(
          text: AppLanguageKeys.teamMembers,
          textSize: 18,
          fontWeightIndex: FontSelectionData.regularFontFamily,
          textColor: AppColors.blackColor,
        ),
        Row(
          spacing: 20,
          children: [
            const Flexible(
              child: TextInAppWidget(
                text: AppLanguageKeys.membersCount,
                textSize: 15,
                fontWeightIndex: FontSelectionData.regularFontFamily,
                textColor: AppColors.blackColor,
              ),
            ),
            Container(
              padding: const EdgeInsetsGeometry.symmetric(horizontal: 10,vertical: 5),
              decoration: const BoxDecoration(
                color: AppColors.greyColor200,
                borderRadius: BorderRadius.all(Radius.circular(20)),
              ),
              child:const TextInAppWidget(
                text:'6',
                textSize: 12,
                fontWeightIndex: FontSelectionData.regularFontFamily,
                textColor: AppColors.blackColor,
              ),
            )
          ],
        )
      ],
    );
  }
}
