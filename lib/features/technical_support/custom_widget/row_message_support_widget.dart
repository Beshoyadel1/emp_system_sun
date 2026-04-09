import 'package:flutter/cupertino.dart';
import '../../../../../../../core/theming/assets.dart';
import '../../../../../../../core/theming/colors.dart';
import '../../../../../../../core/theming/fonts.dart';
import '../../../../../../../core/theming/text_styles.dart';

class RowMessageSupportWidget extends StatelessWidget {
  final String? imagePath,userName,message,time;
  const RowMessageSupportWidget({
    super.key,
    this.time,
    this.message,
    this.imagePath,
    this.userName,
  });
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Flexible(
          child: Row(
            spacing: 10,
            children: [
              Flexible(child: Image.asset(imagePath?? AppImageKeys.support_message_emp1)),
              Flexible(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  spacing: 5,
                  children: [
                    TextInAppWidget(
                      text:userName??'الأدمن',
                      textSize: 15,
                      fontWeightIndex: FontSelectionData.regularFontFamily,
                      textColor: AppColors.blackColor,
                    ),
                    TextInAppWidget(
                      text:message?? 'تمام',
                      textSize: 11,
                      fontWeightIndex: FontSelectionData.regularFontFamily,
                      textColor: AppColors.greyColor,
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
        TextInAppWidget(
          text:time?? '12m',
          textSize: 15,
          fontWeightIndex: FontSelectionData.regularFontFamily,
          textColor: AppColors.greyColor,
        ),
      ],
    );
  }
}