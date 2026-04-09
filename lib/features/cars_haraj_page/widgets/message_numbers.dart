import 'package:flutter/material.dart';
import '../../../../../core/theming/colors.dart';
import '../../../../../core/theming/text_styles.dart';

class MessageNumbers extends StatelessWidget {
  const MessageNumbers({super.key});

  @override
  Widget build(BuildContext context) {
    return const Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        TextInAppWidget(
            text: 'عدد الرسائل', textSize: 14, textColor: AppColors.darkColor),
        Wrap(
          spacing: 5,
          children: [
            CircleAvatar(
              radius: 10,
              backgroundColor: AppColors.orangeColor,
              child: TextInAppWidget(
                  text: '5', textSize: 14, textColor: AppColors.whiteColor),
            ),
            TextInAppWidget(
                text: 'رسائل', textSize: 14, textColor: AppColors.darkColor),
          ],
        ),
      ],
    );
  }
}
