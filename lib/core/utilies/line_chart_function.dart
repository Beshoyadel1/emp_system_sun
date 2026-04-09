import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import '../../../core/theming/colors.dart';

LineChartData sampleData({
  required Color colorGradient1,
  required Color colorGradient2,
  required Color colorGradient3,
}) {
  return LineChartData(
    gridData: const FlGridData(show: false),
    titlesData: const FlTitlesData(show: false),
    borderData: FlBorderData(show: false),
    lineBarsData: [
      LineChartBarData(
        spots: const [
          FlSpot(0, 1.5),
          FlSpot(2, 4.5),
          FlSpot(4, 2.8),
          FlSpot(6, 5.2),
          FlSpot(8, 3.0),
          FlSpot(10, 4.0),
          FlSpot(12, 5.5),
        ],
        isCurved: true,
        color: AppColors.whiteColor,
        barWidth: 0,
        dotData: const FlDotData(show: false),
        belowBarData: BarAreaData(
          show: true,
          color: Colors.transparent,
          gradient: LinearGradient(
            colors: [
              colorGradient1,
              colorGradient2,
              colorGradient3,
            ],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
      ),
    ],
  );
}