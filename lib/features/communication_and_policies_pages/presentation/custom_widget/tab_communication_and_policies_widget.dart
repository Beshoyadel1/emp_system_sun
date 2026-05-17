import 'package:flutter/cupertino.dart';
import '../../../../../core/theming/colors.dart';
import '../../../../../core/theming/fonts.dart';
import '../../../../../core/theming/text_styles.dart';

class TabCommunicationAndPoliciesWidget extends StatelessWidget {
  final bool isSelected;
  final String text;

  const TabCommunicationAndPoliciesWidget(
      {required this.isSelected, required this.text});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 5, horizontal: 20),
      margin: EdgeInsets.all(5),
      decoration: BoxDecoration(
        color: isSelected ? AppColors.orangeColor : AppColors.greyColor,
        borderRadius: BorderRadius.circular(25),
      ),
      child: TextInAppWidget(
        text: text,
        textSize: 12,
        fontWeightIndex: FontSelectionData.regularFontFamily,
        textColor: AppColors.whiteColor,
        maxLines: 1,
      ),
    );
  }
}
