import 'package:flutter/material.dart';
import '../../../../../core/language/language_constant.dart';
import '../../../../../core/theming/fonts.dart';
import '../../../../../core/pages_widgets/general_widgets/custom_container.dart';
import '../../../../../core/theming/text_styles.dart';
import '../../store_page/store_widgets/car_model_widget/widgets/donut_chart_and_legend.dart';
import '../../store_page/store_widgets/car_model_widget/widgets/select_date_widget.dart';

class ServicesStatistics extends StatelessWidget {
  const ServicesStatistics({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomContainer(
      containerWidth: 500,
      isSelected: false,
      onTap: () {},
      typeWidget: const Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          TextInAppWidget(
            text: AppLanguageKeys.internalServicesStatsKey,
            textSize: 16,
            fontWeightIndex: FontSelectionData.regularFontFamily,
          ),
          //SelectDateWidget(),
          SizedBox(
            height: 30,
          ),
          DonutChartAndLegend(),
          SizedBox(
            height: 20,
          ),
        ],
      ),
    );
  }
}
