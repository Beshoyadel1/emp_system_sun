import 'dart:typed_data';
import 'package:flutter/cupertino.dart';
import '../../../../core/theming/assets.dart';
import '../../../../../../../core/theming/colors.dart';
import '../../../../../../../core/theming/fonts.dart';
import '../../../../../../../core/theming/text_styles.dart';

class RowImageWithTitleWidget extends StatelessWidget {
  final String title, subTitle;
  final double? textSizeTitle;
  final bool isJob,isWrap;
  final Uint8List? imagePath;

  const RowImageWithTitleWidget({
    super.key,
    this.imagePath,
    required this.title,
    required this.subTitle,
    this.isJob = false,
    this.isWrap = false,
    this.textSizeTitle,
  });

  @override
  Widget build(BuildContext context) {
    return isWrap?
    Wrap(
      children: [
        imagePath != null
            ? Image.memory(
          imagePath!,
          width: 30,
        )
            :  Image.asset(
          AppImageKeys.person22,
          //width: 30,
        ),

        const SizedBox(width: 5),

        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextInAppWidget(
              text: title,
              textSize: textSizeTitle ?? 12,
              fontWeightIndex: FontSelectionData.regularFontFamily,
              textColor:
              isJob ? AppColors.greyColor : AppColors.orangeColor,
            ),
            const SizedBox(height: 5),
            TextInAppWidget(
              text: subTitle,
              textSize: 9,
              fontWeightIndex: FontSelectionData.mediumFontFamily,
              textColor: AppColors.darkColor,
            ),
          ],
        ),
      ],
    )
    :
    Row(
      children: [
        imagePath != null
            ? Image.memory(
          imagePath!,
          width: 30,
        )
            :  Image.asset(
          AppImageKeys.person22,
          //width: 30,
        ),

        const SizedBox(width: 5),

        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextInAppWidget(
                text: title,
                textSize: textSizeTitle ?? 12,
                fontWeightIndex: FontSelectionData.regularFontFamily,
                textColor:
                isJob ? AppColors.greyColor : AppColors.orangeColor,
              ),
              const SizedBox(height: 5),
              TextInAppWidget(
                text: subTitle,
                textSize: 9,
                fontWeightIndex: FontSelectionData.mediumFontFamily,
                textColor: AppColors.darkColor,
              ),
            ],
          ),
        ),
      ],
    );
  }
}