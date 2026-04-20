import 'package:flutter/material.dart';
import '../../../../../features/internal_services/internal_services_statistics/Internal_services_page/widgets/order_date.dart';
import '../../../../../features/internal_services/internal_services_statistics/Internal_services_page/widgets/order_state.dart';
import '../../../../../core/language/language_constant.dart';

import '../../../../../core/theming/assets.dart';
import '../../../../../core/theming/colors.dart';
import '../../../../../core/pages_widgets/general_widgets/custom_container.dart';
import '../../../../../core/theming/text_styles.dart';
import 'car_model.dart';
import 'message_numbers.dart';

class ContainerDetails extends StatelessWidget {
  const ContainerDetails({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomContainer(
      containerWidth: 870,
      isSelected: false,
      onTap: () {},
      typeWidget: Padding(
        padding: const EdgeInsets.symmetric(vertical: 56.0),
        child: Wrap(
          spacing: 40,
          runSpacing: 20,
          children: [
            SizedBox(
              width: 700,
              child: Wrap(
                spacing: 90,
                runSpacing: 30,
                children: [
                  const CarModel(),
                  const OrderDate(),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      const TextInAppWidget(
                          text: 'نوع الناقل',
                          textSize: 14,
                          textColor: AppColors.darkGreyColor),
                      Wrap(
                        children: [
                          Image.asset(
                            AppImageKeys.gaz,
                            width: 21,
                            height: 21,
                            fit: BoxFit.contain,
                          ),
                          const TextInAppWidget(text: 'بنزين')
                        ],
                      ),
                    ],
                  ),
                  const MessageNumbers(),
                  const OrderState(),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Image.asset(
                        AppImageKeys.nesan,
                        width: 21,
                        height: 21,
                        fit: BoxFit.contain,
                      ),
                      const TextInAppWidget(
                          text: 'نيسان',
                          textSize: 14,
                          textColor: AppColors.darkColor),
                    ],
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      const TextInAppWidget(
                          text: 'نوع الوقود',
                          textSize: 14,
                          textColor: AppColors.darkGreyColor),
                      Wrap(
                        spacing: 5,
                        children: [
                          Image.asset(
                            AppImageKeys.auto,
                            width: 21,
                            height: 21,
                            fit: BoxFit.contain,
                          ),
                          const TextInAppWidget(text: 'أتوماتيك')
                        ],
                      ),
                    ],
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      const TextInAppWidget(
                          text: 'عداد السرعة',
                          textSize: 14,
                          textColor: AppColors.darkGreyColor),
                      Wrap(
                        spacing: 5,
                        children: [
                          Image.asset(
                            AppImageKeys.speed,
                            width: 21,
                            height: 21,
                            fit: BoxFit.contain,
                          ),
                          const TextInAppWidget(text: '50 KM')
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ),
            const Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                TextInAppWidget(
                    text: 'سعر السيارة ',
                    textSize: 14,
                    textColor: AppColors.darkGreyColor),
                TextInAppWidget(
                    text: AppLanguageKeys.priceKey,
                    textSize: 14,
                    textColor: AppColors.darkColor),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
