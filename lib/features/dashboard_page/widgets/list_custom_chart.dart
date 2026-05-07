import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/language/language_cubit/language_cubit.dart';
import '../../../../core/language/language_cubit/language_states.dart';
import '../../../../../features/dashboard_page/logic/get_provider_service_statistics_cubit/get_provider_service_statistics_cubit.dart';
import '../../../../../features/dashboard_page/logic/get_provider_service_statistics_cubit/get_provider_service_statistics_state.dart';
import '../../../../../features/internal_services/internal_orders/custom_widget/text_empty_view_data.dart';
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
            return const SizedBox();
          }

          return LayoutBuilder(
            builder: (context, constraints) {
              final width = constraints.maxWidth;

              int itemsPerRow;
              if (width > 1000) {
                itemsPerRow = 4;
              } else if (width > 600) {
                itemsPerRow = 2;
              } else {
                itemsPerRow = 1;
              }

              final itemWidth =
                  (width - ((itemsPerRow - 1) * 10)) / itemsPerRow;

              return BlocBuilder<LanguageCubit, LanguageStates>(
                builder: (context, langState) {
                  final isArabic =
                      context.watch<LanguageCubit>().isAllAppLanguageArabic;

                  return Wrap(
                    spacing: 10,
                    runSpacing: 10,
                    children: List.generate(data.length, (index) {
                      final item = data[index];

                      return SizedBox(
                        width: itemWidth,
                        height: 200,
                        child: CustomChart(
                          serviceName: item.getName(isArabic),
                          orderCount: item.orderCount,
                          totalAmount: item.totalAmount,
                          percentage: item.percentageChange,
                          isIncrease: item.isIncrease,
                          image: _getImage(index),
                          imageBackground: _getColor(index),
                        ),
                      );
                    }),
                  );
                },
              );
            },
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