import 'package:flutter/material.dart';
import '../../../../core/api_functions/statistics/get_provider_total_rate_and_employee_and_balance_model/get_provider_total_rate_and_employee_and_balance_model.dart';
import '../../../../../core/language/language_constant.dart';
import '../../../../../core/theming/assets.dart';
import '../../../../../core/theming/colors.dart';
import '../../../../../core/theming/fonts.dart';
import '../../../../../core/pages_widgets/general_widgets/custom_container.dart';
import '../../../../../core/theming/text_styles.dart';

class EmployeWidget extends StatelessWidget {
  final TopEmployee employee;

  const EmployeWidget({super.key, required this.employee});

  @override
  Widget build(BuildContext context) {
    return CustomContainer(
      containerHeight: 70,
      borderRadius: BorderRadius.circular(12),
      isSelected: false,
      onTap: () {},

      typeWidget: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8),
        child: Row(
          children: [
            /// 🔹 Avatar
            CircleAvatar(
              radius: 22,
              backgroundColor:
              AppColors.veryLightOrangeColor.withOpacity(0.3),
              child: Image.asset(
                AppImageKeys.profileImage,
                height: 20,
                width: 20,
              ),
            ),

            const SizedBox(width: 10),

            /// 🔹 Name + Job
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  TextInAppWidget(
                    text: employee.getName(context),
                    textSize: 13,
                    fontWeightIndex:
                    FontSelectionData.boldFontFamily,
                  ),
                  const SizedBox(height: 3),
                  TextInAppWidget(
                    text: employee.getJobName(context),
                    textSize: 11,
                    textColor: AppColors.darkGreyColor,
                  ),
                ],
              ),
            ),

            /// 🔹 Orders Count (Right side)
            Container(
              padding: const EdgeInsets.symmetric(
                  horizontal: 10, vertical: 6),
              decoration: BoxDecoration(
                color: AppColors.orangeColor.withOpacity(0.1),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Row(
                children: [
                  const Icon(
                    Icons.shopping_bag_outlined,
                    size: 14,
                    color: AppColors.orangeColor,
                  ),
                  const SizedBox(width: 4),
                  TextInAppWidget(
                    text: "${employee.orderCount ?? 0}",
                    textSize: 12,
                    textColor: AppColors.orangeColor,
                    fontWeightIndex:
                    FontSelectionData.boldFontFamily,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}