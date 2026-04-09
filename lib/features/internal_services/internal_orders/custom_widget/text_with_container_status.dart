import 'package:emp_system_sun/features/internal_services/internal_orders/custom_widget/container_status.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../../../../../../../core/language/language_constant.dart';
import '../../../../../../../core/theming/colors.dart';
import '../../../../../../../core/theming/fonts.dart';
import '../../../../../../../core/theming/text_styles.dart';

class TextWithContainerStatus extends StatelessWidget {
  final String? text;
  final double? textSizeContainer, textSize;
  final int? status;

  const TextWithContainerStatus(
      {super.key,
      this.status,
      this.text,
      this.textSizeContainer,
      this.textSize});

  @override
  Widget build(BuildContext context) {
    return Column(
      spacing: 5,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        TextInAppWidget(
          text: text ?? AppLanguageKeys.requestStatus,
          textSize: textSize ?? 11,
          fontWeightIndex: FontSelectionData.mediumFontFamily,
          textColor: AppColors.greyColor,
        ),
        ContainerStatus(
          status: status,
          textSize: textSizeContainer,
        )
      ],
    );
  }
}
