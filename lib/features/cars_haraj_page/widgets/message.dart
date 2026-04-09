import 'package:flutter/material.dart';
import '../../../../../core/theming/assets.dart';
import '../../../../../core/theming/colors.dart';
import '../../../../../core/theming/fonts.dart';
import '../../../../../core/pages_widgets/general_widgets/custom_container.dart';
import '../../../../../core/theming/text_styles.dart';

class Message extends StatelessWidget {
  const Message({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomContainer(
      borderRadius: BorderRadius.circular(16),
      isSelected: false,
      onTap: () {},
      typeWidget: Wrap(
        spacing: 12,
        children: [
          CircleAvatar(
            radius: 16,
            backgroundColor: AppColors.veryLightOrangeColor.withAlpha(100),
            child: Image.asset(
              AppImageKeys.chatBubble,
              width: 13,
              height: 13,
              fit: BoxFit.contain,
            ),
          ),
          const Column(
            children: [
              TextInAppWidget(
                  text: 'كام السوم من فضلك',
                  textSize: 14,
                  textColor: AppColors.darkColor,
                  fontWeightIndex: FontSelectionData.mediumFontFamily),
              TextInAppWidget(
                  text: '2 يناير - 6:00 م',
                  textSize: 10,
                  textColor: AppColors.darkColor,
                  fontWeightIndex: FontSelectionData.mediumFontFamily),
            ],
          ),
          const SizedBox(
            width: 25,
          ),
          const CircleAvatar(
            radius: 10,
            backgroundColor: AppColors.orangeColor,
            child: TextInAppWidget(
                text: '5', textSize: 14, textColor: AppColors.whiteColor),
          ),
        ],
      ),
    );
  }
}
