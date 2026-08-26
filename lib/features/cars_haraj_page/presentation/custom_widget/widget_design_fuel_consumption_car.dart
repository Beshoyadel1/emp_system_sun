import 'dart:math' as math;
import 'package:flutter/material.dart';
import '../../../../../../../core/pages_widgets/general_widgets/custom_container.dart';
import '../../../../../../../features/cars_haraj_page/data/model/get_car_details_model/get_car_details_model.dart';
import '../../../../../../../core/language/language_constant.dart';
import '../../../../../../../core/theming/colors.dart';
import '../../../../../../../core/theming/fonts.dart';
import '../../../../../../../core/theming/text_styles.dart';

class WidgetDesignFuelConsumptionCar extends StatelessWidget {
  final FuelConsumptionModel? fuelConsumption;
  final SummaryModel? summary;

  const WidgetDesignFuelConsumptionCar({
    super.key,
    required this.fuelConsumption,
    required this.summary,
  });

  @override
  Widget build(BuildContext context) {
    final percentage =
    (fuelConsumption?.consumptionPercentage ?? 0)
        .clamp(0, 100)
        .toDouble();

    return CustomContainer(
      onTap: (){},
      isSelected: false,
      typeWidget: Column(
        children: [
          const TextInAppWidget(
            text: AppLanguageKeys.fuelConsumptionRate,
            textSize: 17,
            fontWeightIndex:
            FontSelectionData.boldFontFamily,
            textColor: AppColors.blackColor,
          ),

          const SizedBox(height: 25),

          SizedBox(
            height: 170,
            width: 220,
            child: CustomPaint(
              painter: _FuelGaugePainter(
                percentage: percentage,
              ),
              child: Center(
                child: TextInAppWidget(
                  text: '${percentage.toStringAsFixed(0)}%',
                  textSize: 22,
                  fontWeightIndex:
                  FontSelectionData.boldFontFamily,
                  textColor: AppColors.greyColor,
                  textAlign: TextAlign.center,
                ),
              ),
            ),
          ),

          const SizedBox(height: 15),

          const _LegendItem(
            title: AppLanguageKeys.fuel,
            value: '100%',
            dotColor: Colors.grey,
          ),

          const SizedBox(height: 8),

          _LegendItem(
            title: AppLanguageKeys.consumptionSaving,
            value:
            '${percentage.toStringAsFixed(0)}%',
            dotColor: AppColors.orangeColor,
          ),

          const SizedBox(height: 25),

          _ValueRow(
            title: AppLanguageKeys.totalConsumption,
            value:
            '${fuelConsumption?.totalConsumption?.toStringAsFixed(2) ?? '0.00'} ر.س',
          ),

          const SizedBox(height: 12),

          _ValueRow(
            title: AppLanguageKeys.expectedSpend,
            value:
            '${fuelConsumption?.expectedSpend?.toStringAsFixed(2) ?? '0.00'} ر.س',
          ),
        ],
      ),
    );
  }
}

class _ValueRow extends StatelessWidget {
  final String title;
  final String value;

  const _ValueRow({
    required this.title,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        TextInAppWidget(
          text: title,
          textSize: 13,
          fontWeightIndex:
          FontSelectionData.mediumFontFamily,
          textColor: AppColors.greyColor,
          textAlign: TextAlign.right,
        ),

        const SizedBox(height: 5),

        TextInAppWidget(
          text: value,
          textSize: 18,
          fontWeightIndex:
          FontSelectionData.boldFontFamily,
          textColor: AppColors.orangeColor,
          textAlign: TextAlign.right,
        ),
      ],
    );
  }
}

class _LegendItem extends StatelessWidget {
  final String title;
  final String value;
  final Color dotColor;

  const _LegendItem({
    required this.title,
    required this.value,
    required this.dotColor,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: TextInAppWidget(
            text: title,
            textSize: 12,
          ),
        ),

        Container(
          width: 9,
          height: 9,
          decoration: BoxDecoration(
            color: dotColor,
            shape: BoxShape.circle,
          ),
        ),

        const SizedBox(width: 10),
        TextInAppWidget(
          text: value,
          textSize: 12,
          fontWeightIndex: FontSelectionData.regularFontFamily,

        ),
      ],
    );
  }
}

class _FuelGaugePainter extends CustomPainter {
  final double percentage;

  _FuelGaugePainter({
    required this.percentage,
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

    final radius =
        math.min(size.width, size.height) / 2 - 15;

    final rect = Rect.fromCircle(
      center: center,
      radius: radius,
    );

    // ==========================================================
    // BACKGROUND CIRCLE
    // ==========================================================

    final backgroundPaint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = 18
      ..strokeCap = StrokeCap.round
      ..color = Colors.grey.shade300;

    canvas.drawArc(
      rect,
      -math.pi / 2,
      math.pi * 2,
      false,
      backgroundPaint,
    );

    // ==========================================================
    // PROGRESS CIRCLE
    // ==========================================================

    final valuePaint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = 18
      ..strokeCap = StrokeCap.round
      ..color = AppColors.orangeColor;

    final valueAngle =
        (math.pi * 2) * (percentage / 100);

    canvas.drawArc(
      rect,
      -math.pi / 2,
      valueAngle,
      false,
      valuePaint,
    );
  }

  @override
  bool shouldRepaint(
      covariant _FuelGaugePainter oldDelegate,
      ) {
    return oldDelegate.percentage != percentage;
  }
}