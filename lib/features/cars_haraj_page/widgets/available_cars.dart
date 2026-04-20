import 'dart:typed_data';

import 'package:flutter/material.dart';
import '../../../../../features/internal_services/internal_orders/custom_widget/text_with_container_status_car.dart';
import '../../../../../core/language/language_constant.dart';
import '../../../../../core/theming/assets.dart';
import '../../../../../core/theming/colors.dart';
import '../../../../../core/pages_widgets/general_widgets/custom_container.dart';
import '../../../../../core/theming/text_styles.dart';
import 'car_model.dart';

class AvailableCars extends StatelessWidget {
  const AvailableCars({super.key,this.price,this.brandName,this.isSold=false,this.isNew=false,this.addresstext,this.releaseDate,this.id, this.spacing, required this.onTap,required this.carImage,required this.brandImage});
  final String? id,addresstext,releaseDate,brandName,price;
  final double? spacing;
  final VoidCallback onTap;
  final bool isNew,isSold;
  final Uint8List? carImage,brandImage;


  @override
  Widget build(BuildContext context) {
    return CustomContainer(
      isSelected: false,
      onTap: () {},
      borderRadius: BorderRadius.circular(12),
      typeWidget: Wrap(
        spacing: spacing ?? 20,
        runSpacing: 10,
        crossAxisAlignment: WrapCrossAlignment.center,
        alignment: WrapAlignment.spaceBetween,
        children: [
          TextInAppWidget(text: id??'1#', textSize: 16, textColor: AppColors.darkColor),
           CarModel(
            addresstext:addresstext ,
            releaseDate:releaseDate ,
            imageBytes:carImage,
          ),
          TextWithContainerStatusCar(
            isNew:isNew,
            text: AppLanguageKeys.carStatus,
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              brandImage != null
                  ? Image.memory(
                brandImage!,
                width: 65,
                height: 40,
                fit: BoxFit.contain,
              )
                  : Image.asset(
                AppImageKeys.nesan,
                width: 30,
                height: 34,
                fit: BoxFit.contain,
              ),

               TextInAppWidget(
                  text: brandName??'نيسان',
                  textSize: 14,
                  textColor: AppColors.darkColor
               ),
            ],
          ),
          TextWithContainerStatusCar(
            isSold:isSold,
          ),
        //  const MessageNumbers(),
           Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              const TextInAppWidget(
                  text: AppLanguageKeys.carPrice,
                  textSize: 14,
                  textColor: AppColors.darkColor),
              TextInAppWidget(
                  text: price??AppLanguageKeys.priceKey,
                  textSize: 14,
                  textColor: AppColors.darkColor),
            ],
          ),
          CustomContainer(
            containerHeight: 32,
            containerWidth: 80,
            border: Border.all(color: AppColors.orangeColor),
            isSelected: true,
            onTap: onTap,
            padding: EdgeInsets.zero,
            typeWidget: const Center(
              child: TextInAppWidget(
                  text: AppLanguageKeys.detailsKey,
                  textSize: 14,
                  textColor: AppColors.orangeColor
              ),
            ),
          ),
        ],
      ),
    );
  }
}
