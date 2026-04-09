import 'package:flutter/material.dart';
import '../../../../../core/language/language_constant.dart';
import '../../../../../core/theming/assets.dart';
import '../../../../../core/theming/colors.dart';
import '../../../../../core/theming/fonts.dart';
import '../../../../../core/pages_widgets/general_widgets/custom_container.dart';
import '../../../../../core/theming/text_styles.dart';

class UpdateCarWidget extends StatelessWidget {
  const UpdateCarWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
        width: double.infinity,
        child: Wrap(
            spacing: 15,
            runSpacing: 5,
            alignment: WrapAlignment.spaceBetween,
            crossAxisAlignment: WrapCrossAlignment.end,
            children: [
              const Wrap(
                  spacing: 15,
                  runSpacing: 5,
                  crossAxisAlignment: WrapCrossAlignment.end,
                  children: [
                    Column(
                      children: [
                        TextInAppWidget(
                            text: AppLanguageKeys.orderDetailsTitleKey,
                            textSize: 20,
                            textColor: AppColors.darkColor,
                            fontWeightIndex:
                                FontSelectionData.mediumFontFamily),
                        TextInAppWidget(
                          text: AppLanguageKeys.viewAllOrderDetailsKey,
                          textSize: 14,
                          textColor: AppColors.darkGreyColor,
                          fontWeightIndex: FontSelectionData.regularFontFamily,
                        ),
                      ],
                    ),
                  ]),
              Wrap(
                children: [
                  CustomContainer(
                    containerWidth: 120,
                    containerHeight: 40,
                    padding: const EdgeInsets.all(0),
                    containerColor: AppColors.darkGreyColor,
                    isSelected: false,
                    onTap: () {},
                    typeWidget: const Center(
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.edit,
                            color: AppColors.whiteColor,
                            size: 14,
                          ),
                          TextInAppWidget(
                              text: 'تعديل',
                              textSize: 13,
                              fontWeightIndex:
                                  FontSelectionData.regularFontFamily,
                              textColor: AppColors.whiteColor),
                        ],
                      ),
                    ),
                  ),
                  CustomContainer(
                    containerWidth: 120,
                    containerHeight: 40,
                    padding: EdgeInsets.all(0),
                    containerColor: AppColors.redColor,
                    isSelected: false,
                    onTap: () {},
                    typeWidget: Center(
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Image.asset(
                            AppImageKeys.deleteIcon,
                            width: 14,
                            height: 14,
                            fit: BoxFit.contain,
                          ),
                          const TextInAppWidget(
                              text: 'حذف',
                              textSize: 13,
                              fontWeightIndex:
                                  FontSelectionData.regularFontFamily,
                              textColor: AppColors.whiteColor),
                        ],
                      ),
                    ),
                  ),
                ],
              )
            ]));
  }
}
