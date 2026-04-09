import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fl_chart/fl_chart.dart';
import '../logic/provider_harage_monthly_sales_cubit/provider_harage_monthly_sales_cubit.dart';
import '../logic/provider_harage_monthly_sales_cubit/provider_harage_monthly_sales_state.dart';
import '../../../../../core/theming/colors.dart';
import '../../../../../core/api_functions/statistics/get_provider_harage_sales_chart_model/harag_data_points_model.dart';

class AspectRatioWidget extends StatelessWidget {
  const AspectRatioWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 2.4,

      child: BlocBuilder<
          ProviderHarageStatisticsCubit,
          ProviderHarageStatisticsState>(
        builder: (context, state) {
          if (state is ProviderHarageStatisticsLoading) {
            return const Center(child: CircularProgressIndicator());
          }

          if (state is ProviderHarageStatisticsSuccess) {
            final data = state.chartData;

            return LineChart(
              _buildLineChartData(data),
            );
          }

          return const SizedBox();
        },
      ),
    );
  }
}

/* ====================== LINE CHART DATA ====================== */

LineChartData _buildLineChartData(
    List<HaragDataPointsModel> data,
    ) {
  final maxValue =
  data.map((e) => e.value).fold<num>(0, (a, b) => a > b ? a : b);

  return LineChartData(
    minX: 0,
    maxX: (data.length - 1).toDouble(),
    minY: 0,
    maxY: maxValue == 0 ? 5 : maxValue.toDouble() + 1,

    gridData: _buildGridData(),
    borderData: _buildBorderData(),
    titlesData: _buildTitles(data),

    lineBarsData: [
      LineChartBarData(
        spots: _buildSpots(data),
        isCurved: false,
        barWidth: 2,
        color: AppColors.orangeColor,

        dotData: FlDotData(
          show: true,
          getDotPainter: (spot, percent, barData, index) {
            return FlDotCirclePainter(
              radius: 3,
              color: AppColors.orangeColor,
              strokeWidth: 1,
              strokeColor: AppColors.whiteColor,
            );
          },
        ),

        belowBarData: BarAreaData(show: false),
      ),
    ],
  );
}

/* ====================== SPOTS ====================== */

List<FlSpot> _buildSpots(List<HaragDataPointsModel> data) {
  return List.generate(
    data.length,
        (index) => FlSpot(
      index.toDouble(),
      data[index].value.toDouble(),
    ),
  );
}
/* ====================== TITLES ====================== */
FlTitlesData _buildTitles(List<HaragDataPointsModel> data) {
  final interval = (data.length / 6).ceilToDouble();
  return FlTitlesData(
    leftTitles: AxisTitles(
      sideTitles: SideTitles(
        showTitles: true,
        interval: 1,
        reservedSize: 36,
        getTitlesWidget: (value, meta) {
          return Text(
            value.toInt().toString(),
            style: const TextStyle(fontSize: 10),
          );
        },
      ),
    ),
    bottomTitles: AxisTitles(
      sideTitles: SideTitles(
        showTitles: true,
        interval: interval,
        getTitlesWidget: (value, meta) {
          final index = value.toInt();
          if (index < 0 || index >= data.length) {
            return const SizedBox();
          }

          return Padding(
            padding: const EdgeInsets.only(top: 6),
            child: Text(
              data[index].label,
              style: const TextStyle(
                fontSize: 9,
                color: AppColors.blackColor,
              ),
            ),
          );
        },
      ),
    ),

    topTitles:
    const AxisTitles(sideTitles: SideTitles(showTitles: false)),
    rightTitles:
    const AxisTitles(sideTitles: SideTitles(showTitles: false)),
  );
}
/* ====================== GRID ====================== */
FlGridData _buildGridData() {
  return FlGridData(
    show: true,
    horizontalInterval: 1,
    drawVerticalLine: false,
    getDrawingHorizontalLine: (value) => FlLine(
      color: AppColors.greyColor.withOpacity(0.15),
      strokeWidth: 1,
    ),
  );
}
/* ====================== BORDER ====================== */
FlBorderData _buildBorderData() {
  return FlBorderData(
    show: true,
    border: Border(
      left: BorderSide(
        color: AppColors.greyColor.withOpacity(0.4),
      ),
      bottom: BorderSide(
        color: AppColors.greyColor.withOpacity(0.4),
      ),
    ),
  );
}