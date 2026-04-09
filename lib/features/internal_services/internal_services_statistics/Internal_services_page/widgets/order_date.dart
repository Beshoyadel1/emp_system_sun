import 'package:flutter/material.dart';
import '../../../../../core/language/language_constant.dart';
import '../../../../../core/theming/colors.dart';
import '../../../../../core/theming/text_styles.dart';

class OrderDate extends StatelessWidget {
  const OrderDate({super.key, this.text, this.date});

  final String? text, date;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        TextInAppWidget(
            text: text ?? AppLanguageKeys.orderDateKey,
            textSize: 12,
            textColor: AppColors.darkGreyColor),
        TextInAppWidget(
            text: date ?? '1/1/2025',
            textSize: 14,
            textColor: AppColors.darkColor),
      ],
    );
  }
}
