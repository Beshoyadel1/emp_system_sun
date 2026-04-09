import 'package:flutter/material.dart';
import '../../../../../../../core/theming/colors.dart';
import '../../../../../../../core/theming/text_styles.dart';
import '../../../../../../../core/theming/fonts.dart';
import '../../../../../../../core/language/language_constant.dart';
import 'select_date_widget.dart';

class SelectModelYears extends StatelessWidget {
  const SelectModelYears({super.key});

  @override
  Widget build(BuildContext context) {
    return const Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        TextInAppWidget(
          text: AppLanguageKeys.selectModelYearsKey,
          textSize: 15.7,
          fontWeightIndex: FontSelectionData.regularFontFamily,
          textColor: AppColors.darkGreyColor,
        ),
        SizedBox(
          height: 12,
        ),
        SelectDateWidget()
      ],
    );
  }
}
