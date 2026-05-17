import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../../../../../../core/language/language_constant.dart';
import '../../../../../../core/pages_widgets/button_widget.dart';
import '../../../../../../core/theming/colors.dart';
import '../../../../../../core/theming/fonts.dart';

class LastTwoButtonInLogoutDashboard extends StatelessWidget {
  final void Function()? onTapConfirm, onTapCancel;

  const LastTwoButtonInLogoutDashboard({
    super.key,
    this.onTapConfirm,
    this.onTapCancel,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        ButtonWidget(
          text: AppLanguageKeys.confirm,
          textColor: AppColors.whiteColor,
          buttonColor: AppColors.redColor,
          textSize: 12,
          fontWeightIndex: FontSelectionData.regularFontFamily,
          heightContainer: 40,
          widthContainer: 120,
          borderRadius: 30,
          onTap: onTapConfirm,
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
          onTap: onTapCancel,
        )
      ],
    );
  }
}
