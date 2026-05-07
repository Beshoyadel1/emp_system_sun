import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../../core/cubit/app_cubit/app_cubit.dart';
import '../../../../../core/utilies/map_of_all_app.dart';
import '../../../../../features/internal_services/internal_orders/first_screen_internal_orders/screens/big_container_of_new_orders/Container_view_all_in_first_row_in_data_container_in_list_data_first_screen_internal_orders.dart';
import '../../../../../core/api_functions/harage/get_all_harage_model/get_all_harage_request.dart';
import '../../../../../features/cars_haraj_page/logic/get_all_harage_cubit/get_all_harage_cubit.dart';
import '../../../../../features/cars_haraj_page/widgets/available_list_cars.dart';
import '../../../../../core/language/language_constant.dart';
import '../../../../../core/theming/colors.dart';
import '../../../../../core/pages_widgets/general_widgets/custom_container.dart';
import '../../../../../core/theming/text_styles.dart';

class ListOfCars extends StatefulWidget {
  const ListOfCars({super.key});

  @override
  State<ListOfCars> createState() => _ListOfCarsState();
}

class _ListOfCarsState extends State<ListOfCars> {

  late final GetAllHarageCubit cubit;

  @override
  void initState() {
    super.initState();
    cubit = GetAllHarageCubit()
      ..getAllHarage(page: 1);
  }

  @override
  Widget build(BuildContext context) {
    bool isMobile = MediaQuery.of(context).size.width < 600;

    return BlocProvider.value(
      value: cubit,
      child: CustomContainer(
        containerWidth: isMobile ? double.infinity : 860,
        isSelected: false,
        onTap: () {},
        typeWidget: Column(
          spacing: 20,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 10.0),
              child: SizedBox(
                width: double.infinity,
                child: Wrap(
                  alignment: WrapAlignment.spaceBetween,
                  children: [
                    const Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        TextInAppWidget(
                          text: AppLanguageKeys.carList,
                          textSize: 20,
                        ),
                        TextInAppWidget(
                          text: AppLanguageKeys.availableCarsShortList,
                          textSize: 16,
                        ),
                      ],
                    ),
                    ContainerViewAllInFirstRowInDataContainerInListDataFirstScreenInternalOrders(
                      onTap: () {
                        AppCubit.get(context).navigateToPage(
                          PagesOfAllApp.carHarajOrdersPageNumber,
                        );
                      },
                    ),
                  ],
                ),
              ),
            ),

            const AvailableListCars(),
          ],
        ),
      ),
    );
  }
}