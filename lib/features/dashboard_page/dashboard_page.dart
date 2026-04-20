import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../features/dashboard_page/logic/get_provider_service_statistics_cubit/get_provider_service_statistics_cubit.dart';
import '../../../../features/dashboard_page/logic/get_provider_total_rate_and_employee_and_balance_cubit/get_provider_total_rate_and_employee_and_balance_cubit.dart';
import '../../../../features/dashboard_page/widgets/list_custom_chart.dart';
import '../../../../core/theming/assets.dart';
import '../../../../core/theming/colors.dart';
import 'widgets/account_balance.dart';
import 'widgets/chart_order.dart';
import 'widgets/custom_chart.dart';
import 'widgets/employees_performance.dart';
import 'widgets/services_evaluation.dart';
import 'widgets/services_statistics.dart';

class DashboardPage extends StatelessWidget {
  const DashboardPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SingleChildScrollView(
        child: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Center(
                child: Wrap(
                  alignment: WrapAlignment.center,
                  spacing: 10,
                  runSpacing: 10,
                  children: [
                    BlocProvider(
                      create: (_) => GetProviderServiceStatisticsCubit()
                        ..getProviderServiceStatistics(),
                      child: const ListCustomChart(),
                    ),
                    const ServicesStatistics(),
                    const ChartOrder(),
                    BlocProvider(
                      create: (_) => GetProviderTotalRateAndEmployeeAndBalanceCubit()
                        ..getProviderTotalRateAndEmployeeAndBalance(),
                     child: const Wrap(
                         alignment: WrapAlignment.center,
                         spacing: 10,
                         runSpacing: 10,
                         children: [
                        Column(
                          spacing: 10,
                          children: [
                            SizedBox(width: 310, child: ServicesEvaluation()),
                            EmployeesPerformance(),
                          ],
                        ),
                         AccountBalance(),
                      ]),
                   ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
