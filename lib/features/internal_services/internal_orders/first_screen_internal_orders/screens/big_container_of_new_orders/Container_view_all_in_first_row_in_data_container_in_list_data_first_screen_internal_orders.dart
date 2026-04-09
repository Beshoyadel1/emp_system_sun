import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../../../../../../../core/language/language_constant.dart';
import '../../../../../../../core/theming/colors.dart';
import '../../../../../../../core/theming/fonts.dart';
import '../../../../../../../core/theming/text_styles.dart';

class ContainerViewAllInFirstRowInDataContainerInListDataFirstScreenInternalOrders
    extends StatelessWidget {
  final void Function()? onTap;
  final String? text;
  const ContainerViewAllInFirstRowInDataContainerInListDataFirstScreenInternalOrders({
    super.key,
    this.onTap,
    this.text
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsetsGeometry.symmetric(horizontal: 15, vertical: 10),
        decoration: BoxDecoration(
          color: AppColors.orangeColor,
          borderRadius: const BorderRadius.all(Radius.circular(20)),
          boxShadow: [
            BoxShadow(
              color: AppColors.darkColor.withOpacity(0.1),
              blurRadius: 4,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child:  TextInAppWidget(
          text: text??AppLanguageKeys.viewAll,
          textSize: 13,
          fontWeightIndex: FontSelectionData.regularFontFamily,
          textColor: AppColors.whiteColor,
        ),
      ),
    );
  }
}
