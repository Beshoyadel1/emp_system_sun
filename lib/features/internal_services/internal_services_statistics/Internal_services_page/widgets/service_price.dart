import 'package:flutter/material.dart';
import '../../../../../core/language/language_constant.dart';
import '../../../../../core/theming/colors.dart';
import '../../../../../core/theming/text_styles.dart';

class ServicePrice extends StatelessWidget {
  const ServicePrice({super.key});

  @override
  Widget build(BuildContext context) {
    return const Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        TextInAppWidget(
            text: AppLanguageKeys.servicePriceKey,
            textSize: 12,
            textColor: AppColors.darkGreyColor),
        TextInAppWidget(
            text: '250.00', textSize: 14, textColor: AppColors.darkColor),
      ],
    );
  }
}
