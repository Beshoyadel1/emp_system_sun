import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../../../../features/store_page/model/cars_model_cubit/car_model_cubit/car_model_state.dart';
import '../../../../../../../features/store_page/model/cars_model_cubit/car_model_cubit/car_model_cubit.dart';
import '../../../../../../../core/theming/text_styles.dart';
import '../../../../../../../core/language/language_constant.dart';
import '../../../../../../../core/theming/colors.dart';
import '../../../../../../../core/theming/fonts.dart';
import 'add_car_model_ui.dart';
import 'all_cars_models_ui.dart';
import '../../custom_add_button.dart';
import 'services_setting_ui.dart';

class BodyCarModel extends StatelessWidget {
  const BodyCarModel({super.key, required this.state});

  final CarModelState state;

  @override
  Widget build(BuildContext context) {
    return Column(
      spacing: 10,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Flexible(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(
                    height: 20,
                  ),
                  TextInAppWidget(
                    text: state is CarModelAddingNew
                        ? AppLanguageKeys.carModelsKey
                        : AppLanguageKeys.defineModelsKey,
                    textSize: 22,
                    fontWeightIndex: FontSelectionData.mediumFontFamily,
                    textColor: AppColors.darkColor,
                  ),
                  TextInAppWidget(
                    text: state is CarModelAddingNew
                        ? AppLanguageKeys.serviceSettingsDetailsKey
                        : AppLanguageKeys.multipleCarsKey,
                    textSize: 16,
                    fontWeightIndex: FontSelectionData.regularFontFamily,
                    textColor: AppColors.darkColor,
                  ),
                ],
              ),
            ),
            const Spacer(),
            if (state is CarModelAddingNew)
              CustomAddButton(
                width: 186,
                text: AppLanguageKeys.addNewCarKey,
                onTap: () {},
              )
          ],
        ),
        const SizedBox(height: 5),
        BlocBuilder<CarModelCubit, CarModelState>(
          builder: (context, state) {
            if (state is CarModelInitial) {
              return const AllCarsModelsUi();
            } else if (state is CarModelAdded) {
              return const AddCarModelUi();
            } else if (state is CarModelAddingNew) {
              return const ServicesSettingUi();
            }
            return const SizedBox();
          },
        ),
      ],
    );
  }
}
