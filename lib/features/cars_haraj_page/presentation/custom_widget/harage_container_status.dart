import 'package:flutter/material.dart';

import '../../../../../../../core/language/language_constant.dart';
import '../../../../../../../core/theming/colors.dart';
import '../../../../../../../core/theming/fonts.dart';
import '../../../../../../../core/theming/text_styles.dart';

class HarageContainerStatus extends StatelessWidget {
  final int? status;
  final double? textSize;

  const HarageContainerStatus({
    super.key,
    this.status,
    this.textSize,
  });

  String get statusText {
    switch (status) {
      case 1:
        return AppLanguageKeys.created;

      case 2:
        return AppLanguageKeys.pending;

      case 3:
        return AppLanguageKeys.sold;

      case 4:
        return AppLanguageKeys.deleted;

      default:
        return AppLanguageKeys.unknownType;
    }
  }

  bool get isCreated => status == 1;

  bool get isWaiting => status == 2;

  bool get isSold => status == 3;

  bool get isDeleted => status == 4;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 100,
      padding: const EdgeInsets.symmetric(
        vertical: 5,
        horizontal: 10,
      ),
      decoration: BoxDecoration(
        color: isCreated
            ? AppColors.blackColor25
            : isWaiting
            ? AppColors.yelloContainerLoadingColor.withOpacity(0.2)
            : isSold
            ? AppColors.partGreenMixColor.withOpacity(0.1)
            : isDeleted
            ? AppColors.partPinkMixColor.withOpacity(0.1)
            : AppColors.pinkColor,
        borderRadius: const BorderRadius.all(
          Radius.circular(20),
        ),
      ),
      child: Row(
        children: [
          Icon(
            isCreated
                ? Icons.add_circle_outline
                : isWaiting
                ? Icons.autorenew
                : isSold
                ? Icons.done
                : isDeleted
                ? Icons.delete_outline
                : Icons.settings,
            size: 15,
            color: isCreated
                ? AppColors.blackColor44
                : isWaiting
                ? AppColors.yelloIconLoadingColor
                : isSold
                ? AppColors.greenColor
                : isDeleted
                ? AppColors.redColor
                : AppColors.orangeColor,
          ),

          const SizedBox(width: 5),

          Expanded(
            child: TextInAppWidget(
              text: statusText,
              textSize: textSize ?? 11,
              fontWeightIndex:
              FontSelectionData.regularFontFamily,
              textColor: isCreated
                  ? AppColors.blackColor44
                  : isWaiting
                  ? AppColors.yelloTextLoadingColor
                  : isSold
                  ? AppColors.greenColor
                  : isDeleted
                  ? AppColors.redColor
                  : AppColors.orangeColor,
            ),
          ),
        ],
      ),
    );
  }
}