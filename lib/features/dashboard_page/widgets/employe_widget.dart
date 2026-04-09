import 'package:flutter/material.dart';
import '../../../../../core/language/language_constant.dart';
import '../../../../../core/theming/assets.dart';
import '../../../../../core/theming/colors.dart';
import '../../../../../core/theming/fonts.dart';
import '../../../../../core/pages_widgets/general_widgets/custom_container.dart';
import '../../../../../core/theming/text_styles.dart';

class EmployeWidget extends StatelessWidget {
  const EmployeWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomContainer(
        containerHeight: 64,
        padding: const EdgeInsets.all(0),
        borderRadius: BorderRadius.circular(10),
        isSelected: false,
        onTap: () {},
        typeWidget: ListTile(
          leading: CircleAvatar(
            radius: 20,
            backgroundColor: AppColors.veryLightOrangeColor.withAlpha(100),
            child:
                Image.asset(AppImageKeys.profileImage, height: 18, width: 18),
          ),
          title: const TextInAppWidget(
            text: AppLanguageKeys.jobTitleKey,
            textSize: 10,
            fontWeightIndex: FontSelectionData.regularFontFamily,
          ),
          subtitle: const TextInAppWidget(
            text: AppLanguageKeys.employeeNameKey,
            textSize: 12,
            fontWeightIndex: FontSelectionData.regularFontFamily,
          ),
          trailing: const TextInAppWidget(
            text: AppLanguageKeys.requestsCountKey,
            textSize: 12,
            fontWeightIndex: FontSelectionData.regularFontFamily,
          ),
        ));
  }
}
