import 'package:emp_system_sun/features/internal_services/internal_orders/custom_widget/container_percentage.dart';
import 'package:emp_system_sun/features/internal_services/internal_orders/custom_widget/small_circle.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../../../../../../../../core/theming/colors.dart';
import '../../../../../../../../core/theming/fonts.dart';
import '../../../../../../../../core/theming/text_styles.dart';

class RowCircleColorTextPercentageWidget extends StatelessWidget {
  final Color colorCircle;
  final String text, percentage;

  const RowCircleColorTextPercentageWidget({
    super.key,
    required this.colorCircle,
    required this.text,
    required this.percentage,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      spacing: 10,
      children: [
        Flexible(
          child: Row(
            spacing: 5,
            children: [
              SmallCircle(
                color: colorCircle,
              ),
              Expanded(
                child: TextInAppWidget(
                  text: text,
                  textSize: 11,
                  fontWeightIndex: FontSelectionData.regularFontFamily,
                  textColor: AppColors.blackColor,
                ),
              ),
            ],
          ),
        ),
        ContainerPercentage(percentage: percentage)
      ],
    );
  }
}
