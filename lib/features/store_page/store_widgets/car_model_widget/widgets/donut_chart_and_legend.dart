import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fl_chart/fl_chart.dart';
import '../../../../../../features/internal_services/internal_services_statistics/Internal_services_page/widgets/build_legend_item.dart';
import '../../../../../../../core/theming/colors.dart';
import '../../../../cars_haraj_page/logic/provider_harage_monthly_sales_cubit/provider_harage_monthly_sales_state.dart';
import '../../../../cars_haraj_page/logic/provider_harage_monthly_sales_cubit/provider_harage_monthly_sales_cubit.dart';
import '../../../../../../../features/cars_haraj_page/model/chart_data_model/chart_data_model.dart';

class DonutChartAndLegend extends StatelessWidget {
  const DonutChartAndLegend({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => ProviderHarageStatisticsCubit()
        ..loadStatistics(
        ),
      child: BlocBuilder<ProviderHarageStatisticsCubit, ProviderHarageStatisticsState>(
        builder: (context, state) {
          if (state is! ProviderHarageStatisticsSuccess) {
            return const SizedBox();
          }

          final List<ChartDataModel> data = mapSoldCarsToChartData(state.soldCarsByType);

          return Directionality(
            textDirection: TextDirection.rtl,
            child: Row(
              spacing: 15,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  height: 147,
                  width: 147,
                  child: AspectRatio(
                    aspectRatio: 1,
                    child: Stack(
                      alignment: Alignment.center,
                      children: [
                        Container(
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            border: Border.all(
                              color: AppColors.veryLightGreyColor,
                              width: 39,
                            ),
                          ),
                        ),
                        PieChart(
                          PieChartData(
                            sectionsSpace: 0,
                            centerSpaceRadius: 50,
                            startDegreeOffset: 270,
                            sections: data.map((item) {
                              return PieChartSectionData(
                                color: item.color,
                                value: item.percentage.toDouble(),
                                title: '',
                                radius: 12,
                              );
                            }).toList(),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Expanded(
                  child: Wrap(
                    spacing: 5,
                    runSpacing: 5,
                    children: data
                        .map((item) => BuildLegendItem(item: item))
                        .toList(),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
