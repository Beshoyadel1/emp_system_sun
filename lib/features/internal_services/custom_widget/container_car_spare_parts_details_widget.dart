import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../../../../../../../../features/internal_services/internal_orders/custom_widget/row_number_coin_widget.dart';
import '../../../../../core/language/language_constant.dart';
import '../../../../../core/theming/assets.dart';
import '../../../../../core/theming/fonts.dart';
import '../../../../../core/theming/text_styles.dart';
import '../../../../../core/theming/colors.dart';

class ContainerCarSparePartsDetailsWidget extends StatelessWidget {
  final String textKindProduct,
      textNameCar,
      imagePathLogoCar,
      imageProduct,
      textNameProduct,
      countProductRemain,
      priceProduct;
  final void Function()? onTap;

  const ContainerCarSparePartsDetailsWidget({
    super.key,
    required this.textKindProduct,
    required this.textNameCar,
    required this.imageProduct,
    required this.textNameProduct,
    required this.countProductRemain,
    required this.priceProduct,
    required this.imagePathLogoCar,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsetsGeometry.all(10),
      decoration: BoxDecoration(
        color: AppColors.whiteColor,
        borderRadius: BorderRadius.all(Radius.circular(20)),
        border: Border.all(color: AppColors.greyColor.withOpacity(0.3)),
        boxShadow: [
          BoxShadow(
            color: AppColors.darkColor.withOpacity(0.1),
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        spacing: 15,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: TextInAppWidget(
                  text: textKindProduct,
                  textSize: 12,
                  fontWeightIndex: FontSelectionData.regularFontFamily,
                  textColor: AppColors.orangeColor,
                ),
              ),
              Row(
                spacing: 5,
                children: [
                  TextInAppWidget(
                    text: textNameCar,
                    textSize: 12,
                    fontWeightIndex: FontSelectionData.regularFontFamily,
                    textColor: AppColors.greyColor,
                  ),
                  Image.asset(imagePathLogoCar),
                ],
              )
            ],
          ),
          Image.asset(AppImageKeys.spare_parts),
          TextInAppWidget(
            text: textNameProduct,
            textSize: 12,
            fontWeightIndex: FontSelectionData.regularFontFamily,
            textColor: AppColors.blackColor44,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: TextInAppWidget(
                  text: countProductRemain,
                  textSize: 12,
                  fontWeightIndex: FontSelectionData.regularFontFamily,
                  textColor: AppColors.blueColor,
                ),
              ),
              RowNumberCoinWidget(
                  numberText: priceProduct,
                  sizeText: 12,
                  imageSrc: AppImageKeys.coin)
            ],
          ),
          InkWell(
            onTap: onTap,
            child: Container(
              padding:
                  EdgeInsetsGeometry.symmetric(vertical: 5, horizontal: 20),
              decoration: BoxDecoration(
                color: AppColors.secondaryColor,
                borderRadius: BorderRadius.all(Radius.circular(20)),
              ),
              child: TextInAppWidget(
                text: AppLanguageKeys.details,
                textSize: 12,
                fontWeightIndex: FontSelectionData.regularFontFamily,
                textColor: AppColors.whiteColor,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
