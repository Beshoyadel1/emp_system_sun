import 'package:flutter/material.dart';
import '../../../../../../../../core/api_functions/statistics/get_provider_main_service_statistics_model/data_points_request.dart';
import '../../../../../../../../core/theming/colors.dart';
import '../../../../../../../../features/internal_services/internal_orders/first_screen_internal_orders/logic/loading_dashboard/loading_dashboard_cubit.dart';
import '../../../../../../../../features/internal_services/internal_orders/first_screen_internal_orders/logic/loading_dashboard/loading_dashboard_state.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class FastLineWithFillSparePartsOrders extends StatelessWidget {
  FastLineWithFillSparePartsOrders({super.key});

  final ZoomPanBehavior _zoomPanBehavior = ZoomPanBehavior(
    enablePinching: true,
    enablePanning: true,
    zoomMode: ZoomMode.x,
  );

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<InternalOrdersCubit, InternalOrdersState>(
      builder: (context, state) {
        return SizedBox(
          height: 150,
          child: SfCartesianChart(
            zoomPanBehavior: _zoomPanBehavior,
            primaryXAxis: const CategoryAxis(),

            primaryYAxis:const NumericAxis(),

            series: <CartesianSeries>[
              AreaSeries<DataPointsRequest, String>(
                dataSource: state.chartPoints,

                xValueMapper: (e, _) => e.label ?? '',
                yValueMapper: (e, _) => e.value ?? 0,

                color: Colors.pink.withOpacity(0.3),
                borderColor: Colors.transparent,
              ),

              FastLineSeries<DataPointsRequest, String>(
                dataSource: state.chartPoints,

                xValueMapper: (e, _) => e.label ?? '',
                yValueMapper: (e, _) => e.value ?? 0,

                color: AppColors.orangeColor,
                width: 2,
              ),
            ],
          ),
        );
      },
    );
  }
}

class ChartData {
  ChartData(this.x, this.y);

  final DateTime x;
  final double y;
}
