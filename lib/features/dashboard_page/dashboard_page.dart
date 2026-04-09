import 'package:flutter/material.dart';
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
    return const Center(
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
                    CustomChart(
                      image: AppImageKeys.carServices,
                      imageBackground: AppColors.orangeColor,
                    ),
                    CustomChart(
                      image: AppImageKeys.truckBox,
                      imageBackground: AppColors.seaBlueColor,
                    ),
                    CustomChart(
                      image: AppImageKeys.spare,
                      imageBackground: AppColors.darkGreyColor,
                    ),
                     ServicesStatistics(),
                     ChartOrder(),
                    Column(
                      spacing: 10,
                      children: [
                        SizedBox(width: 310, child: ServicesEvaluation()),
                        EmployeesPerformance()
                      ],
                    ),
                    AccountBalance(),
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
