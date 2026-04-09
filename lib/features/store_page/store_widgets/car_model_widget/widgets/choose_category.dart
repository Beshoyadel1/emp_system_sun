import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../../../../features/store_page/model/cars_model_cubit/car_model_cubit/car_model_state.dart';
import '../../../../../../../features/store_page/model/cars_model_cubit/car_model_cubit/car_model_cubit.dart';
import '../../../../../../../core/theming/text_styles.dart';
import '../../../../../../../core/theming/colors.dart';
import '../../../../../../../core/theming/fonts.dart';
import '../../../../../../../core/language/language_constant.dart';
import 'car_category_list.dart';
import 'car_name_listview.dart';

class ChooseCategory extends StatelessWidget {
  const ChooseCategory({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const TextInAppWidget(
          text: AppLanguageKeys.chooseCategoryKey,
          textSize: 15.7,
          fontWeightIndex: FontSelectionData.regularFontFamily,
          textColor: AppColors.darkColor,
        ),
        const SizedBox(height: 12),
        Row(
          children: [
            Container(
                height: 88,
                width: 111,
                decoration: BoxDecoration(
                    color: AppColors.whiteColor,
                    borderRadius: BorderRadius.circular(19),
                    border: Border.all(
                      color: AppColors.orangeColor,
                      width: 1,
                    )),
                child: const Center(
                    child: TextInAppWidget(
                        text: AppLanguageKeys.allCategoriesKey,
                        textSize: 12,
                        fontWeightIndex: FontSelectionData.regularFontFamily,
                        textColor: AppColors.orangeColor))),
            Expanded(
              child: Builder(
                builder: (context) {
                  return BlocBuilder<CarModelCubit, CarModelState>(
                    builder: (context, state) {
                      String selectedCar = '';
                      if (state is SelectedCarState) {
                        selectedCar = state.selectedCarName;
                      }

                      return CustomCardCar(
                        heightSizeBox: 88,
                        typeModel: CarCategoryList,
                        heightContainer: 88,
                        widthContainer: 111,
                        heightImage: 32,
                        widthImage: 80,
                        selectedCarName: selectedCar,
                        scrollDirection: null,
                      );
                    },
                  );
                },
              ),
            )
          ],
        ),
      ],
    );
  }
}
