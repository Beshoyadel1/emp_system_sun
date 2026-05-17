import 'package:flutter/cupertino.dart';
import '../../../../../core/theming/text_styles.dart';
import '../../../../../core/theming/fonts.dart';
import '../../../../../core/theming/colors.dart';

class ImageWithTwoText extends StatelessWidget {
  final String imageSrc;
  final String title;
  final String subTitle;
  final Color? titleColor, subTitleColor;
  final bool isSemiBold;
  final bool? isLeftToRight;
  final double? textSizeTitle, textSizeSubTitle, widthImage;

  const ImageWithTwoText({
    super.key,
    required this.imageSrc,
    required this.title,
    required this.subTitle,
    this.subTitleColor,
    this.titleColor,
    this.isSemiBold = false,
    this.isLeftToRight = false,
    this.textSizeSubTitle,
    this.textSizeTitle,
    this.widthImage,
  });

  @override
  Widget build(BuildContext context) {
    return isLeftToRight!
        ? Wrap(
            spacing: 10,
            crossAxisAlignment: WrapCrossAlignment.center,
            alignment: WrapAlignment.center,
            children: [
              Column(
                spacing: 5,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  TextInAppWidget(
                    text: title,
                    textSize: textSizeTitle ?? 12,
                    fontWeightIndex: isSemiBold
                        ? FontSelectionData.semiBoldFontFamily
                        : FontSelectionData.regularFontFamily,
                    textColor: titleColor ?? AppColors.darkColor,
                  ),
                  TextInAppWidget(
                    text: subTitle,
                    textSize: textSizeSubTitle ?? 12,
                    fontWeightIndex: isSemiBold
                        ? FontSelectionData.semiBoldFontFamily
                        : FontSelectionData.regularFontFamily,
                    textColor: subTitleColor ?? AppColors.orangeColor,
                  ),
                ],
              ),
              Image.asset(imageSrc, width: widthImage ?? 50),
            ],
          )
        : Wrap(
            spacing: 10,
            crossAxisAlignment: WrapCrossAlignment.center,
            alignment: WrapAlignment.center,
            children: [
              Image.asset(imageSrc, width: widthImage ?? 50),
              Column(
                spacing: 5,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  TextInAppWidget(
                    text: title,
                    textSize: textSizeTitle ?? 12,
                    fontWeightIndex: isSemiBold
                        ? FontSelectionData.semiBoldFontFamily
                        : FontSelectionData.regularFontFamily,
                    textColor: titleColor ?? AppColors.darkColor,
                  ),
                  TextInAppWidget(
                    text: subTitle,
                    textSize: textSizeSubTitle ?? 12,
                    fontWeightIndex: isSemiBold
                        ? FontSelectionData.semiBoldFontFamily
                        : FontSelectionData.regularFontFamily,
                    textColor: subTitleColor ?? AppColors.orangeColor,
                  ),
                ],
              ),
            ],
          );
  }
}
