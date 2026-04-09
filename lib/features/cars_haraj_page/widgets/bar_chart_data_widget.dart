import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/cupertino.dart';
import '../../../../core/api_functions/statistics/get_provider_harage_monthly_sales_model/harag_monthly_sale_model.dart';
import '../logic/provider_harage_monthly_sales_cubit/provider_harage_monthly_sales_cubit.dart';
import '../logic/provider_harage_monthly_sales_cubit/provider_harage_monthly_sales_state.dart';
import '../../../../../core/theming/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class BarChartDataWidget extends StatelessWidget {
  const BarChartDataWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 178,
      child: BlocBuilder<ProviderHarageStatisticsCubit,
          ProviderHarageStatisticsState>(
        builder: (context, state) {
          if (state is ProviderHarageStatisticsSuccess) {
            final sales = state.monthlySales;
            return BarChart(
              BarChartData(
                alignment: BarChartAlignment.spaceAround,
                maxY: _calculateMaxY(sales),
                gridData: const FlGridData(show: false),
                borderData: FlBorderData(show: false),
                titlesData: _buildTitles(sales),
                barGroups: _buildBarGroups(sales),
              ),
            );
          }
          return const SizedBox();
        },
      )
    );
  }
}
double _calculateMaxY(List<HaragMonthlySaleModel> sales) {
  final maxValue = sales
      .map((e) => e.value)
      .fold<num>(0, (a, b) => a > b ? a : b);

  return maxValue == 0 ? 5 : maxValue.toDouble() + 1;
}

FlTitlesData _buildTitles(List<HaragMonthlySaleModel> sales) {
  return FlTitlesData(
    leftTitles: AxisTitles(
      sideTitles: SideTitles(
        showTitles: true,
        reservedSize: 36,
        interval: 1,
        getTitlesWidget: (value, meta) {
          if (value == 0) return const SizedBox();
          return Text(
            '${value.toInt()}',
            style: const TextStyle(fontSize: 10),
          );
        },
      ),
    ),
    bottomTitles: AxisTitles(
      sideTitles: SideTitles(
        showTitles: true,
        interval: 1,
        getTitlesWidget: (value, meta) {
          final index = value.toInt();
          if (index < 0 || index >= sales.length) {
            return const SizedBox();
          }
          return Padding(
            padding: const EdgeInsets.only(top: 6),
            child: Text(
              sales[index].label,
              style: const TextStyle(fontSize: 10),
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
List<BarChartGroupData> _buildBarGroups(
    List<HaragMonthlySaleModel> sales) {
  return List.generate(sales.length, (index) {
    return BarChartGroupData(
      x: index,
      barRods: [
        BarChartRodData(
          toY: sales[index].value.toDouble(),
          width: 18,
          borderRadius: BorderRadius.circular(6),
          gradient: const LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              AppColors.orangeColor,
              AppColors.darkorangeColor,
              AppColors.secondaryColor,
            ],
          ),
        ),
      ],
    );
  });
}
