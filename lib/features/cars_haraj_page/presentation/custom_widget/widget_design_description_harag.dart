import 'package:flutter/material.dart';
import '../../../../../../../core/language/language_constant.dart';
import '../../../../../../../core/pages_widgets/general_widgets/custom_container.dart';
import '../../../../../../../core/theming/colors.dart';
import '../../../../../../../core/theming/fonts.dart';
import '../../../../../../../core/theming/text_styles.dart';
import '../../../../../../../features/cars_haraj_page/data/model/get_all_harage_model/harage_data.dart';

class WidgetDesignDescriptionHarag extends StatelessWidget {
  const WidgetDesignDescriptionHarag({
    super.key,
    required this.harage,
  });

  final HarageData harage;

  @override
  Widget build(BuildContext context) {
    return CustomContainer(
      containerWidth: double.infinity,
      isSelected: false,
      onTap: () {},
      borderRadius: BorderRadius.circular(12),
      typeWidget: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const TextInAppWidget(
              text: AppLanguageKeys.description,
              textSize: 16,
              fontWeightIndex:
              FontSelectionData.mediumFontFamily,
              textColor: AppColors.darkColor,
            ),

            const SizedBox(height: 15),

            TextInAppWidget(
              text: harage.description?.isNotEmpty == true
                  ? harage.description!
                  : AppLanguageKeys.empty,
              textSize: 14,
              fontWeightIndex:
              FontSelectionData.regularFontFamily,
              textColor: AppColors.darkColor,
            ),
          ],
        ),
      ),
    );
  }
}