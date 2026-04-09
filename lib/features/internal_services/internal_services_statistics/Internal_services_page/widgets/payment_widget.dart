import 'package:flutter/material.dart';
import '../../../../../core/language/language_constant.dart';
import '../../../../../core/theming/assets.dart';
import '../../../../../core/theming/colors.dart';
import '../../../../../core/pages_widgets/general_widgets/custom_container.dart';
import '../../../../../core/theming/text_styles.dart';

class PaymentWidget extends StatelessWidget {
  const PaymentWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomContainer(
      containerWidth: 438,
      padding: const EdgeInsets.all(16),
      border: const Border(),
      borderRadius: BorderRadius.circular(0),
      isSelected: false,
      onTap: () {},
      typeWidget: Column(
        spacing: 10,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const TextInAppWidget(
            text: AppLanguageKeys.invoiceKey,
            textSize: 18,
            textColor: AppColors.darkColor,
          ),
          const SizedBox(
            height: 10,
          ),
          const CustomRow(
              text: AppLanguageKeys.insuranceAgainKey, value: '1000'),
          const CustomRow(text: AppLanguageKeys.taxesKey, value: '1000'),
          const CustomRow(text: AppLanguageKeys.totalKey, value: '1000'),
          const CustomRow(
              text: AppLanguageKeys.insuranceAgainKey, value: '1000.00'),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const TextInAppWidget(
                text: AppLanguageKeys.paidByKey,
                textSize: 16,
                textColor: AppColors.darkColor,
              ),
              Image.asset(
                AppImageKeys.payIcon,
                width: 53,
                height: 21,
                fit: BoxFit.fill,
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class CustomRow extends StatelessWidget {
  const CustomRow({super.key, required this.text, required this.value});

  final String text;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            TextInAppWidget(
              text: text,
              textSize: 16,
              textColor: AppColors.darkColor,
            ),
            TextInAppWidget(
              text: value,
              textSize: 16,
              textColor: AppColors.orangeColor,
            ),
          ],
        ),
        const Divider(
          thickness: 1,
          color: AppColors.greyColor,
        ),
      ],
    );
  }
}
