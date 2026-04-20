import 'dart:typed_data';
import 'package:emp_system_sun/features/cars_haraj_page/custom_widget/title_with_sub_title.dart';
import 'package:flutter/material.dart';
import '../../../../../features/cars_haraj_page/widgets/car_model.dart';
import '../../../../../features/internal_services/internal_orders/custom_widget/text_with_container_status_car.dart';
import '../../../../../core/language/language_constant.dart';
import '../../../../../core/theming/assets.dart';
import '../../../../../core/theming/colors.dart';
import '../../../../../core/pages_widgets/general_widgets/custom_container.dart';
import '../../../../../core/theming/text_styles.dart';

class AvailableCarsDetails extends StatelessWidget {
  const AvailableCarsDetails(
      {super.key,
      this.price,
      this.brandName,
      this.isSold = false,
      this.isNew = false,
      this.addresstext,
      this.releaseDate,
      this.id,
      this.spacing,
       this.carImage,
       this.brandImage,
        this.kilometers,
        this.userName
      });

  final String? id, addresstext, releaseDate, brandName, price,kilometers,userName;
  final double? spacing;
  final bool? isNew, isSold;
  final Uint8List? carImage, brandImage;

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
          TextInAppWidget(
              text: id ?? '1#', textSize: 16, textColor: AppColors.darkColor),
          CarModel(
            addresstext: addresstext,
            releaseDate: releaseDate,
            imageBytes: carImage,
          ),
          TextWithContainerStatusCar(
            isNew: isNew,
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
                  text: brandName ?? 'نيسان',
                  textSize: 14,
                  textColor: AppColors.darkColor),
            ],
          ),
          TextWithContainerStatusCar(
            isSold: isSold,
          ),
          //  const MessageNumbers(),
          TitleWithSubTitle(
            title: AppLanguageKeys.carPrice,
            subTitle: price ?? AppLanguageKeys.priceKey,
            textSizeTitle:12,
            titleColor: AppColors.greyColor,
            textSizeSubTitle: 14,
            subTitleColor: AppColors.darkColor,
          ),
          TitleWithSubTitle(
            title: AppLanguageKeys.mileage,
            subTitle: kilometers??"500",
            textSizeTitle:12,
            titleColor: AppColors.greyColor,
            textSizeSubTitle: 14,
            subTitleColor: AppColors.darkColor,
          ),
          TitleWithSubTitle(
            title: AppLanguageKeys.username,
            subTitle: userName??"Beshoy",
            textSizeTitle:12,
            titleColor: AppColors.greyColor,
            textSizeSubTitle: 14,
            subTitleColor: AppColors.darkColor,
          ),
        ],
      ),
    );
  }
}