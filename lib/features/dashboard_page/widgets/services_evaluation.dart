import 'package:flutter/material.dart';
import '../../../../../core/language/language_constant.dart';
import '../../../../../core/theming/assets.dart';
import '../../../../../core/theming/colors.dart';
import '../../../../../core/theming/fonts.dart';
import '../../../../../core/pages_widgets/general_widgets/custom_container.dart';
import '../../../../../core/theming/text_styles.dart';

class ServicesEvaluation extends StatelessWidget {
  const ServicesEvaluation({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomContainer(
      padding: const EdgeInsets.all(10),
      containerHeight: 100,
      borderRadius: BorderRadius.circular(20),
      isSelected: false,
      onTap: () {},
      typeWidget: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        spacing: 20,
        children: [
          const Column(
            spacing: 10,
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextInAppWidget(
                text: AppLanguageKeys.servicesRatingKey,
                textSize: 16,
                fontWeightIndex: FontSelectionData.regularFontFamily,
              ),
              Row(
                spacing: 5,
                children: [
                  Icon(
                    Icons.star,
                    color: AppColors.orangeColor,
                    size: 35,
                  ),
                  TextInAppWidget(
                    text: '5.0',
                    textSize: 16,
                    fontWeightIndex: FontSelectionData.regularFontFamily,
                  ),
                ],
              ),
            ],
          ),
          Image.asset(
            AppImageKeys.starsIcons,
            height: 98,
            width: 79,
            color: AppColors.orangeColor,
          ),
        ],
      ),
    );
  }
}
