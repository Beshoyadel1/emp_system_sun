import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../../../../../../../core/language/language_constant.dart';
import '../../../../../../../core/theming/colors.dart';
import '../../../../../../../core/theming/fonts.dart';
import '../../../../../../../core/theming/text_styles.dart';

class ColumnDateOrderWithTimeWidget extends StatelessWidget {
  final String time;
  final String? title;

  const ColumnDateOrderWithTimeWidget({super.key, required this.time,this.title});

  @override
  Widget build(BuildContext context) {
    return Column(
      spacing: 10,
      children: [
         TextInAppWidget(
          text: title??AppLanguageKeys.requestDate,
          textSize: 11,
          fontWeightIndex: FontSelectionData.mediumFontFamily,
          textColor: AppColors.greyColor,
        ),
        TextInAppWidget(
          text: time,
          textSize: 13,
          fontWeightIndex: FontSelectionData.regularFontFamily,
          textColor: AppColors.blackColor,
        ),
      ],
    );
  }
}
