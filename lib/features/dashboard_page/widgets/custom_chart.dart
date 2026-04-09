import 'package:flutter/material.dart';
import '../../../../../core/language/language_constant.dart';
import '../../../../../core/theming/assets.dart';
import '../../../../../core/theming/colors.dart';
import '../../../../../core/theming/fonts.dart';
import '../../../../../core/pages_widgets/general_widgets/custom_container.dart';
import '../../../../../core/theming/text_styles.dart';

class CustomChart extends StatelessWidget {
  const CustomChart(
      {super.key, required this.image, required this.imageBackground});

  final String image;
  final Color imageBackground;

  @override
  Widget build(BuildContext context) {
    return CustomContainer(
      containerWidth: 280,
      containerHeight: 260,
      isSelected: false,
      onTap: () {},
      borderRadius: BorderRadius.circular(20),
      typeWidget: Column(
        spacing: 20,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            spacing: 12,
            children: [
              CircleAvatar(
                radius: 27,
                backgroundColor: imageBackground.withAlpha(50),
                child: Image.asset(
                  image,
                  height: 18,
                  width: 18,
                  color: imageBackground,
                ),
              ),
              const Column(
                spacing: 4,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  TextInAppWidget(
                    text: AppLanguageKeys.internalServiceKey,
                    textSize: 16,
                    fontWeightIndex: FontSelectionData.regularFontFamily,
                  ),
                  TextInAppWidget(
                    text: AppLanguageKeys.ordersCountKey,
                    textColor: AppColors.orangeColor,
                    textSize: 16,
                    fontWeightIndex: FontSelectionData.regularFontFamily,
                  ),
                ],
              ),
            ],
          ),
          // AspectRatio(
          //   aspectRatio: 2.2,
          //   child: LineChart(
          //       sampleData(
          //         colorGradient1: imageBackground,colorGradient2:imageBackground.withAlpha(80),colorGradient3:imageBackground.withAlpha(0)
          //     )
          //   ),
          // ),
          Row(
            spacing: 5,
            children: [
              TextInAppWidget(
                text: AppLanguageKeys.priceKey,
                textSize: 18,
                fontWeightIndex: FontSelectionData.regularFontFamily,
                textColor: imageBackground,
              ),
              const Spacer(),
              Image.asset(
                AppImageKeys.vector,
                height: 18,
                width: 18,
                color: imageBackground,
              ),
              const TextInAppWidget(
                text: AppLanguageKeys.increasePercentKey,
                textSize: 14,
                fontWeightIndex: FontSelectionData.regularFontFamily,
                textColor: AppColors.darkColor,
              ),
            ],
          )
        ],
      ),
    );
  }
}
