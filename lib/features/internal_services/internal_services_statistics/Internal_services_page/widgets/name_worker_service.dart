import 'package:flutter/material.dart';
import '../../../../../core/language/language_constant.dart';
import '../../../../../core/theming/assets.dart';
import '../../../../../core/theming/colors.dart';
import '../../../../../core/theming/text_styles.dart';

class NameWorkerService extends StatelessWidget {
  const NameWorkerService({super.key});

  @override
  Widget build(BuildContext context) {
    return Wrap(
      children: [
        Image.asset(
          AppImageKeys.profileImage,
          width: 41,
          height: 41,
          fit: BoxFit.contain,
        ),
        const Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextInAppWidget(
                text: AppLanguageKeys.jobNameKey,
                textSize: 12,
                textColor: AppColors.darkGreyColor),
            TextInAppWidget(
                text: AppLanguageKeys.employeeNameKey,
                textSize: 14,
                textColor: AppColors.darkColor),
          ],
        ),
      ],
    );
  }
}
