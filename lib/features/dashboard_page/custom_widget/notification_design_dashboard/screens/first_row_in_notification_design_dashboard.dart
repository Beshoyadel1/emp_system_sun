import 'package:flutter/cupertino.dart';
import '../../../../../../../core/language/language_constant.dart';
import '../../../../../../../core/theming/colors.dart';
import '../../../../../../../core/theming/fonts.dart';
import '../../../../../../../core/theming/text_styles.dart';

class FirstRowInNotificationDesignDashboard extends StatelessWidget {
  const FirstRowInNotificationDesignDashboard({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      spacing: 10,
      children: [
        Expanded(
          child: TextInAppWidget(
            text: AppLanguageKeys.notifications,
            textSize: 16,
            fontWeightIndex: FontSelectionData.mediumFontFamily,
            textColor: AppColors.orangeColor,
          ),
        ),
        Flexible(
          flex: 0,
          child: Container(
            padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
            decoration: BoxDecoration(
              color: AppColors.orangeColor,
              borderRadius: const BorderRadius.all(Radius.circular(25)),
            ),
            child: TextInAppWidget(
              text: AppLanguageKeys.allNotifications,
              textSize: 13,
              fontWeightIndex: FontSelectionData.regularFontFamily,
              textColor: AppColors.whiteColor,
            ),
          ),
        ),
      ],
    );
  }
}
