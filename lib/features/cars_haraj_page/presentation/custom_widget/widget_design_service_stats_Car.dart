import 'dart:math' as math;
import 'package:flutter/material.dart';
import '../../../../../../../core/language/language_constant.dart';
import '../../../../../../../core/pages_widgets/general_widgets/custom_container.dart';
import '../../../../../../../core/theming/colors.dart';
import '../../../../../../../core/theming/fonts.dart';
import '../../../../../../../core/theming/text_styles.dart';
import '../../../../../../../features/cars_haraj_page/data/model/get_car_details_model/get_car_details_model.dart';

class WidgetDesignServiceStatsCar extends StatelessWidget {
  final List<ServiceStatsModel> serviceStats;
  final SummaryModel? summary;

  const WidgetDesignServiceStatsCar({
    super.key,
    required this.serviceStats,
    required this.summary,
  });

  @override
  Widget build(BuildContext context) {
    return  CustomContainer(
      onTap: (){},
      isSelected: false,
      typeWidget: Column(
        children: [
          const  TextInAppWidget(
            text: AppLanguageKeys.carServicesStatistics,
            textSize: 17,
            fontWeightIndex:
            FontSelectionData.boldFontFamily,
            textColor: AppColors.blackColor,
          ),

          const SizedBox(height: 20),

          SizedBox(
            height: 190,
            width: 190,
            child: CustomPaint(
              painter: _ServiceDonutPainter(
                serviceStats: serviceStats,
              ),
              child: Center(
                child: Column(
                  mainAxisAlignment:
                  MainAxisAlignment.center,
                  children: [
                    const TextInAppWidget(
                      text: AppLanguageKeys.totalInvoices,
                      textSize: 12,
                      fontWeightIndex:
                      FontSelectionData.regularFontFamily,
                      textColor: AppColors.greyColor,
                    ),

                    const SizedBox(height: 5),

                    TextInAppWidget(
                      text:
                      '${summary?.totalInvoices?.toStringAsFixed(2) ?? '0.00'} ر.س',
                      textSize: 18,
                      fontWeightIndex:
                      FontSelectionData.boldFontFamily,
                      textColor: AppColors.orangeColor,
                    ),
                  ],
                ),
              ),
            ),
          ),

          const SizedBox(height: 20),

          ...serviceStats.map(
                (service) => _ServiceItem(
              service: service,
            ),
          ),
        ],
      ),
    );
  }
}

class _ServiceItem extends StatelessWidget {
  final ServiceStatsModel service;

  const _ServiceItem({
    required this.service,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: Row(
        children: [
          Expanded(
            child: TextInAppWidget(
              text: service.serviceName ?? '-',
              textSize: 12,
              fontWeightIndex:
              FontSelectionData.regularFontFamily,
              textColor: AppColors.blackColor,
              textAlign: TextAlign.right,
            ),
          ),

          const SizedBox(width: 8),

          Container(
            width: 10,
            height: 10,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: _getColor(
                service.percentage,
              ),
            ),
          ),

          const SizedBox(width: 10),

          SizedBox(
            width: 60,
            child: TextInAppWidget(
              text: service.value?.toStringAsFixed(0) ?? '0',
              textSize: 12,
              fontWeightIndex:
              FontSelectionData.regularFontFamily,
              textColor: AppColors.blackColor,
              textAlign: TextAlign.left,
            ),
          ),
        ],
      ),
    );
  }

  Color _getColor(double? percentage) {
    final value = percentage ?? 0;

    if (value >= 50) {
      return AppColors.orangeColor;
    }

    if (value >= 25) {
      return const Color(0xFF2296A6);
    }

    return const Color(0xFF9DDDE0);
  }
}

class _ServiceDonutPainter extends CustomPainter {
  final List<ServiceStatsModel> serviceStats;

  _ServiceDonutPainter({
    required this.serviceStats,
  });

  @override
  void paint(
      Canvas canvas,
      Size size,
      ) {
    final center = Offset(
      size.width / 2,
      size.height / 2,
    );

    final radius = math.min(
      size.width,
      size.height,
    ) /
        2 -
        10;

    final rect = Rect.fromCircle(
      center: center,
      radius: radius,
    );

    const strokeWidth = 18.0;

    double startAngle = -math.pi / 2;

    for (final service in serviceStats) {
      final percentage =
          (service.percentage ?? 0) / 100;

      final sweepAngle =
          math.pi * 2 * percentage;

      final paint = Paint()
        ..style = PaintingStyle.stroke
        ..strokeWidth = strokeWidth
        ..strokeCap = StrokeCap.round
        ..color = _getServiceColor(
          service.percentage ?? 0,
        );

      canvas.drawArc(
        rect,
        startAngle,
        sweepAngle - 0.05,
        false,
        paint,
      );

      startAngle += sweepAngle;
    }
  }

  Color _getServiceColor(
      double percentage,
      ) {
    if (percentage >= 50) {
      return const Color(0xFFFF641E);
    }

    if (percentage >= 25) {
      return const Color(0xFF2296A6);
    }

    return const Color(0xFF9DDDE0);
  }

  @override
  bool shouldRepaint(
      covariant _ServiceDonutPainter oldDelegate,
      ) {
    return oldDelegate.serviceStats != serviceStats;
  }
}