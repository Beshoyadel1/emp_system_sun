import 'package:flutter/material.dart';
import '../../../../../core/pages_widgets/general_widgets/navigate_to_page_widget.dart';
import '../../../../../core/theming/colors.dart';
import '../../../../../core/theming/fonts.dart';
import '../../../../../core/theming/text_styles.dart';

class RowTextIconOrange extends StatelessWidget {
  final String text, imagePath;
  final bool isMap;

  const RowTextIconOrange({
    super.key,
    required this.text,
    required this.imagePath,
    this.isMap = false,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      spacing: 5,
      children: isMap
          ? [
              Image.asset(
                imagePath,
                height: 23,
              ),
              InkWell(
                onTap: () {
                  // Navigator.of(context).push(
                  //   NavigateToPageWidget(
                  //       MapBackgroundInServiceRequest()
                  //   ),
                  // );
                },
                child: TextInAppWidget(
                  text: text,
                  textSize: 9,
                  fontWeightIndex: FontSelectionData.regularFontFamily,
                  textColor: AppColors.orangeColor,
                  decorationText: TextDecoration.underline,
                  decorationTextColor: AppColors.orangeColor,
                ),
              ),
            ]
          : [
              TextInAppWidget(
                text: text,
                textSize: 12,
                fontWeightIndex: FontSelectionData.mediumFontFamily,
                textColor: AppColors.darkColor,
              ),
              Image.asset(imagePath),
            ],
    );
  }
}
