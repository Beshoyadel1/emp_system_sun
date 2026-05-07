import 'package:flutter/cupertino.dart';
import '../../../../../core/theming/colors.dart';
import '../../../../../core/theming/fonts.dart';
import '../../../../../core/theming/text_styles.dart';
import '../../../../../core/theming/assets.dart';

class RowTextCorrect extends StatelessWidget {
  final String text;

  const RowTextCorrect({super.key, required this.text});

  @override
  Widget build(BuildContext context) {
    return Row(
      spacing: 5,
      children: [
        Image.asset(AppImageKeys.correct),
        TextInAppWidget(
          text: text,
          textSize: 10,
          fontWeightIndex: FontSelectionData.mediumFontFamily,
          textColor: AppColors.darkColor,
        ),
      ],
    );
  }
}
