import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../../../../features/store_page/model/cars_model_cubit/car_model_cubit/car_model_state.dart';
import '../../../../../../../features/store_page/model/cars_model_cubit/car_model_cubit/car_model_cubit.dart';
import '../../../../../../core/theming/colors.dart';
import '../../../../../../core/pages_widgets/general_widgets/custom_container.dart';
import '../../../../../../core/language/language_constant.dart';
import 'widgets/body_car_model.dart';
import '../navigator_button.dart';

class CarModelWidget extends StatelessWidget {
  const CarModelWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => CarModelCubit(),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: BlocBuilder<CarModelCubit, CarModelState>(
            builder: (context, state) {
              final cubit = context.read<CarModelCubit>();
              return Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 16.0),
                    child: CustomContainer(
                      containerWidth: double.infinity,
                      containerHeight: 912,
                      isSelected: false,
                      onTap: () {},
                      border: state is CarModelAddingNew
                          ? const Border(
                              top: BorderSide(color: AppColors.lightGreyColor),
                              left: BorderSide(color: AppColors.lightGreyColor),
                              right:
                                  BorderSide(color: AppColors.lightGreyColor),
                              bottom:
                                  BorderSide(color: AppColors.lightGreyColor),
                            )
                          : const Border(
                              top: BorderSide(color: AppColors.lightGreyColor),
                              left: BorderSide(color: AppColors.lightGreyColor),
                              right:
                                  BorderSide(color: AppColors.lightGreyColor),
                            ),
                      borderRadius: state is CarModelAddingNew
                          ? const BorderRadius.all(Radius.circular(10))
                          : const BorderRadius.only(
                              topLeft: Radius.circular(10),
                              topRight: Radius.circular(10),
                            ),
                      typeWidget: BodyCarModel(state: state),
                    ),
                  ),
                  if (state is CarModelInitial || state is CarModelAdded)
                    NavigatorButton(
                      textOrangeButton: state is CarModelAdded
                          ? AppLanguageKeys.nextKey
                          : AppLanguageKeys.addKey,
                      onTapGrayButton: cubit.goBack,
                      onTapOrangeButton: () {
                        if (state is CarModelAdded) {
                          cubit.startAddingNewCar();
                        } else {
                          cubit.addCar(
                            AppLanguageKeys.newModelKey +
                                DateTime.now().second.toString(),
                          );
                        }
                      },
                    ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}
