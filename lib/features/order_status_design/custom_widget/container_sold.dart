import 'package:flutter/material.dart';
import '../../../../../../../../core/language/language_constant.dart';
import '../../../../../../../../core/theming/colors.dart';
import '../../../../../../../../core/theming/fonts.dart';
import '../../../../../../../../core/theming/text_styles.dart';


class ContainerSold extends StatelessWidget {
  final String? text;
  final Color? backGroundColor;
  final void Function()? onTap;
  final double? horizontal,vertical;
  const ContainerSold({
    super.key,
    this.onTap,
    this.text,
    this.backGroundColor,
    this.horizontal,
    this.vertical
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap:onTap,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal:horizontal?? 15,vertical:vertical?? 10),
        decoration: BoxDecoration(
          color: backGroundColor??AppColors.orangeColor,
          borderRadius: BorderRadius.all(Radius.circular(20)),

        ),
        child: TextInAppWidget(
          text:text??AppLanguageKeys.carSold,
          textSize: 14,
          fontWeightIndex: FontSelectionData.regularFontFamily,
          textColor:AppColors.whiteColor,
        ),
      ),
    );
  }
}
