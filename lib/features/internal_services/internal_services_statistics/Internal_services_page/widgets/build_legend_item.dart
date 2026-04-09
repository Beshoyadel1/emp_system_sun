import 'package:flutter/material.dart';
import '../../../../../features/cars_haraj_page/model/chart_data_model/chart_data_model.dart';
import '../../../../../core/theming/colors.dart';
import '../../../../../core/theming/fonts.dart';
import '../../../../../core/pages_widgets/general_widgets/custom_container.dart';
import '../../../../../core/theming/text_styles.dart';

class BuildLegendItem extends StatelessWidget {
  const BuildLegendItem({super.key, required this.item});

  final ChartDataModel item;

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 5,
      runSpacing: 5,
      crossAxisAlignment: WrapCrossAlignment.center,
      children: [
        Container(
          width: 12,
          height: 12,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: item.color,
          ),
        ),
        TextInAppWidget(
          text: item.label,
          textSize: 14,
          fontWeightIndex: FontSelectionData.regularFontFamily,
        ),
        CustomContainer(
          isSelected: false,
          onTap: () {},
          text: '${item.percentage}%',
          borderRadius: BorderRadius.circular(12),
          border: const Border(),
          containerColor: AppColors.veryLightGreyColor.withAlpha(100),
          textColor: AppColors.darkColor,
          padding: const EdgeInsets.all(0),
          containerWidth: 40,
          containerHeight: 24,
        ),
      ],
    );
  }
}
