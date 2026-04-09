import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../../../../../../../features/internal_services/internal_orders/custom_widget/row_text_icon_orange.dart';
import '../../../../../../../core/theming/assets.dart';
import '../../../../../../../core/language/language_constant.dart';
import '../../../../../../../core/theming/colors.dart';
import '../../../../../../../core/theming/fonts.dart';
import '../../../../../../../core/theming/text_styles.dart';

class ColumnPriceOrderWidget extends StatelessWidget {
  final String price;
  final String? title;

  const ColumnPriceOrderWidget({super.key, required this.price,this.title});

  @override
  Widget build(BuildContext context) {
    return Column(
      spacing: 10,
      children: [
        TextInAppWidget(
          text: title??AppLanguageKeys.servicePrice,
          textSize: 11,
          fontWeightIndex: FontSelectionData.mediumFontFamily,
          textColor: AppColors.greyColor,
        ),
        RowTextIconOrange(text: price, imagePath: AppImageKeys.coin),
      ],
    );
  }
}
