import 'package:flutter/material.dart';

import '../../../../../../../core/language/language_constant.dart';
import '../../../../../../../core/theming/colors.dart';
import '../../../../../../../core/theming/fonts.dart';
import '../../../../../../../core/theming/text_styles.dart';
import 'harage_container_status.dart';

class TextWithHarageContainerStatus extends StatelessWidget {
  final String? text;
  final double? textSizeContainer;
  final double? textSize;
  final int? status;

  const TextWithHarageContainerStatus({
    super.key,
    this.status,
    this.text,
    this.textSizeContainer,
    this.textSize,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      spacing: 5,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        TextInAppWidget(
          text: text ?? AppLanguageKeys.requestStatus,
          textSize: textSize ?? 11,
          fontWeightIndex:
          FontSelectionData.mediumFontFamily,
          textColor: AppColors.greyColor,
        ),

        HarageContainerStatus(
          status: status,
          textSize: textSizeContainer,
        ),
      ],
    );
  }
}