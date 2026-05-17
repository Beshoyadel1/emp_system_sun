import 'package:flutter/cupertino.dart';
import '../../../../../core/theming/text_styles.dart';
import '../../../../../core/theming/fonts.dart';
import '../../../../../core/theming/colors.dart';

class ColumnImageCarWithTwoTextWidget extends StatelessWidget {
  final String imageSrc;
  final String kindCar;
  final String nameCar;
  final Color? kindCarColor,nameCarColor;
  final bool isSemiBold;
  final double? textSizeTitle,textSizeSubTitle;
  ColumnImageCarWithTwoTextWidget({
    required this.imageSrc,
    required this.kindCar,
    required this.nameCar,
    this.nameCarColor,
    this.kindCarColor,
    this.isSemiBold=false,
    this.textSizeSubTitle,
    this.textSizeTitle
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      spacing: 10,
      children: [
        Column(
          spacing: 5,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Image.asset(imageSrc, width: 50),
            TextInAppWidget(
              text:kindCar,
              textSize:textSizeTitle?? 12,
              fontWeightIndex:isSemiBold?FontSelectionData.semiBoldFontFamily: FontSelectionData.regularFontFamily,
              textColor:kindCarColor?? AppColors.blackColor,
            ),
          ],
        ),
        TextInAppWidget(
          text: nameCar,
          textSize:textSizeSubTitle?? 12,
          fontWeightIndex:isSemiBold?FontSelectionData.semiBoldFontFamily: FontSelectionData.regularFontFamily,
          textColor:nameCarColor??AppColors.blackColor,
        ),
      ],
    );
  }
}
