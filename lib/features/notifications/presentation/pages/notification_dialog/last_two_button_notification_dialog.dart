import 'package:flutter/material.dart';
import '../../../../../core/language/language_constant.dart';
import '../../../../../core/pages_widgets/button_widget.dart';
import '../../../../../core/theming/colors.dart';
import '../../../../../core/theming/fonts.dart';

class LastTwoButtonNotificationDialog extends StatelessWidget {
  final VoidCallback? onTapView;
  final VoidCallback? onTapClose;

  const LastTwoButtonNotificationDialog({
    super.key,
    this.onTapView,
    this.onTapClose,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        ButtonWidget(
          text: AppLanguageKeys.viewAll,
          textColor: AppColors.whiteColor,
          buttonColor: AppColors.redColor,
          textSize: 12,
          fontWeightIndex: FontSelectionData.regularFontFamily,
          heightContainer: 40,
          widthContainer: 120,
          borderRadius: 30,
          onTap: onTapView,
        ),
        ButtonWidget(
          text: AppLanguageKeys.cancel,
          textColor: AppColors.whiteColor,
          buttonColor: AppColors.blackColor44,
          textSize: 12,
          fontWeightIndex: FontSelectionData.regularFontFamily,
          heightContainer: 40,
          widthContainer: 120,
          borderRadius: 30,
          onTap: onTapClose,
        ),
      ],
    );
  }
}