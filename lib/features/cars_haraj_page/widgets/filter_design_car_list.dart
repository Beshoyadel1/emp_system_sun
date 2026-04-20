import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../../core/pages_widgets/general_widgets/navigate_to_page_widget.dart';
import '../../../../../features/cars_haraj_page/model/car_filter/car_filter.dart';
import '../../../../../features/cars_haraj_page/ui/details_harag_page/details_harag_page.dart';
import '../../../../../features/internal_services/internal_orders/first_screen_internal_orders/logic/tabs_cubit/tabs_cubit.dart';
import '../../../../../features/spare_parts/custom_widget/app_pagination.dart';
import '../../../../../../features/cars_haraj_page/logic/get_all_harage_cubit/get_all_harage_cubit.dart';
import '../../../../../../features/cars_haraj_page/logic/get_all_harage_cubit/get_all_harage_state.dart';
import '../../../../../../features/cars_haraj_page/widgets/available_cars.dart';

class FilterDesignCarList extends StatelessWidget {
  const FilterDesignCarList({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<GetAllHarageCubit, GetAllHarageState>(
      builder: (context, state) {

        if (state is GetAllHarageError) {
          return Center(child: Text(state.message));
        }

        List cars = [];
        int currentPage = 1;
        int totalPages = 1;

        if (state is GetAllHarageSuccess) {
          final selectedTab = context.watch<TabsCubit>().state;

          final allCars = state.response.data ?? [];

          cars = CarFilter.filterCars(
            allCars,
            selectedTab,
          );

          currentPage = state.currentPage;
          totalPages = state.pageCount;
        }

        return Stack(
          children: [
            Column(
              children: [
                Expanded(
                  child: ListView.builder(
                    padding: const EdgeInsets.only(bottom: 20),
                    itemCount: cars.length,
                    itemBuilder: (context, index) {

                      final car = cars[index];

                      final isEnglish =
                          Localizations.localeOf(context).languageCode == 'en';

                      final brandNameTitle = isEnglish
                          ? (car.car?.brandLatinName ?? "")
                          : (car.car?.brandName ?? "");

                      return Padding(
                        padding: const EdgeInsets.only(bottom: 20),
                        child: AvailableCars(
                          id: car.id.toString(),
                          carImage: car.car?.carImage,
                          brandImage: car.car?.brandImage,
                          releaseDate: car.releaseDate,
                          addresstext: car.addressText,
                          isSold: car.isSold ?? false,
                          isNew: car.isNew ?? false,
                          brandName: brandNameTitle,
                          price: car.price?.toString() ?? "",

                          /// 🔥 أهم سطر
                          onTap: () async {
                            final result = await Navigator.push(
                              context,
                              NavigateToPageWidget(
                                DetailsHaragPage(car: car),
                              ),
                            );

                            if (result == true && context.mounted) {
                              context.read<GetAllHarageCubit>()
                                  .getAllHarage(page: currentPage);
                            }
                          },
                        ),
                      );
                    },
                  ),
                ),

                AppPagination(
                  currentPage: currentPage,
                  totalPages: totalPages,
                  onPageChanged: (page) {
                    context
                        .read<GetAllHarageCubit>()
                        .getAllHarage(page: page);
                  },
                ),
              ],
            ),

            /// 🔥 Loading overlay
            if (state is GetAllHarageLoading)
              Container(
                color: Colors.black26,
                child: const Center(
                  child: CircularProgressIndicator(),
                ),
              ),
          ],
        );
      },
    );
  }
}