import 'dart:typed_data';
import 'package:emp_system_sun/core/theming/assets.dart';
import 'package:flutter/material.dart';
import '../../../../../../core/theming/colors.dart';
import '../../../../../../core/theming/fonts.dart';
import '../../../../../../core/theming/text_styles.dart';

class SelectModelCarTextImageOrangeLineWidget extends StatelessWidget {
  final String?  text;
  final bool? isSelected;
  final VoidCallback? onTap;
  final Uint8List? imageBytes;

  const SelectModelCarTextImageOrangeLineWidget({
    super.key,
     this.text,
     this.isSelected,
     this.onTap,
    this.imageBytes
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          border: Border.all(
            color: isSelected! ? AppColors.orangeColor : AppColors.transparent,
            width: isSelected! ? 1 : 0,
          ),
          borderRadius: BorderRadius.circular(10),
          color: AppColors.whiteColor,
        ),
        child: Column(
          spacing: 10,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            imageBytes != null
                ? Image.memory(
              imageBytes!,
              fit: BoxFit.contain,
            )
                : Image.asset(
              AppImageKeys.logo10, // fallback
              fit: BoxFit.contain,
            ),
            TextInAppWidget(
              text: text!,
              textSize: 12,
              fontWeightIndex: FontSelectionData.mediumFontFamily,
              textColor: AppColors.blackColor,
            ),
          ],
        ),
      ),
    );
  }
}
