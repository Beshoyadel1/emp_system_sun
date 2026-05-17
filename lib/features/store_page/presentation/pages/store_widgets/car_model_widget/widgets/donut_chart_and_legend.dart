import 'package:emp_system_sun/core/theming/colors.dart';
import 'package:emp_system_sun/features/cars_haraj_page/data/model/chart_data_model/chart_data_model.dart';
import 'package:emp_system_sun/features/cars_haraj_page/presentation/bloc/provider_harage_monthly_sales_cubit/provider_harage_monthly_sales_cubit.dart';
import 'package:emp_system_sun/features/cars_haraj_page/presentation/bloc/provider_harage_monthly_sales_cubit/provider_harage_monthly_sales_state.dart';
import 'package:emp_system_sun/features/internal_services/presentation/pages/internal_orders/custom_widget/text_empty_view_data.dart';
import 'package:emp_system_sun/features/internal_services/presentation/pages/internal_services_statistics/Internal_services_page/widgets/build_legend_item.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fl_chart/fl_chart.dart';



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
          if (data.isEmpty) {
            return const TextEmptyViewData();
          }
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
