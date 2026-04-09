import 'package:flutter/material.dart';
import '../../../../../core/language/language_constant.dart';
import '../../../../../core/theming/assets.dart';
import '../../../../../core/theming/colors.dart';
import '../../../../../core/theming/fonts.dart';
import '../../../../../core/pages_widgets/general_widgets/custom_container.dart';
import '../../../../../core/theming/text_styles.dart';

class DataAccountBalance extends StatelessWidget {
  const DataAccountBalance({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomContainer(
        padding: const EdgeInsets.all(0),
        isSelected: false,
        onTap: () {},
        borderRadius: BorderRadius.circular(10),
        typeWidget: ListTile(
          leading: Image.asset(AppImageKeys.maintenance, height: 34, width: 34),
          title: const TextInAppWidget(
            text: AppLanguageKeys.maintenanceAndRepairKey,
            textSize: 12,
            fontWeightIndex: FontSelectionData.regularFontFamily,
            textColor: AppColors.orangeColor,
          ),
          subtitle: const TextInAppWidget(
              text: AppLanguageKeys.revenueFromOrderKey,
              textSize: 14,
              fontWeightIndex: FontSelectionData.regularFontFamily,
              textColor: AppColors.darkColor),
          trailing: const TextInAppWidget(
              text: AppLanguageKeys.priceKey,
              textSize: 16,
              fontWeightIndex: FontSelectionData.regularFontFamily,
              textColor: AppColors.greenColor),
        ));
  }
}
