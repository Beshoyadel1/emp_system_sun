import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../features/dashboard_page/logic/get_provider_total_rate_and_employee_and_balance_cubit/get_provider_total_rate_and_employee_and_balance_cubit.dart';
import '../../../../features/dashboard_page/logic/get_provider_total_rate_and_employee_and_balance_cubit/get_provider_total_rate_and_employee_and_balance_state.dart';
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
      containerWidth: 280,
      borderRadius: BorderRadius.circular(20),
      isSelected: false,
      onTap: () {},
      typeWidget: Padding(
        padding: const EdgeInsets.all(10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 5),
            const TextInAppWidget(
              text: AppLanguageKeys.topEmployeesKey,
              textSize: 14,
            ),
            const TextInAppWidget(
              text: AppLanguageKeys.topOrderReceiversKey,
              textSize: 10,
              textColor: AppColors.darkGreyColor,
            ),
            const SizedBox(height: 10),
            BlocBuilder<GetProviderTotalRateAndEmployeeAndBalanceCubit,
                GetProviderTotalRateAndEmployeeAndBalanceState>(
              builder: (context, state) {
                if (state is GetProviderTotalRateAndEmployeeAndBalanceLoading) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }

                if (state is GetProviderTotalRateAndEmployeeAndBalanceError) {
                  return const Text("Error");
                }

                if (state is GetProviderTotalRateAndEmployeeAndBalanceSuccess) {
                  final employees = state.data.topEmployees;

                  if (employees.isEmpty) {
                    return const Text("No Employees");
                  }

                  return Column(
                    children: List.generate(
                      employees.length,
                      (index) => Padding(
                        padding: const EdgeInsets.only(bottom: 8),
                        child: EmployeWidget(
                          employee: employees[index],
                        ),
                      ),
                    ),
                  );
                }

                return const SizedBox();
              },
            ),
          ],
        ),
      ),
    );
  }
}
