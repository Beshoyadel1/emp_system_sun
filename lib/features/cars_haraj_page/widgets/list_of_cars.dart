import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../../core/cubit/app_cubit/app_cubit.dart';
import '../../../../../core/utilies/map_of_all_app.dart';
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
                    CustomContainer(
                      containerHeight: 38,
                      containerWidth: 129,
                      isSelected: true,
                      onTap: () {
                        AppCubit.get(context).navigateToPage(
                          PagesOfAllApp.carHarajOrdersPageNumber,
                        );
                      },
                      containerColor: AppColors.orangeColor,
                      typeWidget: const Center(
                        child: TextInAppWidget(
                          text: AppLanguageKeys.viewAllKey,
                          textSize: 16,
                          textColor: AppColors.whiteColor,
                        ),
                      ),
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