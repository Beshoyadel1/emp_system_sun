import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../../../../../core/language/language_constant.dart';
import '../../../../../core/theming/colors.dart';
import '../../../../../core/theming/fonts.dart';
import '../../../../../core/theming/text_styles.dart';

class ContainerListCarDataServiceSettingWidget extends StatelessWidget {
  final String imagePath, nameModel;
  final void Function()? onTap;

  const ContainerListCarDataServiceSettingWidget({
    super.key,
    required this.imagePath,
    required this.nameModel,
    this.onTap
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsetsGeometry.all(10),
      decoration: BoxDecoration(
        color: AppColors.whiteColor,
        borderRadius: BorderRadius.all(Radius.circular(20)),
        border: Border.all(
            color: AppColors.greyColor.withOpacity(0.3)
        ),
        boxShadow: [
          BoxShadow(
            color: AppColors.darkColor.withOpacity(0.1),
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        spacing: 10,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Flexible(
            child: Row(
              spacing: 10,
              children: [
                Flexible(
                  child: Container(
                    padding: EdgeInsetsGeometry.symmetric(
                        vertical: 10, horizontal: 10),
                    decoration: BoxDecoration(
                      color: AppColors.whiteColor,
                      borderRadius: BorderRadius.all(Radius.circular(20)),
                      border: Border.all(
                          color: AppColors.greyColor.withOpacity(0.3)
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: AppColors.darkColor.withOpacity(0.1),
                          blurRadius: 4,
                          offset: const Offset(0, 2),
                        ),
                      ],
                    ),
                    child: Image.asset(imagePath),
                  ),
                ),
                TextInAppWidget(
                  text: nameModel,
                  textSize: 14,
                  fontWeightIndex: FontSelectionData.regularFontFamily,
                  textColor: AppColors.blackColor,
                ),
              ],
            ),
          ),
          InkWell(
            onTap: onTap,
            child: Container(
              padding: EdgeInsetsGeometry.symmetric(
                  horizontal: 15, vertical: 5),
              decoration: BoxDecoration(
                color: AppColors.orangeColor,
                borderRadius: BorderRadius.all(Radius.circular(20)),
              ),
              child: TextInAppWidget(
                text: AppLanguageKeys.servicesSettings,
                textSize: 13,
                fontWeightIndex: FontSelectionData.regularFontFamily,
                textColor: AppColors.whiteColor,
              ),
            ),
          )
        ],
      ),
    );
  }
}
