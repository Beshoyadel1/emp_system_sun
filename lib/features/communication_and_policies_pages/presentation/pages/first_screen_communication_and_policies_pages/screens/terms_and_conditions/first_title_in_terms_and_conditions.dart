import 'package:flutter/cupertino.dart';
import '../../../../../../../core/language/language_constant.dart';
import '../../../../../../../core/theming/colors.dart';
import '../../../../../../../core/theming/fonts.dart';
import '../../../../../../../core/theming/text_styles.dart';

class FirstTitleInTermsAndConditions extends StatelessWidget {
  const FirstTitleInTermsAndConditions({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      spacing: 20,
      children: [
        SizedBox(
          height: 20,
        ),
        TextInAppWidget(
          text: AppLanguageKeys.termsAndConditions,
          textSize: 18,
          fontWeightIndex: FontSelectionData.mediumFontFamily,
          textColor: AppColors.blackColor,
        ),
        TextInAppWidget(
          text: AppLanguageKeys.providersTermsAndConditions,
          textSize: 14,
          fontWeightIndex: FontSelectionData.regularFontFamily,
          textColor: AppColors.blackColor,
        ),
      ],
    );
  }
}
