import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../../features/cars_haraj_page/logic/get_all_harage_cubit/get_all_harage_cubit.dart';
import '../../../../../features/cars_haraj_page/widgets/filter_design_car_list.dart';
import '../../../../../features/internal_services/internal_orders/first_screen_internal_orders/logic/tabs_cubit/tabs_cubit.dart';
import '../../../../../core/theming/colors.dart';
import '../../../../../core/theming/text_styles.dart';
import '../../../../../features/cars_haraj_page/model/filter_orders_model/filter_orders_model.dart';

class FiltersTabsCarWidget extends StatefulWidget {
  const FiltersTabsCarWidget({
    super.key,
    required this.filterOptions,
  });

  final List<filterOrdersModel> filterOptions;

  @override
  State<FiltersTabsCarWidget> createState() => _FiltersTabsCarWidgetState();
}

class _FiltersTabsCarWidgetState extends State<FiltersTabsCarWidget>
    with SingleTickerProviderStateMixin {

  late TabController _tabController;

  @override
  void initState() {
    super.initState();

    _tabController =
        TabController(length: widget.filterOptions.length, vsync: this);

    _tabController.addListener(() {
      if (_tabController.indexIsChanging) {
        context.read<TabsCubit>().changeTab(_tabController.index);
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
              controller: _tabController,
              isScrollable: true,
              indicator: const BoxDecoration(),
              tabAlignment: TabAlignment.start,
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
                      (index) => const FilterDesignCarList(),
                ),
              ),
            )
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