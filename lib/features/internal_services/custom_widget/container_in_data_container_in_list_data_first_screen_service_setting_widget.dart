import 'dart:typed_data';
import 'package:emp_system_sun/features/internal_services/custom_widget/container_image_widget.dart';
import 'package:emp_system_sun/features/internal_services/custom_widget/container_return_to_page_setting.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../../../../../core/utilies/map_of_all_app.dart';
import '../../../../../core/language/language_constant.dart';
import '../../../../../core/theming/fonts.dart';
import '../../../../../core/theming/text_styles.dart';
import '../../../../../core/theming/colors.dart';

class ContainerInDataContainerInListDataFirstScreenServiceSettingWidget
    extends StatelessWidget {
  final String?  title,imagePath;
  final void Function()? onTap;
  final bool? isTaskEdit;
  final Uint8List? imageMemory;

  const ContainerInDataContainerInListDataFirstScreenServiceSettingWidget({
    super.key,
    this.imagePath,
     this.imageMemory,
     this.title,
    this.onTap,
    this.isTaskEdit = false,
  });

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    bool isMobile = size.width <= ValuesOfAllApp.mobileWidth;

    return Container(
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: AppColors.whiteColor,
        borderRadius: const BorderRadius.all(Radius.circular(20)),
        border: Border.all(
          color: AppColors.greyColor.withOpacity(0.3),
        ),
        boxShadow: [
          BoxShadow(
            color: AppColors.darkColor.withOpacity(0.1),
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: isMobile
          ? Column(
              spacing: 10,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  spacing: 10,
                  children: [
                    Flexible(
                      child: ContainerImageWidget(
                        imagePath: imagePath,
                        imageMemory: imageMemory,
                        color: isTaskEdit!
                            ? AppColors.orangeColor
                            : AppColors.greyColor,
                        width: 50,
                        height: 50,
                      ),
                    ),
                    Expanded(
                      child: TextInAppWidget(
                        text: title!,
                        textSize: 13,
                        fontWeightIndex: FontSelectionData.regularFontFamily,
                        textColor: AppColors.blackColor,
                        maxLines: 2,
                        isEllipsisTextOverflow: true,
                      ),
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Expanded(
                      child: ContainerReturnToPageSetting(
                        color: isTaskEdit!
                            ? AppColors.blackColor44
                            : AppColors.orangeColor,
                        text: isTaskEdit!
                            ? AppLanguageKeys.edit
                            : AppLanguageKeys.addServices,
                        icon: isTaskEdit!
                            ? Icons.edit_calendar
                            : CupertinoIcons.add,
                        onTap: onTap,
                      ),
                    ),
                  ],
                ),
              ],
            )
          : Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Flexible(
                  child: Row(
                    spacing: 10,
                    children: [
                      ContainerImageWidget(
                        imagePath: imagePath,
                        imageMemory: imageMemory,
                        color: isTaskEdit!
                            ? AppColors.orangeColor
                            : AppColors.greyColor,
                        width: 50,
                        height: 50,
                      ),
                      Expanded(
                        child: TextInAppWidget(
                          text: title!,
                          textSize: 13,
                          fontWeightIndex: FontSelectionData.regularFontFamily,
                          textColor: AppColors.blackColor,
                          maxLines: 1,
                          isEllipsisTextOverflow: true,
                        ),
                      ),
                    ],
                  ),
                ),
                ContainerReturnToPageSetting(
                  color: isTaskEdit!
                      ? AppColors.blackColor44
                      : AppColors.orangeColor,
                  text: isTaskEdit!
                      ? AppLanguageKeys.edit
                      : AppLanguageKeys.addServices,
                  icon: isTaskEdit! ? Icons.edit_calendar : CupertinoIcons.add,
                  onTap: onTap,
                ),
              ],
            ),
    );
  }
}
