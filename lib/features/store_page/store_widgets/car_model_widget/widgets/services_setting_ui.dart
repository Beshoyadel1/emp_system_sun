import 'package:flutter/material.dart';
import '../../../../../../../core/pages_widgets/general_widgets/custom_container.dart';
import '../../../../../../../core/theming/colors.dart';
import '../../../../../../../core/theming/text_styles.dart';
import '../../../../../../../core/theming/fonts.dart';
import '../../../../../../../core/language/language_constant.dart';
import '../../../../../../../core/theming/assets.dart';

class ServicesSettingUi extends StatelessWidget {
  const ServicesSettingUi({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomContainer(
        containerHeight: 89,
        containerWidth: 1000,
        boxShadow: [
          BoxShadow(
            color: AppColors.lightGreyColor.withAlpha(110),
            blurRadius: 21,
            spreadRadius: 2,
            offset: const Offset(0, 6),
          ),
        ],
        border: const Border(),
        isSelected: false,
        onTap: () {},
        borderRadius: BorderRadius.circular(11),
        typeWidget: Row(
          spacing: 10,
          children: [
            CustomContainer(
              isSelected: false,
              onTap: () {},
              padding: const EdgeInsets.symmetric(vertical: 11, horizontal: 13),
              borderRadius: BorderRadius.circular(19),
              typeWidget: Image.asset(
                AppImageKeys.nesan,
                height: 34,
                width: 30,
              ),
            ),
            const TextInAppWidget(
              text: AppLanguageKeys.nissanAllCategoriesKey,
              textSize: 16,
              fontWeightIndex: FontSelectionData.regularFontFamily,
            ),
            const Spacer(),
            CustomContainer(
              isSelected: false,
              onTap: () {},
              containerColor: AppColors.orangeColor,
              containerWidth: 162,
              containerHeight: 42,
              typeWidget: const Center(
                child: TextInAppWidget(
                  text: AppLanguageKeys.serviceSettingsKey,
                  textSize: 16,
                  textColor: AppColors.whiteColor,
                  fontWeightIndex: FontSelectionData.boldFontFamily,
                ),
              ),
            )
          ],
        ));
  }
}
