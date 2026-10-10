import 'package:flutter/material.dart';
import '../../../../../../core/language/language_constant.dart';
import '../../../../../../core/theming/colors.dart';
import '../../../../../../core/theming/fonts.dart';
import '../../../../../../core/pages_widgets/general_widgets/navigate_to_page_widget.dart';
import '../../../../../../core/theming/text_styles.dart';
import '../../sign_up_page/sign_up_page.dart';

class NewUserWidget extends StatelessWidget {
  const NewUserWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.push(
          context,
          NavigateToPageWidget(const SignUpPage()),
        );
      },
      child: const TextInAppWidget(
        text: AppLanguageKeys.newUserKey,
        textSize: 18,
        textColor: AppColors.seaBlueColor,
        fontWeightIndex: FontSelectionData.semiBoldFontFamily,
        decorationText: TextDecoration.underline,
        decorationTextColor: AppColors.seaBlueColor,
      ),
    );
  }
}
