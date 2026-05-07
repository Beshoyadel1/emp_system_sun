import 'dart:typed_data';
import 'package:emp_system_sun/features/internal_services/internal_orders/custom_widget/row_number_coin_widget.dart';
import 'package:flutter/material.dart';
import '../../../../../core/theming/fonts.dart';
import '../../../../../core/language/language_constant.dart';
import '../../../../../core/theming/assets.dart';
import '../../../../../core/theming/text_styles.dart';
import '../../../../../core/theming/colors.dart';

class ContainerCarSparePartsDetailsWidget extends StatelessWidget {
  final String nameCategoryProduct,
      nameBrandCar,
      nameProduct,
      stock,
      priceProduct;
  final Uint8List? imageProductBytes;
  final Uint8List? imageCarBrandBytes;

  final void Function()? onTap;

  const ContainerCarSparePartsDetailsWidget({
    super.key,
    required this.nameCategoryProduct,
    required this.nameBrandCar,
    required this.nameProduct,
    required this.stock,
    required this.priceProduct,
    this.imageProductBytes,
    this.imageCarBrandBytes,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: AppColors.whiteColor,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: AppColors.greyColor.withOpacity(0.3)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: 10,
        children: [
          Row(
            spacing: 10,
            children: [
              Expanded(
                child: TextInAppWidget(
                  text: nameCategoryProduct,
                  textSize: 12,
                  textColor: AppColors.orangeColor,
                  maxLines: 1,
                ),
              ),
              Row(
                spacing: 10,
                children: [
                  TextInAppWidget(
                    text: nameBrandCar,
                    textSize: 12,
                    textColor: AppColors.greyColor,
                    maxLines: 1,
                  ),
                  _buildImage(imageCarBrandBytes, size: 20),
                ],
              ),
            ],
          ),

          Center(child: _buildImage(imageProductBytes, size: 80)),

          Center(
            child: TextInAppWidget(
              text: nameProduct,
              textSize: 14,
              textColor: AppColors.blackColor44,
              fontWeightIndex: FontSelectionData.regularFontFamily,
              maxLines: 1,
            ),
          ),

          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            spacing: 10,
            children: [
              Expanded(
                child: Row(
                  spacing: 3,
                  children: [
                    const Flexible(
                      child: TextInAppWidget(
                        text: AppLanguageKeys.remainingQuantity,
                        textSize: 12,
                        textColor: AppColors.blueColor,
                        maxLines: 1,
                      ),
                    ),
                    TextInAppWidget(
                      text: stock,
                      textSize: 12,
                      textColor: AppColors.blueColor,
                      maxLines: 1,
                    ),
                  ],
                ),
              ),
              RowNumberCoinWidget(
                numberText: priceProduct,
                sizeText: 12,
                imageSrc: AppImageKeys.coin,
              ),
            ],
          ),

          Center(
            child: InkWell(
              onTap: onTap,
              child: Container(
                padding:
                const EdgeInsets.symmetric(vertical: 5, horizontal: 20),
                decoration: BoxDecoration(
                  color: AppColors.secondaryColor,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: const TextInAppWidget(
                  text: AppLanguageKeys.details,
                  textSize: 12,
                  textColor: AppColors.whiteColor,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildImage(Uint8List? bytes, {double size = 50}) {
    if (bytes != null && bytes.isNotEmpty) {
      return ClipRRect(
        borderRadius: BorderRadius.circular(10),
        child: Image.memory(bytes,
            height: size, width: size, fit: BoxFit.cover),
      );
    }

    return Container(
      height: size,
      width: size,
      decoration: BoxDecoration(
        color: AppColors.greyColor.withOpacity(0.2),
        borderRadius: BorderRadius.circular(10),
      ),
      child: const Icon(Icons.directions_car, color: Colors.grey),
    );
  }
}