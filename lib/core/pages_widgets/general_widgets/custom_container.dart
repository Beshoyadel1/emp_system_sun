import 'package:flutter/material.dart';
import '../../../core/theming/text_styles.dart';
import '../../../core/theming/colors.dart';
import '../../../core/theming/fonts.dart';

class CustomContainer extends StatelessWidget {
  final String? text;
  final bool isSelected;
  final VoidCallback onTap;
  final Widget? typeWidget;
  final BorderRadius? borderRadius;
  final BoxBorder? border;
  final double? containerHeight;
  final double? containerWidth;
  final Color? containerColor;
  final EdgeInsets? padding;
  final List<BoxShadow>? boxShadow;
  final Color? textColor;

  const CustomContainer({
    super.key,
    this.text,
    required this.isSelected,
    required this.onTap,
    this.typeWidget,
    this.borderRadius,
    this.border,
    this.containerHeight,
    this.containerWidth,
    this.containerColor,
    this.padding,
    this.boxShadow,
    this.textColor,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: containerHeight,
        width: containerWidth,
        padding:
            padding ?? const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
        decoration: BoxDecoration(
          color: containerColor ?? AppColors.whiteColor,
          border: border ??
              Border.all(
                color: isSelected
                    ? AppColors.orangeColor
                    : AppColors.lightGreyColor,
              ),
          borderRadius: borderRadius ?? BorderRadius.circular(24),
          boxShadow: boxShadow,
        ),
        child: typeWidget ??
            TextInAppWidget(
              text: text ?? "",
              textSize: 14,
              textAlign: TextAlign.center,
              fontWeightIndex: FontSelectionData.regularFontFamily,
              textColor: textColor ?? AppColors.whiteColor,
            ),
      ),
    );
  }
}
