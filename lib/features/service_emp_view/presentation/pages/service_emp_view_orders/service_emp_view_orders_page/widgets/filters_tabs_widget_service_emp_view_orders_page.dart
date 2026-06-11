import 'package:emp_system_sun/features/service_emp_view/presentation/pages/service_emp_view_orders/service_emp_view_orders_page/widgets/filter_design_service_emp_view_orders_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:emp_system_sun/features/internal_services/presentation/cubit/get_provider_internal_order/get_provider_internal_order_state.dart';
import 'package:emp_system_sun/features/internal_services/presentation/cubit/tabs_cubit/tabs_cubit.dart';
import '../../../../../../../core/api/dio_function/api_constants.dart';
import '../../../../../../../core/theming/colors.dart';
import '../../../../../../../core/theming/text_styles.dart';
import 'package:emp_system_sun/features/cars_haraj_page/data/model/filter_orders_model/filter_orders_model.dart';
import 'package:emp_system_sun/features/cars_haraj_page/data/model/internal_orders_filter/internal_orders_filter.dart';

class FiltersTabsWidgetServiceEmpViewOrdersPage extends StatefulWidget {
  final int? serviceId;
  const FiltersTabsWidgetServiceEmpViewOrdersPage({
    super.key,
    required this.filterOptions,
    this.serviceId
  });

  final List<filterOrdersModel> filterOptions;

  @override
  State<FiltersTabsWidgetServiceEmpViewOrdersPage> createState() => _FiltersTabsWidgetServiceEmpViewOrdersPageState();
}

class _FiltersTabsWidgetServiceEmpViewOrdersPageState extends State<FiltersTabsWidgetServiceEmpViewOrdersPage>
    with SingleTickerProviderStateMixin {

  late TabController _tabController;

  @override
  void initState() {
    super.initState();

    _tabController =
        TabController(length: widget.filterOptions.length, vsync: this);

    _tabController.addListener(() {
      if (_tabController.indexIsChanging) {
        final tabIndex = _tabController.index;

        context.read<TabsCubit>().changeTab(tabIndex);

        context.read<GetProviderInternalOrderCubit>().loadInternalOrders(
          serviceId: widget.serviceId??MainCategoryConstants.carSparePartsID,
          orderType: mapOrderType(tabIndex),
          pageNumber: 1,
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TabsCubit, int>(
      builder: (context, selectedIndex) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TabBar(
              tabAlignment: TabAlignment.start,
              controller: _tabController,
              isScrollable: true,
              indicator: const BoxDecoration(),
              dividerColor: Colors.transparent,
              tabs: List.generate(widget.filterOptions.length, (index) {

                final isSelected = selectedIndex == index;

                return Tab(
                  child: Container(
                    width: 150,
                    padding: const EdgeInsets.symmetric(
                        horizontal: 10, vertical: 8),
                    decoration: BoxDecoration(
                      color: isSelected
                          ? AppColors.orangeColor
                          : AppColors.greyColor,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Center(
                      child: TextInAppWidget(
                        text: widget.filterOptions[index].text,
                        textSize: 16,
                        textColor: AppColors.whiteColor,
                      ),
                    ),
                  ),
                );
              }),
            ),

            const SizedBox(height: 20),
            Expanded(
              child: TabBarView(
                controller: _tabController,
                children: List.generate(
                  widget.filterOptions.length,
                      (index) => const FilterDesignServiceEmpViewOrdersPage(),
                ),
              ),
            ),
          ],
        );
      },
    );
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }
}