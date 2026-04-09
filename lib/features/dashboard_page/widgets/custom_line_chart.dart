import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import '../../../../../features/dashboard_page/model/chart_model/chart_model.dart';
import '../../../../../core/theming/colors.dart';
import '../../../../../core/theming/formate.dart';
import 'functions_chart.dart';

class CustomLineChart extends StatefulWidget {
  const CustomLineChart({super.key});

  @override
  _CustomLineChartState createState() => _CustomLineChartState();
}

class _CustomLineChartState extends State<CustomLineChart> {
  double? touchedSpotX;

  final List<ChartModel> data = sampleData;
  late final ChartModel peakPoint = sampleData.firstWhere(
    (e) => e.date.month == 9 && e.date.day == 22,
    orElse: () => sampleData.last,
  );

  final GlobalKey _chartKey = GlobalKey();
  OverlayEntry? overlayEntry;

  @override
  void dispose() {
    removeOverlay();
    super.dispose();
  }

  late final minX = data.first.date.millisecondsSinceEpoch.toDouble();
  late final maxX = data.last.date.millisecondsSinceEpoch.toDouble();
  static const minY = 10000.0;
  static const maxY = 50000.0;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      key: _chartKey,
      width: 500,
      height: 300,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: AspectRatio(
          aspectRatio: 1.7,
          child: LineChart(
            LineChartData(
              minX: minX,
              maxX: maxX,
              minY: minY,
              maxY: maxY,
              titlesData: FlTitlesData(
                show: true,
                bottomTitles: AxisTitles(
                  sideTitles: SideTitles(
                    showTitles: true,
                    reservedSize: 60,
                    interval: (maxX - minX) / 4,
                    getTitlesWidget: (value, meta) {
                      final date =
                          DateTime.fromMillisecondsSinceEpoch(value.toInt());
                      final formattedDate =
                          '${getMonthName(date.month)} ${date.year}';
                      return Padding(
                        padding: const EdgeInsets.only(top: 42.0),
                        child: Text(
                          formattedDate,
                          style:
                              const TextStyle(fontSize: 10, color: Colors.grey),
                        ),
                      );
                    },
                  ),
                ),
                leftTitles: AxisTitles(
                  sideTitles: SideTitles(
                    showTitles: true,
                    reservedSize: 40,
                    interval: 10000,
                    getTitlesWidget: (value, meta) {
                      return Text(
                        value.toInt().toString(),
                        style:
                            const TextStyle(fontSize: 10, color: Colors.grey),
                      );
                    },
                  ),
                ),
                rightTitles: const AxisTitles(
                  sideTitles: SideTitles(showTitles: false),
                ),
                topTitles: const AxisTitles(
                  sideTitles: SideTitles(showTitles: false),
                ),
              ),
              gridData: FlGridData(
                show: true,
                drawVerticalLine: false,
                getDrawingHorizontalLine: (value) {
                  if (value % 10000 == 0) {
                    return const FlLine(
                      color: Color(0xFFE0E0E0),
                      strokeWidth: 1,
                      dashArray: [5, 5],
                    );
                  }
                  return const FlLine(strokeWidth: 0);
                },
              ),
              borderData: FlBorderData(show: false),
              lineBarsData: [
                LineChartBarData(
                  spots: data
                      .map((point) => FlSpot(
                          point.date.millisecondsSinceEpoch.toDouble(),
                          point.value))
                      .toList(),
                  isCurved: true,
                  color: const Color(0xFF4DB6AC),
                  barWidth: 2,
                  isStrokeCapRound: true,
                  dotData: FlDotData(
                    show: true,
                    getDotPainter: (spot, percent, barData, index) {
                      if (touchedSpotX != null && spot.x == touchedSpotX) {
                        return FlDotCirclePainter(
                          radius: 6,
                          color: AppColors.seaBlueColor,
                          strokeColor: AppColors.seaBlueColor,
                          strokeWidth: 1,
                        );
                      }
                      return FlDotCirclePainter(
                        radius: 0,
                        color: Colors.transparent,
                      );
                    },
                  ),
                  belowBarData: BarAreaData(
                    show: true,
                    gradient: LinearGradient(
                      colors: [
                        AppColors.seaBlueColor.withAlpha(100),
                        AppColors.seaBlueColor.withAlpha(0),
                      ],
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                    ),
                  ),
                ),
              ],
              extraLinesData: ExtraLinesData(
                verticalLines: [
                  VerticalLine(
                    x: peakPoint.date.millisecondsSinceEpoch.toDouble(),
                    color: Colors.transparent,
                    strokeWidth: 1,
                  ),
                ],
              ),
              lineTouchData: LineTouchData(
                enabled: true,
                handleBuiltInTouches: false,
                touchCallback:
                    (FlTouchEvent event, LineTouchResponse? response) {
                  final spots = response?.lineBarSpots;
                  if (spots == null || spots.isEmpty) {
                    setState(() => touchedSpotX = null);
                    removeOverlay();
                    return;
                  }

                  final touchedSpot = spots.first;
                  setState(() => touchedSpotX = touchedSpot.x);

                  final localPos = event.localPosition;
                  if (localPos == null) {
                    removeOverlay();
                    return;
                  }

                  final renderBox = _chartKey.currentContext?.findRenderObject()
                      as RenderBox?;
                  if (renderBox == null) return;
                  final global = renderBox.localToGlobal(localPos);

                  showTooltipOverlay(context, global, touchedSpot);
                },
              ),
            ),
          ),
        ),
      ),
    );
  }
}
