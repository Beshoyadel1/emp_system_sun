import 'package:flutter/material.dart';
import '../../../../../../features/cars_haraj_page/widgets/aspect_ratio_widget.dart';
import '../../../../../../features/store_page/store_widgets/car_model_widget/widgets/select_date_widget.dart';
import '../../../../../core/language/language_constant.dart';
import '../../../../../core/theming/colors.dart';
import '../../../../../core/theming/fonts.dart';
import '../../../../../core/pages_widgets/general_widgets/custom_container.dart';
import '../../../../../core/theming/text_styles.dart';

class ProfitsServices extends StatelessWidget {
  const ProfitsServices({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomContainer(
        containerWidth: 500,
        borderRadius: BorderRadius.circular(12),
        isSelected: false,
        onTap: () {},
        typeWidget: const Column(
            spacing: 20,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
               Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  TextInAppWidget(
                    text: AppLanguageKeys.internalServicesProfitKey,
                    textSize: 16,
                    fontWeightIndex: FontSelectionData.regularFontFamily,
                  ),
                  // TextInAppWidget(
                  //   text: AppLanguageKeys.priceKey,
                  //   textSize: 16,
                  //   fontWeightIndex: FontSelectionData.regularFontFamily,
                  //   textColor: AppColors.orangeColor,
                  // ),
                ],
              ),
             //  SelectDateWidget(),
              AspectRatioWidget(),
               SizedBox(
                height: 10,
              ),
            ]));
  }
}
