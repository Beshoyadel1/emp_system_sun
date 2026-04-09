import 'package:flutter/material.dart';
import '../../../../../core/language/language_constant.dart';
import '../../../../../core/theming/colors.dart';
import '../../../../../core/pages_widgets/general_widgets/custom_container.dart';
import '../../../../../core/theming/text_styles.dart';
import 'new_order_widget.dart';

class NewOrders extends StatelessWidget {
  const NewOrders({super.key});

  @override
  Widget build(BuildContext context) {
    bool isMobile = MediaQuery.of(context).size.width < 600;

    return CustomContainer(
      containerWidth: isMobile ? double.infinity : 860,
      isSelected: false,
      onTap: () {},
      typeWidget: Column(
        spacing: 10,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: double.infinity,
            child: Wrap(
              alignment: WrapAlignment.spaceBetween,
              runAlignment: WrapAlignment.spaceBetween,
              crossAxisAlignment: WrapCrossAlignment.start,
              children: [
                const Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    TextInAppWidget(
                      text: AppLanguageKeys.newOrdersKey,
                      textSize: 20,
                      textColor: AppColors.darkColor,
                    ),
                    TextInAppWidget(
                      text: AppLanguageKeys.newOrdersFromServicesKey,
                      textSize: 16,
                      textColor: AppColors.darkGreyColor,
                    ),
                  ],
                ),
                CustomContainer(
                  containerHeight: 37,
                  containerWidth: 129,
                  isSelected: true,
                  onTap: () {},
                  containerColor: AppColors.orangeColor,
                  padding: EdgeInsets.zero,
                  typeWidget: const Center(
                    child: TextInAppWidget(
                      text: AppLanguageKeys.viewAllKey,
                      textSize: 16,
                      textColor: AppColors.whiteColor,
                    ),
                  ),
                ),
              ],
            ),
          ),
          ...List.generate(
              4,
              (_) => NewOrderWidget(
                    onTap: () {},
                  )),
        ],
      ),
    );
  }
}
