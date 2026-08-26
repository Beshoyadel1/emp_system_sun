import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../../../../../../core/language/language_constant.dart';
import '../../../../../../core/theming/colors.dart';
import '../../../../../../core/theming/fonts.dart';
import '../../../../../../core/theming/text_styles.dart';
import '../../../../../../core/pages_widgets/general_widgets/custom_container.dart';

class DesignViewOtherServiceWidget extends StatelessWidget {
  final IconData? iconData;
  final Color? iconDataColor, iconDataBackGroundColor, subTitleColor;
  final String? title, subTitle;
  final bool isMoney;
  const DesignViewOtherServiceWidget(
      {super.key,
      this.iconData,
      this.iconDataColor,
      this.iconDataBackGroundColor,
      this.title,
      this.subTitle,
      this.subTitleColor,
      this.isMoney=false});

  @override
  Widget build(BuildContext context) {
    return CustomContainer(
      onTap: () {},
      isSelected: true,
      borderRadius: BorderRadius.circular(5),
      border: Border.all(color: AppColors.orangeColor.withOpacity(0.4)),
      typeWidget: Column(
        spacing: 10,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Wrap(
            spacing: 15,
            runSpacing: 10,
            crossAxisAlignment: WrapCrossAlignment.start,
            alignment: WrapAlignment.start,
            children: [
              CustomContainer(
                isSelected: false,
                onTap: () {},
                border: Border.all(color: AppColors.transparent),
                typeWidget: Icon(
                  iconData ?? Icons.design_services_sharp,
                  color: iconDataColor ?? AppColors.orangeColor,
                  size: 20,
                ),
                containerColor: iconDataBackGroundColor ??
                    AppColors.pinkColor.withOpacity(0.8),
                borderRadius: BorderRadius.circular(5),
              ),
              Column(
                spacing: 5,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                   TextInAppWidget(
                    text: title??AppLanguageKeys.serviceTypes,
                    textSize: 12,
                    fontWeightIndex: FontSelectionData.mediumFontFamily,
                    textColor: AppColors.greyColor,
                  ),
                   isMoney?
                   Wrap(
                     spacing: 5,
                     children: [
                       TextInAppWidget(
                         text:subTitle?? AppLanguageKeys.serviceTypes,
                         textSize: 12,
                         fontWeightIndex: FontSelectionData.boldFontFamily,
                         textColor:subTitleColor?? AppColors.greyColor,
                       ),
                       TextInAppWidget(
                         text: AppLanguageKeys.dirham,
                         textSize: 12,
                         fontWeightIndex:
                         FontSelectionData.boldFontFamily,
                         textColor:subTitleColor?? AppColors.greyColor,
                       ),
                     ],
                   ):
                   TextInAppWidget(
                    text:subTitle?? AppLanguageKeys.serviceTypes,
                    textSize: 12,
                    fontWeightIndex: FontSelectionData.boldFontFamily,
                    textColor:subTitleColor?? AppColors.greyColor,
                  ),
                ],
              )
            ],
          )
        ],
      ),
    );
  }
}
