import 'package:flutter/material.dart';
import '../../../../../../../core/language/language_constant.dart';
import '../../../../../../../core/theming/colors.dart';
import '../../../../../../../core/theming/fonts.dart';
import '../../../../../../../core/theming/text_styles.dart';

class ContainerStatusCar extends StatelessWidget {
  final bool? isNew;
  final bool? isSold;
  final double? textSize;

  const ContainerStatusCar({
    super.key,
    this.isNew,
    this.isSold,
    this.textSize,
  });

  bool get isSoldStatus => isSold != null;

  String get statusText {
    if (isSoldStatus) {
      return isSold!
          ? AppLanguageKeys.sold
          : AppLanguageKeys.notSold;
    } else {
      return isNew == true
          ? AppLanguageKeys.newCar
          : AppLanguageKeys.usedCar;
    }
  }

  Color get backgroundColor {
    if (isSoldStatus) {
      return isSold!
          ? AppColors.partPinkMixColor.withOpacity(0.1)
          : AppColors.blackColor25;
    } else {
      return isNew == true
          ? AppColors.partGreenMixColor.withOpacity(0.1)
          : AppColors.blackColor25;
    }
  }

  Color get textColor {
    if (isSoldStatus) {
      return isSold!
          ? AppColors.redColor
          : AppColors.blackColor44;
    } else {
      return isNew == true
          ? AppColors.greenColor
          : AppColors.blackColor44;
    }
  }

  IconData get statusIcon {
    if (isSoldStatus) {
      return isSold!
          ? Icons.done
          : Icons.check_circle_outline;
    } else {
      return isNew == true
          ? Icons.done
          : Icons.directions_car;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 100,
      padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: const BorderRadius.all(Radius.circular(20)),
      ),
      child: Row(
        children: [
          Icon(
            statusIcon,
            size: 15,
            color: textColor,
          ),
          const SizedBox(width: 5),
          Expanded(
            child: TextInAppWidget(
              text: statusText,
              textSize: textSize ?? 10,
              fontWeightIndex: FontSelectionData.regularFontFamily,
              textColor: textColor,
            ),
          ),
        ],
      ),
    );
  }
}