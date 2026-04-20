import 'package:flutter/material.dart';
import '../../../../../features/dashboard_page/widgets/services_evaluation.dart';
import '../../../../../features/dashboard_page/widgets/services_statistics.dart';

import '../widgets/internal_services.dart';
import '../widgets/new_orders.dart';
import '../widgets/profits_services.dart';

class InternalAndServicesStatisticsPage extends StatelessWidget {
  const InternalAndServicesStatisticsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SingleChildScrollView(
        child: Wrap(
          spacing: 10,
          runSpacing: 10,
          crossAxisAlignment: WrapCrossAlignment.start,
          alignment: WrapAlignment.center,
          children: [
            SizedBox(
              width: 860,
              child: Wrap(
                crossAxisAlignment: WrapCrossAlignment.center,
                alignment: WrapAlignment.center,
                spacing: 10,
                runSpacing: 10,
                children: [
                  ...List.generate(6, (_) => const InternalServices()),
                  const NewOrders(),
                ],
              ),
            ),
            const SizedBox(
              width: 375,
              child: Wrap(
                crossAxisAlignment: WrapCrossAlignment.start,
                alignment: WrapAlignment.center,
                spacing: 10,
                runSpacing: 10,
                children: [
                  ServicesStatistics(),
                  ProfitsServices(),
                  ServicesEvaluation(),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
