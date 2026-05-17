import 'package:flutter/material.dart';
import '../../../../../../../core/pages_widgets/general_widgets/custom_container.dart';
import '../../../../../../../core/theming/colors.dart';
import 'choose_car_model.dart';
import 'choose_category.dart';
import 'select_model_years.dart';

class AllCarsModelsUi extends StatelessWidget {
  const AllCarsModelsUi({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomContainer(
        isSelected: false,
        onTap: () {},
        containerColor: AppColors.veryLightGreyColor.withAlpha(40),
        border: Border.all(color: AppColors.lightGreyColor),
        borderRadius: BorderRadius.circular(10),
        typeWidget: const Padding(
          padding: EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ChooseCarModel(),
              SizedBox(height: 30),
              ChooseCategory(),
              SizedBox(height: 32),
              SelectModelYears(),
            ],
          ),
        ));
  }
}
