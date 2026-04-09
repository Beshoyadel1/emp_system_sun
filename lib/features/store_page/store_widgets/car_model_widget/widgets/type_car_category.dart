import 'package:flutter/material.dart';
import '../../../../../../../core/theming/assets.dart';
import '../../../../../../../core/theming/colors.dart';
import '../../../../../../../core/theming/fonts.dart';
import '../../../../../../../core/theming/text_styles.dart';
import '../../../../../../../core/language/language_constant.dart';

class TypeCarCategory extends StatelessWidget {
  const TypeCarCategory({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      spacing: 10,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const TextInAppWidget(
            text: AppLanguageKeys.carCategoryKey,
            textSize: 16,
            fontWeightIndex: FontSelectionData.regularFontFamily,
            textColor: AppColors.darkGreyColor),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          spacing: 10,
          children: [
            Container(
                decoration: BoxDecoration(
                  color: AppColors.whiteColor,
                  borderRadius: BorderRadius.circular(19),
                ),
                child: Center(
                    child: Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 23, vertical: 12),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset(
                        AppImageKeys.nesan,
                        width: 30,
                        height: 34,
                      ),
                      const TextInAppWidget(
                          text: AppLanguageKeys.nissanKey,
                          textSize: 12,
                          fontWeightIndex: FontSelectionData.regularFontFamily,
                          textColor: AppColors.darkGreyColor),
                    ],
                  ),
                ))),
            Container(
                decoration: BoxDecoration(
                  color: AppColors.whiteColor,
                  borderRadius: BorderRadius.circular(19),
                ),
                child: Center(
                    child: Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 10, vertical: 27),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset(
                        AppImageKeys.trueOrangeCircles,
                        width: 23,
                        height: 23,
                      ),
                      const TextInAppWidget(
                          text: AppLanguageKeys.allCategoriesKey,
                          textSize: 12,
                          fontWeightIndex: FontSelectionData.regularFontFamily,
                          textColor: AppColors.orangeColor),
                    ],
                  ),
                ))),
          ],
        ),
      ],
    );
  }
}
