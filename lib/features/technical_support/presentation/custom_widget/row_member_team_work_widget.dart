import 'package:flutter/cupertino.dart';
import '../../../../../../../core/theming/assets.dart';
import '../../../../../../../core/theming/colors.dart';
import '../../../../../../../core/theming/fonts.dart';
import '../../../../../../../core/theming/text_styles.dart';
import 'dart:typed_data';
import 'package:flutter/material.dart';


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
    return ClipOval(
      child: SizedBox(
        width: 50,
        height: 50,
        child: imageBytes != null && imageBytes!.isNotEmpty
            ? Image.memory(
          imageBytes!,
          fit: BoxFit.cover,
          width: 50,
          height: 50,
          errorBuilder: (_, __, ___) {
            return Image.asset(
              AppImageKeys.support_message_emp1,
              fit: BoxFit.cover,
              width: 50,
              height: 50,
            );
          },
        )
            : Image.asset(
          AppImageKeys.support_message_emp1,
          fit: BoxFit.cover,
          width: 50,
          height: 50,
        ),
      ),
    );
  }
}