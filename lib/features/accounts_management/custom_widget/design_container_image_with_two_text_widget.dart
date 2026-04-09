import 'package:emp_system_sun/features/accounts_management/custom_widget/title_with_sub_title.dart';
import 'package:emp_system_sun/features/internal_services/custom_widget/container_image_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../../../../../../core/theming/assets.dart';
import '../../../../../../core/theming/colors.dart';

class DesignContainerImageWithTwoTextWidget extends StatelessWidget {
  final String? imagePath, title, subTitle;
  final double? textSizeTitle,
      textSizeSubTitle,
      imageContainerWidth,
      imageContainerHeight;
  final Color? subTitleColor, titleColor, imageContainerColor;
  final bool? isBorder, isFlex;

  const DesignContainerImageWithTwoTextWidget({
    super.key,
    this.imagePath,
    this.title,
    this.subTitle,
    this.textSizeTitle,
    this.textSizeSubTitle,
    this.subTitleColor,
    this.titleColor,
    this.isBorder = false,
    this.isFlex=false,
    this.imageContainerColor,
    this.imageContainerHeight,
    this.imageContainerWidth,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsetsGeometry.all(10),
      decoration: BoxDecoration(
        color: AppColors.whiteColor,
        borderRadius: const BorderRadius.all(Radius.circular(20)),
        border: Border.all(color: AppColors.greyColor.withOpacity(0.3)),
        boxShadow: [
          BoxShadow(
            color: AppColors.darkColor.withOpacity(0.1),
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Wrap(
        spacing: 10,
        crossAxisAlignment: WrapCrossAlignment.center,
        alignment: WrapAlignment.center,
        children: [
          ContainerImageWidget(
            imagePath: imagePath ?? AppImageKeys.account_sun1,
            color: imageContainerColor ?? AppColors.pinkColor,
            isBorder: isBorder ?? false,
            width: imageContainerWidth ?? 70,
            height: imageContainerHeight,
          ),
          TitleWithSubTitle(
            title: title ?? 'أجمالي الارصدة ',
            subTitle: subTitle ?? '50000 ريال',
            textSizeTitle: textSizeTitle ?? 15,
            textSizeSubTitle: textSizeSubTitle ?? 14,
            subTitleColor: subTitleColor ?? AppColors.orangeColor,
            titleColor: titleColor ?? AppColors.blackColor,
          ),
        ],
      ),
    );
  }
}
