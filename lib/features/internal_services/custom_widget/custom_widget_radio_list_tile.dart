import 'package:emp_system_sun/features/internal_services/logic/Details_container_setting_cubit/Details_container_setting_cubit.dart';
import 'package:emp_system_sun/features/internal_services/logic/Details_container_setting_cubit/Details_container_setting_state.dart';
import 'package:emp_system_sun/features/internal_services/logic/select_car_model_setting_cubit/select_car_model_setting_cubit.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../../core/theming/colors.dart';
import '../../../../../core/theming/fonts.dart';
import '../../../../../core/theming/text_styles.dart';

class CustomWidgetRadioListTile extends StatelessWidget {
  final String text;
  final int value;
  final int brandIndex; // 🔥 NEW

  const CustomWidgetRadioListTile({
    super.key,
    required this.text,
    required this.value,
    required this.brandIndex,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<DetailsContainerSettingCubit,
        DetailsContainerSettingState>(
      builder: (context, state) {
        return Expanded(
          child: RadioListTile<int>(
            activeColor: AppColors.orangeColor,
            title: TextInAppWidget(
              text: text,
              textSize: 13,
              fontWeightIndex:
              FontSelectionData.mediumFontFamily,
              textColor: AppColors.darkColor,
            ),
            value: value,
            groupValue: state.selectedOption,
            contentPadding: EdgeInsets.zero,
            onChanged: (val) {
              context
                  .read<DetailsContainerSettingCubit>()
                  .selectOption(val!);
              context
                  .read<SelectCarModelSettingCubit>()
                  .setSelectedOption(brandIndex, val);
            },
          ),
        );
      },
    );
  }
}
