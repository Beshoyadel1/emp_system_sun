import 'package:flutter/material.dart';
import '../../../../../core/language/language_constant.dart';
import '../../../../../core/theming/assets.dart';
import '../../../../../core/theming/colors.dart';
import '../../../../../core/pages_widgets/general_widgets/custom_container.dart';
import '../../../../../core/theming/text_styles.dart';

class InternalServices extends StatelessWidget {
  const InternalServices({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomContainer(
      containerHeight: 110,
      containerWidth: 280,
      isSelected: false,
      onTap: () {},
      typeWidget: Center(
        child: Row(
          spacing: 10,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: ColoredBox(
                color: AppColors.orangeColor.withAlpha(50),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Image.asset(
                    AppImageKeys.maintenance,
                    width: 40,
                    height: 40,
                    fit: BoxFit.contain,
                  ),
                ),
              ),
            ),
            const Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                TextInAppWidget(
                    text: AppLanguageKeys.washingAndCleaningKey,
                    textSize: 16,
                    textColor: AppColors.darkColor),
                TextInAppWidget(
                    text: AppLanguageKeys.ordersCountKey,
                    textSize: 16,
                    textColor: AppColors.orangeColor)
              ],
            )
          ],
        ),
      ),
    );
  }
}
