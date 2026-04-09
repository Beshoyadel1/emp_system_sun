import 'package:flutter/cupertino.dart';
import '../../../../../../core/language/language_constant.dart';
import '../../../../../../features/order_status_design/custom_widget/column_image_car_with_two_text_widget.dart';
import '../../../../../../features/order_status_design/custom_widget/image_with_two_text.dart';
import '../../../../../../../../core/theming/assets.dart';
import '../../../../../../../../core/theming/colors.dart';


class FirstPartOfDataDialogRejectOrder extends StatelessWidget {
  const FirstPartOfDataDialogRejectOrder({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      spacing: 20,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const ImageWithTwoText(
              imageSrc: AppImageKeys.service33,
              title: AppLanguageKeys.internalServicesTitleKey,
              subTitle: AppLanguageKeys.maintenanceAndRepairTitleKey,
              titleColor: AppColors.orangeColor,
              subTitleColor:AppColors.blackColor,
            ),
            ColumnImageCarWithTwoTextWidget(
              imageSrc: AppImageKeys.car1,
              kindCar:'Ariya',
              nameCar:'Nissan',
            ),
          ],
        )
      ],
    );
  }
}
