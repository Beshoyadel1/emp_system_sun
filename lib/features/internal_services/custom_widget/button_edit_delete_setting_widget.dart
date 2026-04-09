import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../../../../../../../core/language/language_constant.dart';
import '../../../../../core/theming/fonts.dart';
import '../../../../../core/theming/text_styles.dart';
import '../../../../../core/theming/colors.dart';

class ButtonEditDeleteSettingWidget extends StatelessWidget {
  final void Function()? onTap;
  final bool isDelete;

  const ButtonEditDeleteSettingWidget(
      {super.key, this.onTap, this.isDelete = false});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        padding: EdgeInsetsGeometry.symmetric(vertical: 5, horizontal: 60),
        decoration: BoxDecoration(
          color: isDelete ? AppColors.redColor : AppColors.blackColor44,
          borderRadius: BorderRadius.all(Radius.circular(20)),
          border: Border.all(color: AppColors.greyColor.withOpacity(0.3)),
        ),
        child: Row(
          spacing: 5,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              isDelete ? CupertinoIcons.delete : Icons.edit,
              color: AppColors.whiteColor,
              size: 15,
            ),
            TextInAppWidget(
              text: isDelete ? AppLanguageKeys.delete : AppLanguageKeys.edit,
              textSize: 16,
              fontWeightIndex: FontSelectionData.regularFontFamily,
              textColor: AppColors.whiteColor,
            ),
          ],
        ),
      ),
    );
  }
}
