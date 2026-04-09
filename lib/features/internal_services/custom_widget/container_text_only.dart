import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../../../../../core/theming/colors.dart';
import '../../../../../core/theming/fonts.dart';
import '../../../../../core/theming/text_styles.dart';

class ContainerTextOnly extends StatelessWidget {
  final String text;
  final Color? colorBackGround, colorText;
  final double? width, height;
  final void Function()? onTap;

  const ContainerTextOnly(
      {super.key,
      required this.text,
      this.colorText,
      this.colorBackGround,
      this.width,
      this.height,
      this.onTap});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        width: width ?? 200,
        padding: EdgeInsetsGeometry.all(10),
        decoration: BoxDecoration(
          color: colorBackGround ?? AppColors.blackColor44,
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
            TextInAppWidget(
              text: text,
              textSize: 12,
              fontWeightIndex: FontSelectionData.mediumFontFamily,
              textColor: colorText ?? AppColors.whiteColor,
            ),
          ],
        ),
      ),
    );
  }
}
