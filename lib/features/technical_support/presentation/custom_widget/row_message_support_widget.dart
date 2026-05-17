import 'dart:typed_data';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../../../../../../../core/theming/assets.dart';
import '../../../../../../../core/theming/colors.dart';
import '../../../../../../../core/theming/fonts.dart';
import '../../../../../../../core/theming/text_styles.dart';

class RowMessageSupportWidget extends StatelessWidget {
  final String? userName,message,time;
  final Uint8List? imageBytes;
  final void Function()? onTap;
  const RowMessageSupportWidget({
    super.key,
    this.time,
    this.message,
    this.imageBytes,
    this.userName,
    this.onTap
  });
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap:onTap,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Flexible(
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
                        text:userName??'الأدمن',
                        textSize: 15,
                        fontWeightIndex: FontSelectionData.regularFontFamily,
                        textColor: AppColors.blackColor,
                      ),
                      TextInAppWidget(
                        text:message?? 'تمام',
                        textSize: 11,
                        fontWeightIndex: FontSelectionData.regularFontFamily,
                        textColor: AppColors.greyColor,
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
          TextInAppWidget(
            text:time?? '12m',
            textSize: 15,
            fontWeightIndex: FontSelectionData.regularFontFamily,
            textColor: AppColors.greyColor,
          ),
        ],
      ),
    );
  }
  Widget _buildImage() {
    if (imageBytes != null && imageBytes!.isNotEmpty) {
      return Image.memory(
        imageBytes!,
        fit: BoxFit.cover,
        errorBuilder: (_, __, ___) {
          return Image.asset(AppImageKeys.support_message_emp1);
        },
      );
    }
    return Image.asset(AppImageKeys.support_message_emp1);
  }
}
