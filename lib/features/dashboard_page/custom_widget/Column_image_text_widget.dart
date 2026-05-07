import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../../../../../core/language/language_constant.dart';
import '../../../../../core/theming/assets.dart';
import '../../../../../core/theming/colors.dart';
import '../../../../../core/theming/fonts.dart';
import '../../../../../core/theming/text_styles.dart';

class ColumnImageTextWidget extends StatelessWidget {
  final String imagePath, text;

  const ColumnImageTextWidget(
      {super.key, required this.imagePath, required this.text});

  @override
  Widget build(BuildContext context) {
    return Column(
      spacing: 5,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Image.asset(imagePath),
        TextInAppWidget(
          text: text,
          textSize: 10,
          fontWeightIndex: FontSelectionData.mediumFontFamily,
          textColor: AppColors.blackColor44,
        ),
      ],
    );
  }
}
