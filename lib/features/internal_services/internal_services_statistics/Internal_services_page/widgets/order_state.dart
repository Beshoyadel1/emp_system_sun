import 'package:flutter/material.dart';
import '../../../../../core/language/language_constant.dart';
import '../../../../../core/theming/colors.dart';
import '../../../../../core/pages_widgets/general_widgets/custom_container.dart';
import '../../../../../core/theming/text_styles.dart';

class OrderState extends StatelessWidget {
  const OrderState({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const TextInAppWidget(
            text: AppLanguageKeys.orderStatusKey,
            textSize: 12,
            textColor: AppColors.darkGreyColor),
        CustomContainer(
          containerHeight: 28,
          containerWidth: 105,
          containerColor: AppColors.orangeColor.withAlpha(50),
          isSelected: false,
          onTap: () {},
          border: const Border(),
          padding: EdgeInsets.zero,
          typeWidget: const Center(
            child: Row(
              spacing: 2,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.settings, color: AppColors.orangeColor, size: 14),
                TextInAppWidget(
                    text: AppLanguageKeys.underServiceKey,
                    textSize: 12,
                    textColor: AppColors.orangeColor),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
