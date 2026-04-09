import 'package:flutter/cupertino.dart';
import '../../../../../core/theming/colors.dart';
import '../../../../../core/theming/fonts.dart';
import '../../../../../core/theming/text_styles.dart';

class TextWithContainerAsColumnWidget extends StatelessWidget {
  final String title, textContainer;

  const TextWithContainerAsColumnWidget(
      {super.key, required this.title, required this.textContainer});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Column(
        spacing: 10,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          TextInAppWidget(
            text: title,
            textSize: 13,
            fontWeightIndex: FontSelectionData.regularFontFamily,
            textColor: AppColors.blackColor,
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
            decoration: BoxDecoration(
              color: AppColors.blackColor44,
              borderRadius: BorderRadius.all(Radius.circular(50)),
              border: Border.all(color: AppColors.greyColor.withOpacity(0.3)),
              boxShadow: [
                BoxShadow(
                  color: AppColors.darkColor.withOpacity(0.1),
                  blurRadius: 4,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
            child: Center(
              child: TextInAppWidget(
                text: textContainer,
                textSize: 11,
                fontWeightIndex: FontSelectionData.regularFontFamily,
                textColor: AppColors.whiteColor,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
