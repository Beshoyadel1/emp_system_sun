import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../../internal_services/presentation/cubit/get_provider_internal_order/get_provider_internal_order_state.dart';
import '../../../../../../../../../features/internal_services/presentation/cubit/tabs_cubit/tabs_cubit.dart';
import '../../../../../../../../../features/order_services/presentation/pages/order_services_type/widgets/filters_tabs_widget_order_services_type.dart';
import '../../../../../../../core/cubit/new_orders_cubit/new_orders_cubit.dart';
import '../../../../../../../core/language/language_constant.dart';
import '../../../../../../../core/pages_widgets/general_widgets/custom_container.dart';
import '../../../../../../../core/theming/colors.dart';
import '../../../../../../../core/theming/text_styles.dart';
import '../../../../../../../../../features/cars_haraj_page/data/model/filter_orders_model/filter_orders_model.dart';

class OrdersPageMobileServicesStatistics extends StatelessWidget {
  final int serviceId;
  const OrdersPageMobileServicesStatistics({super.key, required this.cubit,required this.serviceId});

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
                child:  MultiBlocProvider(
                  providers: [
                    BlocProvider(create: (_) => TabsCubit()),
                    BlocProvider(
                      create: (_) => GetProviderInternalOrderCubit()
                        ..loadInternalOrders(
                          serviceId: serviceId,
                          //orderType: mapOrderType(0),
                        ),
                    ),
                  ],
              child: FiltersTabsWidgetOrderServicesType(
                filterOptions: filterOrders,
                serviceId:serviceId,
              ),
            )),
            // Center(child: NumberIndicator())
          ],
        ),
      ),
    );
  }
}
