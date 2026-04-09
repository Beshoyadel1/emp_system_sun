import 'package:flutter/cupertino.dart';
import '../../../../../../../core/utilies/map_of_all_app.dart';
import '../../../../../../../core/theming/colors.dart';
import '../../../../../../../core/theming/fonts.dart';
import '../../../../../../../core/theming/text_styles.dart';

class RowKindOfCarWithTextWidget extends StatelessWidget {
  final String imagePath, textCar, title;

  const RowKindOfCarWithTextWidget({
    super.key,
    required this.imagePath,
    required this.title,
    required this.textCar,
  });

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    bool isMobile = size.width <= ValuesOfAllApp.mobileWidth;
    bool isTabletCustom =
        size.width > ValuesOfAllApp.mobileWidth && size.width <= 1330;
    return Row(
      mainAxisAlignment: isMobile?MainAxisAlignment.end:MainAxisAlignment.center,
      spacing: 5,
      children: [
        Column(
          spacing: 5,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Image.asset(
              imagePath,
            ),
            TextInAppWidget(
              text: textCar,
              textSize: 11,
              fontWeightIndex: FontSelectionData.mediumFontFamily,
              textColor: AppColors.blackColor,
            )
          ],
        ),
        Flexible(
          child: TextInAppWidget(
            text: title,
            textSize: 10,
            fontWeightIndex: FontSelectionData.mediumFontFamily,
            textColor: AppColors.blackColor,
          ),
        ),
      ],
    );
  }
}
