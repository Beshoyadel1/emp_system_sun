import 'package:flutter/material.dart';
import '../../../../../core/theming/colors.dart';
import '../../../../../core/theming/fonts.dart';
import '../../../../../core/theming/text_styles.dart';

class ContainerListOrdersInDataContainerInListDataFirstScreenNotificationsWidget
    extends StatelessWidget {
  final String text;
  final bool isSelect;
  final VoidCallback onTap;

  const ContainerListOrdersInDataContainerInListDataFirstScreenNotificationsWidget({
    super.key,
    required this.text,
    required this.isSelect,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
        decoration: BoxDecoration(
          color: isSelect ? AppColors.orangeColor : AppColors.greyColor,
          borderRadius: const BorderRadius.all(Radius.circular(20)),
        ),
        child: TextInAppWidget(
          text: text,
          textSize: 13,
          fontWeightIndex: FontSelectionData.mediumFontFamily,
          textColor: AppColors.whiteColor,
        ),
      ),
    );
  }
}
