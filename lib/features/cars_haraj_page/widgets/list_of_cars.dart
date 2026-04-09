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

class ListOfCars extends StatelessWidget {
  const ListOfCars({super.key});

  @override
  Widget build(BuildContext context) {
    bool isMobile = MediaQuery.of(context).size.width < 600;

    return CustomContainer(
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
                runAlignment: WrapAlignment.spaceBetween,
                crossAxisAlignment: WrapCrossAlignment.start,
                children: [
                  const Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      TextInAppWidget(
                        text: AppLanguageKeys.carList,
                        textSize: 20,
                        textColor: AppColors.darkColor,
                      ),
                      TextInAppWidget(
                        text: AppLanguageKeys.availableCarsShortList,
                        textSize: 16,
                        textColor: AppColors.darkGreyColor,
                      ),
                    ],
                  ),
                  CustomContainer(
                    containerHeight: 38,
                    containerWidth: 129,
                    isSelected: true,
                    onTap: () {
                      AppCubit.get(context).navigateToPage(PagesOfAllApp.carHarajOrdersPageNumber);
                    },
                    containerColor: AppColors.orangeColor,
                    padding: EdgeInsets.zero,
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
          BlocProvider(
            create: (context) => GetAllHarageCubit()
              ..getAllHarage(page: 1),
            child: const AvailableListCars(),
          )
        ],
      ),
    );
  }
}
