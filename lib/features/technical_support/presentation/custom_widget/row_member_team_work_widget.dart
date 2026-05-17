import 'package:flutter/cupertino.dart';
import '../../../../../../../core/theming/assets.dart';
import '../../../../../../../core/theming/colors.dart';
import '../../../../../../../core/theming/fonts.dart';
import '../../../../../../../core/theming/text_styles.dart';

import 'dart:typed_data';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../../../../../../../core/theming/assets.dart';
import '../../../../../../../core/theming/colors.dart';
import '../../../../../../../core/theming/fonts.dart';
import '../../../../../../../core/theming/text_styles.dart';

class RowMemberTeamWorkWidget extends StatelessWidget {
  final Uint8List? imageBytes;
  final String? subTitle, title;
  final void Function()? onTap;
  const RowMemberTeamWorkWidget({
    super.key,
    this.title,
    this.imageBytes,
    this.subTitle,
    this.onTap
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Row(
        spacing: 10,
        children: [
          Flexible(
            child: _buildImage(),
          ),
          Flexible(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              spacing: 5,
              children: [
                TextInAppWidget(
                  text: title ?? 'المدير التنفيذي',
                  textSize: 15,
                  fontWeightIndex: FontSelectionData.regularFontFamily,
                  textColor: AppColors.blackColor,
                ),
                TextInAppWidget(
                  text: subTitle ?? 'الاسم',
                  textSize: 11,
                  fontWeightIndex: FontSelectionData.regularFontFamily,
                  textColor: AppColors.greyColor,
                ),
              ],
            ),
          )
        ],
      ),
    );
  }

  Widget _buildImage() {
    /// ✅ لو فيه bytes
    if (imageBytes != null && imageBytes!.isNotEmpty) {
      return Image.memory(
        imageBytes!,
        fit: BoxFit.cover,
        errorBuilder: (_, __, ___) {
          return Image.asset(AppImageKeys.support_message_emp1);
        },
      );
    }

    /// ❌ fallback
    return Image.asset(AppImageKeys.support_message_emp1);
  }
}