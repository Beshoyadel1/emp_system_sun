import 'package:flutter/material.dart';
import '../../../../../core/language/language_constant.dart';
import '../../../../../core/theming/colors.dart';
import '../../../../../core/theming/fonts.dart';
import '../../../../../core/pages_widgets/general_widgets/custom_container.dart';
import '../../../../../core/theming/text_styles.dart';
import 'employe_widget.dart';

class EmployeesPerformance extends StatelessWidget {
  const EmployeesPerformance({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomContainer(
        padding: const EdgeInsets.all(0),
        containerWidth: 280,
        borderRadius: BorderRadius.circular(20),
        isSelected: false,
        onTap: () {},
        typeWidget: const Padding(
          padding: EdgeInsets.all(10.0),
          child: Column(
            spacing: 10,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(
                height: 5,
              ),
              TextInAppWidget(
                text: AppLanguageKeys.topEmployeesKey,
                textSize: 14,
                fontWeightIndex: FontSelectionData.regularFontFamily,
              ),
              TextInAppWidget(
                text: AppLanguageKeys.topOrderReceiversKey,
                textSize: 10,
                fontWeightIndex: FontSelectionData.regularFontFamily,
                textColor: AppColors.darkGreyColor,
              ),
              const SizedBox(
                height: 5,
              ),
              EmployeWidget(),
              EmployeWidget(),
              EmployeWidget(),
              EmployeWidget(),
            ],
          ),
        ));
  }
}
