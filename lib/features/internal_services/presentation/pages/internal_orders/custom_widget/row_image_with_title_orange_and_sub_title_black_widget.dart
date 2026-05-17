import 'package:flutter/cupertino.dart';
import '../../../../../../../core/theming/colors.dart';
import '../../../../../../../core/theming/fonts.dart';
import '../../../../../../../core/theming/text_styles.dart';

class RowImageWithTitleOrangeAndSubTitleBlackWidget extends StatelessWidget {
  final String imagePath, title, subTitle;
  final double? textSizeTitle;
  final bool? isJob;

  const RowImageWithTitleOrangeAndSubTitleBlackWidget({
    super.key,
    required this.imagePath,
    required this.title,
    required this.subTitle,
    this.isJob = false,
    this.textSizeTitle
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      spacing: 5,
      children: [
        Image.asset(
          imagePath,
          width: 30,
        ),
        Flexible(
          child: Column(
            spacing: 5,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextInAppWidget(
                text: title,
                textSize: textSizeTitle??9,
                fontWeightIndex: FontSelectionData.regularFontFamily,
                textColor: isJob! ? AppColors.greyColor : AppColors.orangeColor,
              ),
              TextInAppWidget(
                text: subTitle,
                textSize: 9,
                fontWeightIndex: FontSelectionData.mediumFontFamily,
                textColor: AppColors.darkColor,
              ),
            ],
          ),
        )
      ],
    );
  }
}
