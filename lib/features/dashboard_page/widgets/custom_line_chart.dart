import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import '../../../../features/dashboard_page/logic/get_provider_orders_sales_cubit/get_provider_orders_sales_cubit.dart';
import '../../../../features/dashboard_page/logic/get_provider_orders_sales_cubit/get_provider_orders_sales_state.dart';
import '../../../../../core/theming/colors.dart';
import '../../../../../core/theming/formate.dart';
import 'functions_chart.dart';
import 'package:flutter_bloc/flutter_bloc.dart';


class CustomLineChart extends StatefulWidget {
  const CustomLineChart({super.key});

  @override
  _CustomLineChartState createState() => _CustomLineChartState();
}

class _CustomLineChartState extends State<CustomLineChart> {
  double? touchedSpotX;

  final GlobalKey _chartKey = GlobalKey();
  OverlayEntry? overlayEntry;

  @override
  void dispose() {
    removeOverlay();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<GetProviderOrdersSalesCubit,
        GetProviderOrdersSalesState>(
      builder: (context, state) {

        if (state is GetProviderOrdersSalesLoading) {
          return const SizedBox(
            height: 300,
            child: Center(child: CircularProgressIndicator()),
          );
        }

        if (state is GetProviderOrdersSalesError) {
          return SizedBox(
            height: 300,
            child: Center(child: Text(state.message)),
          );
        }

        /// 🟢 Success
        if (state is GetProviderOrdersSalesSuccess) {
          final data = state.data.dataPoints;

          if (data.isEmpty) {
            return const SizedBox(
              height: 300,
              child: Center(child: Text("No Data")),
            );
          }

          /// 🔥 تحويل نفس التصميم
          final spots = data
              .map((point) => FlSpot(
            point.date.millisecondsSinceEpoch.toDouble(),
            point.value ?? 0,
          ))
              .toList();

          final minX = spots.first.x;
          final maxX = spots.last.x;

          final minY = 0.0;
          final maxY = data
              .map((e) => e.value ?? 0)
              .reduce((a, b) => a > b ? a : b) +
              10;

          final peakPoint = data.reduce((a, b) =>
          (a.value ?? 0) > (b.value ?? 0) ? a : b);

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
                            final date = DateTime
                                .fromMillisecondsSinceEpoch(
                                value.toInt());
                            final formattedDate =
                                '${getMonthName(date.month)} ${date.year}';

                            return Padding(
                              padding: const EdgeInsets.only(top: 42.0),
                              child: Text(
                                formattedDate,
                                style: const TextStyle(
                                    fontSize: 10, color: Colors.grey),
                              ),
                            );
                          },
                        ),
                      ),
                      leftTitles: AxisTitles(
                        sideTitles: SideTitles(
                          showTitles: true,
                          reservedSize: 40,
                          interval: maxY / 5,
                          getTitlesWidget: (value, meta) {
                            return Text(
                              value.toInt().toString(),
                              style: const TextStyle(
                                  fontSize: 10, color: Colors.grey),
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
                        return const FlLine(
                          color: Color(0xFFE0E0E0),
                          strokeWidth: 1,
                          dashArray: [5, 5],
                        );
                      },
                    ),

                    borderData: FlBorderData(show: false),

                    lineBarsData: [
                      LineChartBarData(
                        spots: spots,
                        isCurved: true,
                        color: const Color(0xFF4DB6AC),
                        barWidth: 2,
                        isStrokeCapRound: true,

                        dotData: FlDotData(
                          show: true,
                          getDotPainter:
                              (spot, percent, barData, index) {
                            if (touchedSpotX != null &&
                                spot.x == touchedSpotX) {
                              return FlDotCirclePainter(
                                radius: 6,
                                color: AppColors.seaBlueColor,
                                strokeColor:
                                AppColors.seaBlueColor,
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
                              AppColors.seaBlueColor
                                  .withAlpha(100),
                              AppColors.seaBlueColor
                                  .withAlpha(0),
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
                          x: peakPoint.date
                              .millisecondsSinceEpoch
                              .toDouble(),
                          color: Colors.transparent,
                          strokeWidth: 1,
                        ),
                      ],
                    ),

                    lineTouchData: LineTouchData(
                      enabled: true,
                      handleBuiltInTouches: false,
                      touchCallback: (event, response) {
                        if (!event.isInterestedForInteractions) {
                          setState(() => touchedSpotX = null);
                          removeOverlay();
                          return;
                        }

                        final spots = response?.lineBarSpots;
                        if (spots == null || spots.isEmpty) {
                          setState(() => touchedSpotX = null);
                          removeOverlay();
                          return;
                        }

                        final touchedSpot = spots.first;

                        setState(() => touchedSpotX = touchedSpot.x);

                        final renderBox =
                        _chartKey.currentContext?.findRenderObject() as RenderBox?;

                        if (renderBox == null) return;

                        final global = renderBox.localToGlobal(event.localPosition!);

                        showTooltipOverlay(context, global, touchedSpot);
                      },
                    ),
                  ),
                ),
              ),
            ),
          );
        }

        return const SizedBox();
      },
    );
  }
}