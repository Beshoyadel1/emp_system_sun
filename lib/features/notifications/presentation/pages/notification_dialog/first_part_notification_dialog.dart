import 'package:flutter/material.dart';
import '../../../../../core/theming/colors.dart';
import '../../../../../core/theming/fonts.dart';
import '../../../../../core/theming/text_styles.dart';

class FirstPartNotificationDialog extends StatelessWidget {
  final String? title,subTitle;

  const FirstPartNotificationDialog({
    super.key,
    this.subTitle,
    this.title
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      spacing: 20,
      children: [
        const CircleAvatar(
          radius: 22,
          backgroundColor: AppColors.greyColor,
          child:  Icon(
            Icons.notifications,
            color: Colors.white,
          ),
        ),
        TextInAppWidget(
          text: title??"",
          textSize: 16,
          fontWeightIndex: FontSelectionData.semiBoldFontFamily,
          textColor: AppColors.blackColor,
        ),

        TextInAppWidget(
          text: subTitle??"",
          textSize: 13,
          textAlign: TextAlign.center,
          fontWeightIndex: FontSelectionData.regularFontFamily,
          textColor: AppColors.blackColor,
        ),
      ],
    );
  }
}