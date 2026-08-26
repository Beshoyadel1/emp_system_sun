import 'dart:typed_data';
import 'package:emp_system_sun/features/order_status_design/presentation/custom_widget/title_with_sub_title.dart';
import 'package:flutter/material.dart';
import '../../../../../../core/theming/fonts.dart';
import '../../../../../../core/language/language_constant.dart';
import '../../../../../../core/pages_widgets/general_widgets/custom_container.dart';
import '../../../../../../core/theming/colors.dart';
import '../../../../../../core/theming/text_styles.dart';


class WidgetDesignListHarag extends StatelessWidget {
  const WidgetDesignListHarag({
    super.key,
    this.haragId,
    this.name,
    this.nameButton,
    this.image,
    this.kilometers,
    this.releaseDate,
    this.sellDate,
    this.isNew,
    this.isSold,
    this.onTabDetails,
    this.spacing,
    this.isDemoData=false
  });

  final String? haragId;
  final String? name;
  final String? nameButton;
  final String? kilometers;
  final String? releaseDate;
  final String? sellDate;
  final double? spacing;
  final bool isDemoData;

  final void Function()? onTabDetails;

  final Uint8List? image;

  final bool? isNew;
  final bool? isSold;

  @override
  Widget build(BuildContext context) {
    return CustomContainer(
      isSelected: false,
      onTap: () {},
      borderRadius: BorderRadius.circular(12),

      typeWidget: Wrap(
        spacing: spacing ?? 20,
        runSpacing: 10,

        crossAxisAlignment:
        WrapCrossAlignment.center,

        alignment:
        WrapAlignment.spaceBetween,

        children: [
          // ID
          SizedBox(
            width: 120,
            child: TitleWithSubTitle(
              title: AppLanguageKeys.identity,
              subTitle: haragId ?? '#1',
              textSizeTitle: 12,
              titleColor:
              AppColors.greyColor,
              textSizeSubTitle: 14,
              subTitleColor:
              AppColors.darkColor,
            ),
          ),


          // USER
          if(!isDemoData)
            SizedBox(
              width: 250,
              child: Wrap(
                spacing: 5,
                runSpacing: 5,

                crossAxisAlignment:
                WrapCrossAlignment.center,

                children: [
                  image != null
                      ? CircleAvatar(
                    radius: 20,
                    backgroundImage:
                    MemoryImage(image!),
                  )
                      : const CircleAvatar(
                    radius: 20,
                    backgroundColor:
                    Colors.red,
                  ),

                  SizedBox(
                    width: 180,
                    child: TextInAppWidget(
                      text: name ?? '###',
                      textSize: 15,
                      fontWeightIndex:
                      FontSelectionData
                          .mediumFontFamily,
                      textColor:
                      AppColors.blackColor,
                      maxLines: 1,
                    ),
                  ),
                ],
              ),
            ),


          // KILOMETERS
          if(!isDemoData)
            SizedBox(
              width: 120,
              child: TitleWithSubTitle(
                title:
                AppLanguageKeys.kilometers,
                subTitle:
                kilometers ?? '0',
                textSizeTitle: 12,
                titleColor:
                AppColors.greyColor,
                textSizeSubTitle: 14,
                subTitleColor:
                AppColors.darkColor,
              ),
            ),

          // RELEASE DATE
          SizedBox(
            width: 180,
            child: TitleWithSubTitle(
              title:
              AppLanguageKeys.releaseDate,
              subTitle:
              releaseDate ?? '---',
              textSizeTitle: 12,
              titleColor:
              AppColors.greyColor,
              textSizeSubTitle: 14,
              subTitleColor:
              AppColors.darkColor,
            ),
          ),

          // CONDITION - New / Used
          SizedBox(
            width: 120,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const TextInAppWidget(
                  text: AppLanguageKeys.condition,
                  textSize: 12,
                  fontWeightIndex:
                  FontSelectionData.mediumFontFamily,
                  textColor: AppColors.greyColor,
                ),

                const SizedBox(height: 5),

                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 5,
                  ),
                  decoration: BoxDecoration(
                    color: isNew == true
                        ? Colors.green.withOpacity(0.1)
                        : Colors.orange.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: TextInAppWidget(
                    text: isNew == true
                        ? AppLanguageKeys.newCar
                        : AppLanguageKeys.usedCar,
                    textSize: 12,
                    fontWeightIndex:
                    FontSelectionData.mediumFontFamily,
                    textColor: isNew == true
                        ? Colors.green
                        : Colors.orange,
                  ),
                ),
              ],
            ),
          ),

          // SALE STATUS - Sold / Not Sold
          SizedBox(
            width: 120,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const TextInAppWidget(
                  text: AppLanguageKeys.saleStatus,
                  textSize: 12,
                  fontWeightIndex:
                  FontSelectionData.mediumFontFamily,
                  textColor: AppColors.greyColor,
                ),

                const SizedBox(height: 5),

                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 10,
                    vertical: 5,
                  ),
                  decoration: BoxDecoration(
                    color: isSold == true
                        ? Colors.red.withOpacity(0.08)
                        : Colors.blue.withOpacity(0.08),
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(
                      color: isSold == true
                          ? Colors.red.withOpacity(0.35)
                          : Colors.blue.withOpacity(0.35),
                    ),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(
                        isSold == true
                            ? Icons.sell_outlined
                            : Icons.inventory_2_outlined,
                        size: 14,
                        color: isSold == true
                            ? Colors.red
                            : Colors.blue,
                      ),

                      const SizedBox(width: 5),

                      TextInAppWidget(
                        text: isSold == true
                            ? AppLanguageKeys.sold
                            : AppLanguageKeys.notSold,
                        textSize: 12,
                        fontWeightIndex:
                        FontSelectionData.mediumFontFamily,
                        textColor: isSold == true
                            ? Colors.red
                            : Colors.blue,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),

          // DETAILS
          SizedBox(
            width: 110,
            child: InkWell(
              onTap: onTabDetails,

              child: Container(
                padding:
                const EdgeInsets.symmetric(
                  horizontal: 20,
                  vertical: 6,
                ),

                decoration:
                BoxDecoration(
                  color:
                  AppColors.whiteColor,

                  borderRadius:
                  const BorderRadius.all(
                    Radius.circular(20),
                  ),

                  border: Border.all(
                    color:
                    AppColors.orangeColor,
                  ),
                ),

                child: Center(
                  child: TextInAppWidget(
                    text: nameButton ??
                        AppLanguageKeys.details,

                    textSize: 12,

                    fontWeightIndex:
                    FontSelectionData
                        .mediumFontFamily,

                    textColor:
                    AppColors.orangeColor,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}