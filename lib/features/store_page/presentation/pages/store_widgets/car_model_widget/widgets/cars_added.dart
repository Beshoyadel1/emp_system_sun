import 'package:flutter/material.dart';
import '../../../../../../../core/theming/text_styles.dart';
import '../../../../../../../core/pages_widgets/general_widgets/custom_container.dart';
import '../../../../../../../core/theming/assets.dart';
import '../../../../../../../core/theming/colors.dart';
import '../../../../../../../core/theming/fonts.dart';
import '../../../../../../../core/language/language_constant.dart';
import 'type_car_category.dart';

class CarsAdded extends StatelessWidget {
  const CarsAdded({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomContainer(
      containerWidth: 676,
      containerHeight: 283,
      isSelected: false,
      onTap: () {},
      containerColor: AppColors.whiteGreyColor,
      border: Border.all(color: AppColors.lightGreyColor),
      borderRadius: BorderRadius.circular(10),
      typeWidget: Column(
        spacing: 20,
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Row(
            spacing: 10,
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              const TextInAppWidget(
                  text: AppLanguageKeys.addedCarsKey,
                  textSize: 18,
                  fontWeightIndex: FontSelectionData.regularFontFamily),
              const Spacer(),
              CircleAvatar(
                radius: 16,
                backgroundColor: AppColors.darkGreyColor,
                child: Image.asset(
                  AppImageKeys.editIcon,
                  width: 20,
                  height: 20,
                ),
              ),
              CircleAvatar(
                radius: 16,
                backgroundColor: AppColors.redColor,
                child: Image.asset(
                  AppImageKeys.deleteIcon,
                  width: 20,
                  height: 20,
                ),
              ),
            ],
          ),
          const TypeCarCategory(),
          const TextInAppWidget(
            text: AppLanguageKeys.modelRangeKey,
            textSize: 14,
            fontWeightIndex: FontSelectionData.regularFontFamily,
          ),
        ],
      ),
    );
  }
}
