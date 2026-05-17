import 'package:flutter/material.dart';
import '../../../../../core/language/language_constant.dart';
import '../../../../../core/pages_widgets/general_widgets/custom_container.dart';
import '../../../../../core/theming/colors.dart';

class NavigatorButton extends StatelessWidget {
  const NavigatorButton({
    super.key,
    this.onTapOrangeButton,
    this.onTapGrayButton,
    this.textOrangeButton,
    this.textGrayButton,
  });

  final VoidCallback? onTapOrangeButton;
  final VoidCallback? onTapGrayButton;
  final String? textOrangeButton;
  final String? textGrayButton;

  @override
  Widget build(BuildContext context) {
    final bool showOrangeButton =
        onTapOrangeButton != null || textOrangeButton != null;

    return CustomContainer(
      containerWidth: double.infinity,
      border: const Border(
        bottom: BorderSide(color: AppColors.lightGreyColor),
        left: BorderSide(color: AppColors.lightGreyColor),
        right: BorderSide(color: AppColors.lightGreyColor),
      ),
      borderRadius: const BorderRadius.only(
        bottomRight: Radius.circular(10),
        bottomLeft: Radius.circular(10),
      ),
      boxShadow: [
        BoxShadow(
          color: AppColors.lightGreyColor.withAlpha(60),
          blurRadius: 2,
          spreadRadius: 1,
          offset: const Offset(0, -3),
        ),
      ],
      isSelected: false,
      onTap: () {},
      typeWidget: Wrap(
        alignment: WrapAlignment.spaceBetween,
        spacing: 10,
        runSpacing: 10,
        children: [
          if (showOrangeButton)
            CustomContainer(
              isSelected: false,
              onTap: onTapOrangeButton ?? () {},
              text: textOrangeButton ?? AppLanguageKeys.nextKey,
              containerColor: AppColors.orangeColor,
              padding: const EdgeInsets.symmetric(horizontal: 70, vertical: 8),
            ),
          CustomContainer(
            isSelected: false,
            onTap: onTapGrayButton ?? () {},
            text: textGrayButton ?? AppLanguageKeys.backKey,
            containerColor: AppColors.darkGreyColor,
            padding: const EdgeInsets.symmetric(horizontal: 70, vertical: 8),
          ),
        ],
      ),
    );
  }
}
