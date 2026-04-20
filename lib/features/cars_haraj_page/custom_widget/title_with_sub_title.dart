import 'package:flutter/material.dart';
import '../../../../../../../../core/language/language_constant.dart';
import '../../../../../../../../core/theming/colors.dart';
import '../../../../../../../../core/theming/fonts.dart';
import '../../../../../../../../core/theming/text_styles.dart';

class TitleWithSubTitle extends StatelessWidget {
  final String? title,subTitle,numberPercentage;
  final Color? titleColor,subTitleColor,iconDataColor;
  final double? textSizeTitle,textSizeSubTitle,spacing,iconDataSize;
  final IconData? iconData;
  final CrossAxisAlignment? crossAxisAlignment;
  const TitleWithSubTitle({
    this.title,
    this.subTitle,
    this.subTitleColor,
    this.titleColor,
    this.textSizeSubTitle,
    this.textSizeTitle,
    this.iconData,
    this.spacing,
    this.iconDataColor,
    this.iconDataSize,
    this.numberPercentage,
    this.crossAxisAlignment
  });
  @override
  Widget build(BuildContext context) {
    return Column(
      spacing: spacing??5,
      crossAxisAlignment: crossAxisAlignment??CrossAxisAlignment.center,
      children: [
        TextInAppWidget(
          text:title??AppLanguageKeys.employeesLogin,
          textSize: textSizeTitle??18,
          fontWeightIndex: FontSelectionData.regularFontFamily,
          textColor:titleColor??AppColors.blackColor,
        ),
        iconData != null?
           Row(
             spacing: 10,
             children: [
               Icon(iconData,color:iconDataColor,size:iconDataSize,),
               TextInAppWidget(
                 text:subTitle??AppLanguageKeys.enterPhoneAndPassword,
                 textSize: textSizeSubTitle??17,
                 fontWeightIndex: FontSelectionData.regularFontFamily,
                 textColor:subTitleColor??AppColors.blackColor,
               ),
             ],
           )
            :
        numberPercentage!=null?
           Row(
          spacing: 5,
          children: [
            Container(
              padding: EdgeInsetsGeometry.symmetric(horizontal: 8,vertical: 1),
              decoration: BoxDecoration(
                color: AppColors.orangeColor,
                borderRadius: BorderRadius.all(Radius.circular(20)),
              ),
              child:TextInAppWidget(
                text:numberPercentage!,
                textSize: 12,
                fontWeightIndex: FontSelectionData.regularFontFamily,
                textColor:AppColors.whiteColor,
              ),
            ),
            TextInAppWidget(
              text:subTitle??AppLanguageKeys.enterPhoneAndPassword,
              textSize: textSizeSubTitle??17,
              fontWeightIndex: FontSelectionData.regularFontFamily,
              textColor:subTitleColor??AppColors.blackColor,
            ),
          ],
        )
            :
        TextInAppWidget(
          text:subTitle??AppLanguageKeys.enterPhoneAndPassword,
          textSize: textSizeSubTitle??17,
          fontWeightIndex: FontSelectionData.regularFontFamily,
          textColor:subTitleColor??AppColors.blackColor,
        ),
      ],
    );
  }
}
