import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import '../../../../../features/cars_haraj_page/widgets/bar_chart_data_widget.dart';
import '../../../../../core/language/language_constant.dart';
import '../../../../../core/theming/colors.dart';
import '../../../../../core/theming/fonts.dart';
import '../../../../../core/pages_widgets/general_widgets/custom_container.dart';
import '../../../../../core/theming/text_styles.dart';

class MonthlyBarChart extends StatelessWidget {
  const MonthlyBarChart({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomContainer(
      isSelected: false,
      onTap: () {},
      typeWidget: const Column(
        spacing: 10,
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
           TextInAppWidget(
            text: AppLanguageKeys.carMarketSales,
            textSize: 16,
            fontWeightIndex: FontSelectionData.regularFontFamily,
          ),
          //  TextInAppWidget(
          //   text: AppLanguageKeys.priceKey,
          //   textSize: 16,
          //   fontWeightIndex: FontSelectionData.regularFontFamily,
          //   textColor: AppColors.orangeColor,
          // ),
          BarChartDataWidget()
        ],
      ),
    );
  }
}
