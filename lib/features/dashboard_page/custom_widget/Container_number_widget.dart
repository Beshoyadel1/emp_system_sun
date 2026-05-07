import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../../../../../core/theming/fonts.dart';
import '../../../../../core/theming/text_styles.dart';
import '../../../../../core/theming/colors.dart';

class ContainerNumberWidget extends StatelessWidget {
  final String textNumber;
  final double? textSize, horizontal, vertical;
  final Color? textColor, backGroundColor;

  const ContainerNumberWidget(
      {super.key,
      required this.textNumber,
      this.textSize,
      this.horizontal,
      this.textColor,
      this.vertical,
      this.backGroundColor});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsetsGeometry.symmetric(
          horizontal: horizontal ?? 10, vertical: vertical ?? 10),
      decoration: BoxDecoration(
        color: backGroundColor ?? AppColors.blackColor44,
        shape: BoxShape.circle,
      ),
      child: TextInAppWidget(
        text: textNumber,
        textSize: textSize ?? 15,
        fontWeightIndex: FontSelectionData.regularFontFamily,
        textColor: textColor ?? AppColors.whiteColor,
      ),
    );
  }
}
