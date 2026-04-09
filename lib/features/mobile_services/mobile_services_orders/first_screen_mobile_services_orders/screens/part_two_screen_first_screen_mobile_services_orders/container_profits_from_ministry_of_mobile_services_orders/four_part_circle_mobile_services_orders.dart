import 'package:flutter/material.dart';
import '../../../../../../../../core/api_functions/statistics/get_provider_main_service_statistics_model/sub_service_summaries_request.dart';
import '../../../../../../../../core/language/language_constant.dart';
import '../../../../../../../../core/theming/fonts.dart';
import '../../../../../../../../core/theming/text_styles.dart';
import '../../../../../../../../core/theming/colors.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class FourPartCircleMobileServicesOrders extends StatelessWidget {

  final List<SubServiceSummariesRequest> services;

  const FourPartCircleMobileServicesOrders({
    super.key,
    required this.services,
  });

  List<SubServiceSummariesRequest> get _sortedServices {
    final sorted = List<SubServiceSummariesRequest>.from(services);

    sorted.sort(
          (a, b) => (b.orderCount ?? 0).compareTo(a.orderCount ?? 0),
    );

    return sorted;
  }

  List<ChartData> get _chartData {

    if (services.isEmpty) {
      return [
        ChartData('', 1, AppColors.lightGreyColor),
      ];
    }

    return _sortedServices.asMap().entries.map((entry) {

      final index = entry.key;
      final service = entry.value;

      final title =
          service.serviceName ??
              service.serviceLatinName ??
              '';

      final double value =
      (service.orderCount ?? 0) == 0
          ? 0.2
          : (service.orderCount ?? 0).toDouble();

      return ChartData(
        title,
        value,
        legendColor(index),
      );

    }).toList();
  }

  int get _totalOrders {
    return services.fold<int>(
      0,
          (sum, s) => sum + (s.orderCount ?? 0),
    );
  }

  @override
  Widget build(BuildContext context) {

    return SizedBox(
      height: 170,
      child: SfCircularChart(
        margin: EdgeInsets.zero,
        annotations: [
          CircularChartAnnotation(
            widget: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextInAppWidget(
                  text: _totalOrders.toString(),
                  textSize: 15,
                  textColor: AppColors.blackColor,
                  fontWeightIndex: FontSelectionData.boldFontFamily,
                ),
                const TextInAppWidget(
                  text: AppLanguageKeys.ordersKey,
                  textSize: 12,
                  textColor: AppColors.blackColor,
                  fontWeightIndex: FontSelectionData.regularFontFamily,
                ),
              ],
            ),
          )
        ],
        series: <CircularSeries>[
          DoughnutSeries<ChartData, String>(
            dataSource: _chartData,
            xValueMapper: (d, _) => d.x,
            yValueMapper: (d, _) => d.y,
            pointColorMapper: (d, _) => d.color,
            innerRadius: '70%',
            strokeColor: AppColors.whiteColor,
            strokeWidth: 2,
            dataLabelSettings:
            const DataLabelSettings(isVisible: false),
          ),
        ],
      ),
    );
  }
}

class ChartData {

  ChartData(this.x, this.y, this.color);

  final String x;
  final double y;
  final Color color;
}

Color legendColor(int index) {
  const colors = [
    AppColors.brownColor,
    AppColors.lightBlueColor,
    AppColors.greenColor,
    AppColors.orangeColor,
    AppColors.purpleColor,
  ];
  return colors[index % colors.length];
}