import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../../core/theming/colors.dart';
import '../../../../../features/dashboard_page/logic/get_provider_service_statistics_cubit/get_provider_service_statistics_cubit.dart';
import '../../../../../features/dashboard_page/logic/get_provider_total_rate_and_employee_and_balance_cubit/get_provider_total_rate_and_employee_and_balance_cubit.dart';
import '../../../../../features/dashboard_page/widgets/list_custom_chart.dart';
import 'widgets/account_balance.dart';
import 'widgets/chart_order.dart';
import 'widgets/employees_performance.dart';
import 'widgets/services_evaluation.dart';
import 'widgets/services_statistics.dart';

class DashboardPage extends StatelessWidget {
  const DashboardPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.scaffoldColor,
      body: Center(
        child: SingleChildScrollView(
          child: Center(
            child: MultiBlocProvider(
              providers: [
                BlocProvider(
                  create: (_) => GetProviderServiceStatisticsCubit()
                    ..getProviderServiceStatistics(),
                ),
                BlocProvider(
                  create: (_) => GetProviderTotalRateAndEmployeeAndBalanceCubit()
                    ..getProviderTotalRateAndEmployeeAndBalance(),
                )
              ],
              child: const Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Center(
                    child: Wrap(
                      alignment: WrapAlignment.center,
                      spacing: 10,
                      runSpacing: 10,
                      children: [
                        ListCustomChart(),
                        AccountBalance(),
                        ChartOrder(),
                        EmployeesPerformance(),
                        Column(
                          spacing: 5,
                          children: [
                            ServicesEvaluation(),
                            ServicesStatistics(),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

