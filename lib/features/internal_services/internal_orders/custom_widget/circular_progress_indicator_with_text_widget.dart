import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../../../../../core/theming/colors.dart';
import '../../../../../core/theming/fonts.dart';
import '../../../../../core/theming/text_styles.dart';

class CircularProgressIndicatorWithTextWidget extends StatelessWidget {
  final String text;
  final double? textSize;

  const CircularProgressIndicatorWithTextWidget(
      {super.key, required this.text, this.textSize});

  @override
  Widget build(BuildContext context) {
    return Column(
      spacing: 10,
      children: [
        CircularProgressIndicator(
          color: AppColors.orangeColor,
        ),
        TextInAppWidget(
          text: text,
          textSize: textSize ?? 12,
          textColor: AppColors.blackColor44,
          fontWeightIndex: FontSelectionData.mediumFontFamily,
        )
      ],
    );
  }
}
