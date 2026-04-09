import 'package:flutter/material.dart';
import '../../../../../core/language/language_constant.dart';
import '../../../../../core/theming/assets.dart';
import '../../../../../core/theming/colors.dart';
import '../../../../../core/pages_widgets/general_widgets/custom_container.dart';
import '../../../../../core/theming/text_styles.dart';
import 'name_worker_service.dart';
import 'order_date.dart';
import 'order_state.dart';
import 'service_price.dart';
import 'type_car.dart';

class NewOrderWidget extends StatelessWidget {
  const NewOrderWidget({super.key, this.spacing, required this.onTap});

  final double? spacing;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return CustomContainer(
      padding: const EdgeInsets.symmetric(vertical: 10),
      isSelected: false,
      onTap: () {},
      borderRadius: BorderRadius.circular(12),
      typeWidget: Center(
        child: Wrap(
          spacing: spacing ?? 4,
          crossAxisAlignment: WrapCrossAlignment.center,
          alignment: WrapAlignment.center,
          children: [
            const TextInAppWidget(text: '1#', textSize: 16, textColor: AppColors.darkColor),
            Image.asset(
              AppImageKeys.maintenance,
              width: 30,
              height: 30,
              fit: BoxFit.contain,
            ),
            const Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                TextInAppWidget(
                    text: AppLanguageKeys.maintenanceAndRepairTitleKey,
                    textSize: 14,
                    textColor: AppColors.orangeColor
                ),
                TextInAppWidget(
                    text: AppLanguageKeys.internalServicesKey,
                    textSize: 14,
                    textColor: AppColors.darkColor),
              ],
            ),
            const SizedBox(
              width: 10,
            ),
            const TypeCar(),
            const SizedBox(
              width: 10,
            ),
            const NameWorkerService(),
            const OrderState(),
            const SizedBox(
              width: 10,
            ),
            const OrderDate(),
            const SizedBox(
              width: 10,
            ),
            const ServicePrice(),
            CustomContainer(
              containerHeight: 32,
              containerWidth: 80,
              border: Border.all(color: AppColors.orangeColor),
              isSelected: true,
              onTap: onTap,
              padding: EdgeInsets.zero,
              typeWidget: const Center(
                child: TextInAppWidget(
                    text: AppLanguageKeys.detailsKey,
                    textSize: 14,
                    textColor: AppColors.orangeColor),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
