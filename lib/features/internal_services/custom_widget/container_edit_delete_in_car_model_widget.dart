import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../../../../../core/theming/assets.dart';
import 'container_white_image_text_widget.dart';
import 'container_edit_delete_widget.dart';
import '../../../../../core/theming/colors.dart';
import '../../../../../../core/theming/fonts.dart';
import '../../../../../../core/theming/text_styles.dart';

class ContainerEditDeleteInCarModelWidget extends StatelessWidget {
  const ContainerEditDeleteInCarModelWidget({super.key});

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
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: 10,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              TextInAppWidget(
                text: 'السيارات المضافة 1',
                textSize: 15,
                fontWeightIndex: FontSelectionData.regularFontFamily,
                textColor: AppColors.blackColor,
              ),
              Row(
                spacing: 5,
                children: [
                  ContainerEditDeleteWidget(isDelete: true,),
                  ContainerEditDeleteWidget(),
                ],
              )
            ],
          ),
          TextInAppWidget(
            text: 'بي ان دبليو',
            textSize: 15,
            fontWeightIndex: FontSelectionData.regularFontFamily,
            textColor: AppColors.greyColor,
          ),
          Row(
            spacing: 10,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              ContainerWhiteImageTextWidget(
                text: 'BMW',
                imagePath: AppImageKeys.car1,
              ),
              ContainerWhiteImageTextWidget(
                text: 'BMW',
                imagePath: AppImageKeys.car1,
              ),
              ContainerWhiteImageTextWidget(
                text: 'BMW',
                imagePath: AppImageKeys.car1,
              ),
              ContainerWhiteImageTextWidget(
                text: 'BMW',
                imagePath: AppImageKeys.car1,
              )
            ],
          )
        ],
      ),
    );
  }
}
