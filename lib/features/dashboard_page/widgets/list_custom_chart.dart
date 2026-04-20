import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../features/dashboard_page/logic/get_provider_service_statistics_cubit/get_provider_service_statistics_cubit.dart';
import '../../../../features/dashboard_page/logic/get_provider_service_statistics_cubit/get_provider_service_statistics_state.dart';
import '../../../../core/theming/assets.dart';
import '../../../../core/theming/colors.dart';
import '../../../../features/dashboard_page/widgets/custom_chart.dart';

class ListCustomChart extends StatelessWidget {
  const ListCustomChart({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<GetProviderServiceStatisticsCubit,
        GetProviderServiceStatisticsState>(
      builder: (context, state) {

        if (state is GetProviderServiceStatisticsLoading) {
          return const Center(child: CircularProgressIndicator());
        }

        if (state is GetProviderServiceStatisticsError) {
          return Center(child: Text(state.message));
        }

        if (state is GetProviderServiceStatisticsSuccess) {
          final data = state.data.summaryCards;

          if (data.isEmpty) {
            return const Center(child: Text("No Data"));
          }

          return Wrap(
            alignment: WrapAlignment.center,
            spacing: 10,
            runSpacing: 10,
            children: List.generate(data.length, (index) {
              final item = data[index];

              return CustomChart(
                serviceName: item.getName(context),
                orderCount: item.orderCount,
                totalAmount: item.totalAmount,
                percentage: item.percentageChange,
                isIncrease: item.isIncrease,
                image: _getImage(index),
                imageBackground: _getColor(index),
              );
            }),
          );
        }

        return const SizedBox();
      },
    );
  }

  Color _getColor(int index) {
    final colors = [
      AppColors.orangeColor,
      AppColors.seaBlueColor,
      AppColors.darkGreyColor,
    ];
    return colors[index % colors.length];
  }

  String _getImage(int index) {
    final images = [
      AppImageKeys.carServices,
      AppImageKeys.truckBox,
      AppImageKeys.spare,
    ];
    return images[index % images.length];
  }
}