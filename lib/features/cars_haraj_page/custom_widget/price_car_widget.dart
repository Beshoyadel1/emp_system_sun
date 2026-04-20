import 'package:flutter/material.dart';
import '../../../../../features/internal_services/internal_orders/custom_widget/row_number_coin_widget.dart';
import '../../../../../../../../core/theming/assets.dart';
import '../../../../../../../../core/language/language_constant.dart';
import '../../../../../../../../core/theming/colors.dart';
import '../../../../../../../../core/theming/fonts.dart';
import '../../../../../../../../core/theming/text_styles.dart';

class PriceCarWidget extends StatelessWidget {
  final String? price,text;
  final double? spacing;
  const PriceCarWidget({
    super.key,
    this.price,
    this.text,
    this.spacing
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      spacing:spacing?? 5,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        TextInAppWidget(
          text:text??AppLanguageKeys.carPrice,
          textSize: 13,
          fontWeightIndex: FontSelectionData.regularFontFamily,
          textColor:AppColors.greyColor,
        ),
        RowNumberCoinWidget(
            numberText:price?? '250',
            sizeText: 15,
            imageSrc: AppImageKeys.coin,
        )
      ],
    );
  }
}
