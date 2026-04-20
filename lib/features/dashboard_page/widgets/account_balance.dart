import 'package:flutter/material.dart';
import '../../../../features/dashboard_page/logic/get_provider_total_rate_and_employee_and_balance_cubit/get_provider_total_rate_and_employee_and_balance_cubit.dart';
import '../../../../features/dashboard_page/logic/get_provider_total_rate_and_employee_and_balance_cubit/get_provider_total_rate_and_employee_and_balance_state.dart';
import '../../../../../core/language/language_constant.dart';
import '../../../../../core/theming/colors.dart';
import '../../../../../core/pages_widgets/general_widgets/custom_container.dart';
import '../../../../../core/theming/text_styles.dart';
import 'data_account_balance.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

class AccountBalance extends StatelessWidget {
  const AccountBalance({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<GetProviderTotalRateAndEmployeeAndBalanceCubit,
        GetProviderTotalRateAndEmployeeAndBalanceState>(
      builder: (context, state) {
        final data = state is GetProviderTotalRateAndEmployeeAndBalanceSuccess
            ? state.data.accountsBalance
            : [];

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
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                     Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(height: 10),
                        const TextInAppWidget(
                          text: AppLanguageKeys.accountBalanceKey,
                          textSize: 18,
                          textColor: AppColors.darkColor,
                        ),
                        Row(
                          spacing: 5,
                          children: [
                            const TextInAppWidget(
                              text: AppLanguageKeys.total,
                              textSize: 20,
                              textColor: AppColors.orangeColor,
                            ),
                            BlocBuilder<
                                GetProviderTotalRateAndEmployeeAndBalanceCubit,
                                GetProviderTotalRateAndEmployeeAndBalanceState>(
                              builder: (context, state) {

                                double total = 0;

                                if (state
                                is GetProviderTotalRateAndEmployeeAndBalanceSuccess) {
                                  total = state.data.totalBalance ?? 0;
                                }

                                return TextInAppWidget(
                                  text: ': ${total.toStringAsFixed(0)}',
                                  textSize: 20,
                                  textColor: AppColors.orangeColor,
                                );
                              },
                            ),
                          ],
                        ),
                      ],
                    ),
                    // CustomContainer(
                    //   padding: const EdgeInsets.all(0),
                    //   containerWidth: 100,
                    //   containerHeight: 37,
                    //   typeWidget: const Center(
                    //     child: TextInAppWidget(
                    //       text: AppLanguageKeys.detailsKey,
                    //       textColor: AppColors.whiteColor,
                    //       textSize: 15,
                    //     ),
                    //   ),
                    //   onTap: () {},
                    //   isSelected: false,
                    //   containerColor: AppColors.orangeColor,
                    // )
                  ],
                ),

                const SizedBox(height: 20),

                Expanded(
                  child: data.isEmpty
                      ? const Center(child: Text("No Data"))
                      : ListView.separated(
                    itemCount: data.length,
                    separatorBuilder: (_, __) =>
                    const SizedBox(height: 10),
                    itemBuilder: (context, index) {
                      return DataAccountBalance(
                        item: data[index],
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
