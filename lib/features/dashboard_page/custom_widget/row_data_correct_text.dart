import 'package:flutter/cupertino.dart';
import '../../../../../core/theming/colors.dart';
import '../../../../../core/theming/fonts.dart';
import '../../../../../core/theming/text_styles.dart';
import '../../../../../core/theming/assets.dart';

class RowDataCorrectText extends StatelessWidget {
  final String text;

  const RowDataCorrectText({super.key, required this.text});

  @override
  Widget build(BuildContext context) {
    return Row(
      spacing: 5,
      children: [
        Image.asset(AppImageKeys.correct),
        Expanded(
          child: TextInAppWidget(
            text: text,
            textSize: 10,
            fontWeightIndex: FontSelectionData.mediumFontFamily,
            textColor: AppColors.darkColor,
          ),
        ),
      ],
    );
  }
}
