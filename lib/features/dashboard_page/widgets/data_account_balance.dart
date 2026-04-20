import 'package:flutter/material.dart';
import '../../../../../core/language/language_constant.dart';
import '../../../../../core/theming/assets.dart';
import '../../../../../core/theming/colors.dart';
import '../../../../../core/theming/fonts.dart';
import '../../../../../core/pages_widgets/general_widgets/custom_container.dart';
import '../../../../../core/theming/text_styles.dart';

import 'package:flutter/material.dart';
import '../../../../../core/language/language_constant.dart';
import '../../../../../core/theming/assets.dart';
import '../../../../../core/theming/colors.dart';
import '../../../../../core/theming/fonts.dart';
import '../../../../../core/pages_widgets/general_widgets/custom_container.dart';
import '../../../../../core/theming/text_styles.dart';

import '../../../../core/api_functions/statistics/get_provider_total_rate_and_employee_and_balance_model/get_provider_total_rate_and_employee_and_balance_model.dart';

class DataAccountBalance extends StatelessWidget {
  final AccountBalance item;

  const DataAccountBalance({super.key, required this.item});

  @override
  Widget build(BuildContext context) {
    return CustomContainer(
      padding: const EdgeInsets.all(0),
      isSelected: false,
      onTap: () {},
      borderRadius: BorderRadius.circular(10),
      typeWidget: ListTile(
        leading: Image.asset(
          AppImageKeys.maintenance,
          height: 34,
          width: 34,
        ),

        title: TextInAppWidget(
          text: item.getName(context),
          textSize: 12,
          fontWeightIndex: FontSelectionData.regularFontFamily,
          textColor: AppColors.orangeColor,
        ),

        subtitle: Row(
          children: [
            const TextInAppWidget(
              text: AppLanguageKeys.identity,
              textSize: 12,
              fontWeightIndex: FontSelectionData.regularFontFamily,
              textColor: AppColors.darkColor,
            ),
             TextInAppWidget(
              text: " : ${item.recentOrderId ?? 0}",
              textSize: 12,
              fontWeightIndex: FontSelectionData.regularFontFamily,
              textColor: AppColors.darkColor,
            ),
          ],
        ),

        /// 💰 السعر
        trailing: TextInAppWidget(
          text: "${item.amount ?? 0}",
          textSize: 16,
          fontWeightIndex: FontSelectionData.regularFontFamily,
          textColor: AppColors.greenColor,
        ),
      ),
    );
  }
}
