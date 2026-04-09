import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../../../core/cubit/new_orders_cubit/new_orders_cubit.dart';
import '../../../../../../core/language/language_constant.dart';
import '../../../../../../core/pages_widgets/general_widgets/custom_container.dart';
import '../../../../../../core/theming/colors.dart';
import '../../../../../../core/theming/text_styles.dart';
import '../../../../../../features/cars_haraj_page/model/filter_orders_model/filter_orders_model.dart';
import '../../../../../../features/internal_services/internal_orders/first_screen_internal_orders/logic/tabs_cubit/tabs_cubit.dart';
import '../../../../../../features/spare_parts/spare_parts_statistics/spare_parts_page/widgets/filters_tabs_widget_spare_parts_statistics.dart';

class OrdersPageSparePartsStatistics extends StatelessWidget {
  const OrdersPageSparePartsStatistics({super.key, required this.cubit});

  final NewOrdersCubit cubit;

  @override
  Widget build(BuildContext context) {
    return CustomContainer(
      isSelected: false,
      onTap: () {},
      typeWidget: Center(
        child: Column(
          spacing: 20,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Wrap(
              alignment: WrapAlignment.spaceBetween,
              runAlignment: WrapAlignment.spaceBetween,
              crossAxisAlignment: WrapCrossAlignment.start,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    TextInAppWidget(
                      text: AppLanguageKeys.allOrdersKey,
                      textSize: 20,
                      textColor: AppColors.darkColor,
                    ),
                    TextInAppWidget(
                      text: AppLanguageKeys.ordersListFromServicesKey,
                      textSize: 16,
                      textColor: AppColors.darkGreyColor,
                    ),
                  ],
                ),
              ],
            ),
            Expanded(
                child: BlocProvider(
              create: (_) => TabsCubit(),
              child: FiltersTabsWidgetSparePartsStatistics(
                filterOptions: filterOrders,
              ),
            )),
            // Center(child: NumberIndicator())
          ],
        ),
      ),
    );
  }
}
