import 'package:flutter/material.dart';
import '../../../../../core/language/language_constant.dart';
import '../../../../../core/theming/assets.dart';
import '../../../../../core/theming/colors.dart';
import '../../../../../core/pages_widgets/text_form_field_widget.dart';
import '../../../../../core/pages_widgets/general_widgets/custom_container.dart';
import '../../../../../core/theming/text_styles.dart';
import 'name_worker_service.dart';
import 'order_date.dart';
import 'order_state.dart';
import 'service_price.dart';
import 'type_car.dart';

class DetailsOrder extends StatelessWidget {
  const DetailsOrder({super.key, required this.isProcessingRequest});

  final bool? isProcessingRequest;

  @override
  Widget build(BuildContext context) {
    return CustomContainer(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 50),
        containerWidth: 940,
        isSelected: false,
        onTap: () {},
        borderRadius: BorderRadius.circular(10),
        typeWidget: Wrap(
          spacing: 5,
          runSpacing: 1,
          children: [
            SizedBox(
              width: 610,
              child: Wrap(
                  spacing: 5,
                  runSpacing: 35,
                  crossAxisAlignment: WrapCrossAlignment.start,
                  alignment: WrapAlignment.start,
                  children: [
                    Image.asset(
                      AppImageKeys.maintenance,
                      width: 30,
                      height: 30,
                      fit: BoxFit.contain,
                    ),
                    const Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        TextInAppWidget(
                            text: AppLanguageKeys.internalServicesKey,
                            textSize: 14,
                            textColor: AppColors.orangeColor),
                        TextInAppWidget(
                            text: AppLanguageKeys.maintenanceAndRepairTitleKey,
                            textSize: 14,
                            textColor: AppColors.darkColor),
                      ],
                    ),
                    const SizedBox(
                      width: 30,
                    ),
                    const OrderState(),
                    const SizedBox(
                      width: 30,
                    ),
                    const OrderDate(),
                    const SizedBox(
                      width: 30,
                    ),
                    const ServicePrice(),
                    const SizedBox(
                      width: 30,
                    ),
                    const TypeCar(),
                    const SizedBox(
                      width: 30,
                    ),
                    Image.asset(
                      AppImageKeys.profileImage,
                      width: 41,
                      height: 41,
                      fit: BoxFit.contain,
                    ),
                    const TextInAppWidget(
                        text: AppLanguageKeys.clientNameKey,
                        textSize: 14,
                        textColor: AppColors.darkColor),
                    const SizedBox(
                      width: 30,
                    ),
                    const OrderDate(text: AppLanguageKeys.expectedEndDateKey),
                    if (isProcessingRequest == true)
                      const SizedBox(
                        width: 30,
                      ),
                    if (isProcessingRequest == true) const NameWorkerService(),
                  ]),
            ),
            SizedBox(
              width: 283,
              child: TextFormFieldWidget(
                borderColor: AppColors.lightGreyColor,
                maxLines: 5,
                contentPadding: const EdgeInsets.all(0),
                textFormController: TextEditingController(),
                fillColor: AppColors.whiteColor,
                text: AppLanguageKeys.notesKey,
                isColumn: true,
              ),
            ),
          ],
        ));
  }
}
