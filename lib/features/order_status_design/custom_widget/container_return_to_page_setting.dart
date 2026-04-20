import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../../../../../../core/language/language_constant.dart';
import '../../../../../../core/theming/fonts.dart';
import '../../../../../../core/theming/text_styles.dart';
import '../../../../../../core/theming/colors.dart';

class ContainerReturnToPageSetting extends StatelessWidget {
  final String? text;
  final Color? color;
  final IconData? icon;
  final void Function()? onTap;

  const ContainerReturnToPageSetting(
      {super.key, this.text, this.color, this.onTap, this.icon});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        width: 200,
        padding: EdgeInsetsGeometry.all(10),
        decoration: BoxDecoration(
          color: color ?? AppColors.blackColor44,
          borderRadius: BorderRadius.all(Radius.circular(20)),
          boxShadow: [
            BoxShadow(
              color: AppColors.darkColor.withOpacity(0.1),
              blurRadius: 4,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          spacing: 5,
          children: [
            Icon(
              icon ?? CupertinoIcons.back,
              color: AppColors.whiteColor,
              size: 15,
            ),
            TextInAppWidget(
              text: text ?? AppLanguageKeys.backToSettings,
              textSize: 12,
              fontWeightIndex: FontSelectionData.mediumFontFamily,
              textColor: AppColors.whiteColor,
            ),
          ],
        ),
      ),
    );
  }
}
