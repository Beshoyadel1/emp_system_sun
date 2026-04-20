import 'package:flutter/cupertino.dart';
import '../../../../../core/theming/text_styles.dart';
import '../../../../../core/theming/fonts.dart';
import '../../../../../core/theming/colors.dart';

class ImageWithOneText extends StatelessWidget {
  final String imageSrc;
  final String title;
  final Color? titleColor;
  final bool isSemiBold;
  final double? textSizeTitle;
  ImageWithOneText({
    required this.imageSrc,
    required this.title,
    this.titleColor,
    this.isSemiBold=false,
    this.textSizeTitle
  });

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 10,
      children: [
        Image.asset(imageSrc, width: 50),
        TextInAppWidget(
          text:title,
          textSize:textSizeTitle?? 12,
          fontWeightIndex:isSemiBold?FontSelectionData.semiBoldFontFamily: FontSelectionData.regularFontFamily,
          textColor:titleColor?? AppColors.darkColor,
        ),
      ],
    );
  }
}
