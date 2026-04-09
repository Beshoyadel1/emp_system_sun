import 'package:flutter/material.dart';
import '../../../../../core/language/language_constant.dart';
import '../../../../../core/theming/colors.dart';
import '../../../../../core/pages_widgets/general_widgets/custom_container.dart';
import '../../../../../core/theming/text_styles.dart';
import 'data_account_balance.dart';

class AccountBalance extends StatelessWidget {
  const AccountBalance({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomContainer(
        containerWidth: 375,
        containerHeight: 504,
        padding: const EdgeInsets.all(0),
        borderRadius: BorderRadius.circular(20),
        isSelected: false,
        onTap: () {},
        typeWidget: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            spacing: 10,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Column(
                    spacing: 10,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        height: 10,
                      ),
                      TextInAppWidget(
                          text: AppLanguageKeys.accountBalanceKey,
                          textSize: 18,
                          textColor: AppColors.darkColor),
                      TextInAppWidget(
                        text: AppLanguageKeys.priceKey,
                        textSize: 20,
                        textColor: AppColors.orangeColor,
                      ),
                    ],
                  ),
                  CustomContainer(
                    padding: const EdgeInsets.all(0),
                    containerWidth: 100,
                    containerHeight: 37,
                    typeWidget: const Center(
                        child: TextInAppWidget(
                      text: AppLanguageKeys.detailsKey,
                      textColor: AppColors.whiteColor,
                      textSize: 15,
                    )),
                    onTap: () {},
                    isSelected: false,
                    containerColor: AppColors.orangeColor,
                  )
                ],
              ),
              const SizedBox(
                height: 20,
              ),
              const DataAccountBalance(),
              const DataAccountBalance(),
              const DataAccountBalance(),
              const DataAccountBalance(),
            ],
          ),
        ));
  }
}
