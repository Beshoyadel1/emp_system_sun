import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../../../../../core/theming/fonts.dart';
import '../../../../../core/theming/text_styles.dart';
import '../../../../../core/theming/colors.dart';

class ContainerPackageWidget extends StatelessWidget {
  final String text;
  final double? width, height, textSize;

  const ContainerPackageWidget(
      {super.key, required this.text, this.width, this.height, this.textSize});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width ?? 80,
      height: height ?? 80,
      padding: EdgeInsetsGeometry.all(10),
      decoration:
          BoxDecoration(shape: BoxShape.circle, color: AppColors.blueColor),
      child: Center(
        child: TextInAppWidget(
          text: text,
          textSize: textSize ?? 14,
          fontWeightIndex: FontSelectionData.regularFontFamily,
          textColor: AppColors.whiteColor,
          maxLines: 2,
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}
