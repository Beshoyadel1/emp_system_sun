import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../../features/internal_services/internal_services_statistics/Internal_services_page/widgets/profits_services.dart';
import '../../../core/theming/colors.dart';
import '../logic/provider_harage_monthly_sales_cubit/provider_harage_monthly_sales_cubit.dart';
import '../../dashboard_page/widgets/services_statistics.dart';
import '../widgets/list_of_cars.dart';
import '../widgets/monthly_bar_chart.dart';

class CarsHarajStatisticsPage extends StatelessWidget {
  const CarsHarajStatisticsPage({super.key});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    bool isMobile = size.width <= 1042;
    bool isTabletCustom = size.width > 1042 && size.width <= 1300;
    bool isTab = size.width > 1300 ;

    return BlocProvider(
      create: (_) => ProviderHarageStatisticsCubit()..loadStatistics(),
      child: Scaffold(
          backgroundColor: AppColors.scaffoldColor,
          body: SafeArea(
              child: Row(
                  spacing: 10,
                  children: [
            Expanded(
                flex: 2,
                child: SingleChildScrollView(
                  child: Column(
                    spacing: 10,
                    children: [
                      const MonthlyBarChart(),
                      const ListOfCars(),
                      if (isTabletCustom)
                        const Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          spacing: 10,
                          children: [
                            Flexible(child: ServicesStatistics()),
                            Flexible(child: ProfitsServices()),
                          ],
                        ),
                      if (isMobile)
                        const Column(
                          spacing: 10,
                          children: [
                            ServicesStatistics(),
                            ProfitsServices(),
                          ],
                        )
                    ],
                  ),
                )),
            if (isTab)
              const Expanded(
                flex: 1,
                child: SingleChildScrollView(
                  child: Column(
                    spacing: 10,
                    children: [
                      ServicesStatistics(),
                      ProfitsServices(),
                    ],
                  ),
                ),
              )
          ]))),
    );
  }
}
