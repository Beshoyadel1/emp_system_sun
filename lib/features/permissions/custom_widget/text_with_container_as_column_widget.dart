import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../../../../../core/theming/colors.dart';
import '../../../../../core/theming/fonts.dart';
import '../../../../../core/theming/text_styles.dart';

import 'dart:typed_data';
import 'package:flutter/material.dart';
import '../../../../../core/theming/colors.dart';
import '../../../../../core/theming/fonts.dart';
import '../../../../../core/theming/text_styles.dart';

class TextWithContainerAsColumnWidget extends StatelessWidget {
  final String title;
  final String textContainer;
  final VoidCallback? onTap;

  final String? fileName;
  final Uint8List? imageBytes;

  const TextWithContainerAsColumnWidget({
    super.key,
    required this.title,
    required this.textContainer,
    this.onTap,
    this.fileName,
    this.imageBytes,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      spacing: 10,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        TextInAppWidget(
          text: title,
          textSize: 13,
          fontWeightIndex: FontSelectionData.regularFontFamily,
          textColor: AppColors.blackColor,
        ),

        InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(50),
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 10),
            decoration: BoxDecoration(
              color: AppColors.blackColor44,
              borderRadius: const BorderRadius.all(Radius.circular(50)),
              border: Border.all(color: AppColors.greyColor.withOpacity(0.3)),
              boxShadow: [
                BoxShadow(
                  color: AppColors.darkColor.withOpacity(0.1),
                  blurRadius: 4,
                  offset: const Offset(0, 2),
                ),
              ],
            ),

            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextInAppWidget(
                  text: fileName ?? textContainer,
                  textSize: 11,
                  fontWeightIndex: FontSelectionData.regularFontFamily,
                  textColor: AppColors.whiteColor,
                ),

                if (imageBytes != null) ...[
                  const SizedBox(height: 8),
                  ClipRRect(
                    borderRadius: BorderRadius.circular(8),
                    child: Image.memory(
                      imageBytes!,
                      height: 30,
                      width: 50,
                      fit: BoxFit.cover,
                    ),
                  ),
                ]
              ],
            ),
          ),
        ),
      ],
    );
  }
}