import 'package:flutter/material.dart';
import '../../../../../../core/language/language_constant.dart';
import '../../../../../../core/theming/assets.dart';
import '../../../../../../core/theming/colors.dart';
import '../../../../../../core/theming/fonts.dart';
import '../../../../../../core/theming/text_styles.dart';

class LoginImage extends StatelessWidget {
  const LoginImage({super.key});

  @override
  Widget build(BuildContext context) {
    return Expanded(
        child: Stack(
      alignment: Alignment.center,
      children: [
        ColorFiltered(
          colorFilter: ColorFilter.mode(
            AppColors.darkColor.withAlpha(190),
            BlendMode.darken,
          ),
          child: Image.asset(
            AppImageKeys.loginImage,
            height: double.infinity,
            width: double.infinity,
            fit: BoxFit.fill,
          ),
        ),
        Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Image.asset(AppImageKeys.sarWhiteLogo,
                height: 60, width: 60, fit: BoxFit.fill),
            const SizedBox(height: 8),
            const TextInAppWidget(
              text: AppLanguageKeys.introTextKey,
              textColor: AppColors.whiteColor,
              textSize: 22,
              fontWeightIndex: FontSelectionData.boldFontFamily,
              textAlign: TextAlign.center,
            )
          ],
        ),
      ],
    ));
  }
}
