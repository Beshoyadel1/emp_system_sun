import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../../../../../../core/language/language_constant.dart';
import '../../../../../../core/pages_widgets/general_widgets/custom_container.dart';
import '../../../../../../core/theming/colors.dart';
import '../../../../../../core/theming/fonts.dart';
import '../../../../../../core/theming/text_styles.dart';

class DesignViewTypeServiceWidget extends StatelessWidget {
  const DesignViewTypeServiceWidget({
    super.key,
    required this.serviceTypes,
  });
  final List<String> serviceTypes;

  @override
  Widget build(BuildContext context) {
    return CustomContainer(
      onTap: () {},
      isSelected: false,
      borderRadius: BorderRadius.circular(5),
      border: Border.all(
        color: AppColors.orangeColor.withOpacity(0.4),
      ),
      typeWidget: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: 10,
        children: [
          Wrap(
            spacing: 15,
            runSpacing: 10,
            crossAxisAlignment: WrapCrossAlignment.start,
            alignment: WrapAlignment.start,
            children: [
              CustomContainer(
                isSelected: false,
                onTap: () {},
                containerColor: AppColors.pinkColor.withOpacity(0.8),
                borderRadius: BorderRadius.circular(5),
                border: Border.all(color: AppColors.transparent),
                typeWidget: const Icon(
                  Icons.handyman,
                  color: AppColors.orangeColor,
                  size: 20,
                ),
              ),
              Column(
                spacing: 5,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const TextInAppWidget(
                    text: AppLanguageKeys.serviceTypes,
                    textSize: 12,
                    fontWeightIndex:
                    FontSelectionData.mediumFontFamily,
                    textColor: AppColors.greyColor,
                  ),
                  Wrap(
                    spacing: 10,
                    runSpacing: 10,
                    crossAxisAlignment: WrapCrossAlignment.start,
                    alignment: WrapAlignment.start,
                    children: List.generate(
                      serviceTypes.length,
                          (index) => CustomContainer(
                        isSelected: true,
                        padding: const EdgeInsets.all(4),
                        containerColor:
                        AppColors.greyColor.withOpacity(0.5),
                        border: Border.all(
                          color: AppColors.greyColor,
                        ),
                        borderRadius: BorderRadius.circular(5),
                        onTap: () {},
                        typeWidget: TextInAppWidget(
                          text: serviceTypes[index],
                          textSize: 9,
                          fontWeightIndex:
                          FontSelectionData.boldFontFamily,
                          textColor: AppColors.blackColor,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}