import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../../../../features/store_page/model/cars_model_cubit/car_model_cubit/car_model_cubit.dart';
import '../../../../../../../core/language/language_constant.dart';

import 'cars_added.dart';
import '../../custom_add_button.dart';

class AddCarModelUi extends StatelessWidget {
  const AddCarModelUi({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      spacing: 20,
      children: [
        const CarsAdded(),
        CustomAddButton(
          width: 178,
          text: AppLanguageKeys.addCarModelKey,
          onTap: () {
            context.read<CarModelCubit>().startAddingNewCar();
          },
        ),
      ],
    );
  }
}
