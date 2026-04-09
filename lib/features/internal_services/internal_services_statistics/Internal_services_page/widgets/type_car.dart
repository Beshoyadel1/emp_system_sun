import 'package:flutter/material.dart';
import '../../../../../core/theming/assets.dart';
import '../../../../../core/theming/colors.dart';
import '../../../../../core/theming/text_styles.dart';

class TypeCar extends StatelessWidget {
  const TypeCar({super.key});

  @override
  Widget build(BuildContext context) {
    return Wrap(
      children: [
        Column(
          children: [
            Image.asset(
              AppImageKeys.cr_v_car,
              width: 40,
              height: 20,
              fit: BoxFit.contain,
            ),
            const TextInAppWidget(
                text: 'Ariya', textSize: 14, textColor: AppColors.darkColor),
          ],
        ),
        const SizedBox(
          width: 10,
        ),
        const TextInAppWidget(
            text: 'Nissan', textSize: 14, textColor: AppColors.darkColor),
      ],
    );
  }
}
