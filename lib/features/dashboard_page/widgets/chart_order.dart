import 'package:flutter/material.dart';
import '../../../../../core/language/language_constant.dart';
import '../../../../../core/theming/fonts.dart';
import '../../../../../core/pages_widgets/general_widgets/custom_container.dart';
import '../../../../../core/theming/text_styles.dart';
import '../../store_page/store_widgets/car_model_widget/widgets/select_date_widget.dart';
import 'custom_line_chart.dart';

class ChartOrder extends StatelessWidget {
  const ChartOrder({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomContainer(
        containerWidth: 570,
        containerHeight: 504,
        isSelected: false,
        onTap: () {},
        typeWidget: const Column(
          spacing: 60,
          children: [
            Padding(
              padding: EdgeInsets.only(top: 18.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  TextInAppWidget(
                    text: AppLanguageKeys.ordersKey,
                    textSize: 16,
                    fontWeightIndex: FontSelectionData.regularFontFamily,
                  ),
                  SizedBox(width: 300, child: SelectDateWidget()),
                ],
              ),
            ),
            CustomLineChart(),
          ],
        ));
  }
}
