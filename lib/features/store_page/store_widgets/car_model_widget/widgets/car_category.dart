import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../../../../core/theming/assets.dart';
import '../../../../../../../core/theming/colors.dart';
import '../../../../../../../core/theming/fonts.dart';
import '../../../../../../../features/store_page/model/cars_model_cubit/car_model_cubit/car_model_cubit.dart';
import '../../../../../../../core/language/language_constant.dart';
import '../../../../../../../core/pages_widgets/text_form_field_widget.dart';

class CarCategory extends StatelessWidget {
  const CarCategory({super.key, this.textController});

  final TextEditingController? textController;

  @override
  Widget build(BuildContext context) {
    return Builder(builder: (context) {
      return SizedBox(
        width: 270,
        child: TextFormFieldWidget(
          textFormHeight: 35,
          contentPadding: const EdgeInsets.all(0),
          text: AppLanguageKeys.selectCarModelKey,
          textFormController: textController ?? TextEditingController(),
          hintText: AppLanguageKeys.searchCarModelKey,
          hintTextSize: 12,
          hintTextColor: AppColors.greyColor,
          prefixIcon: AppImageKeys.searchIcon,
          prefixIconWidth: 19,
          prefixIconHeight: 19,
          textSize: 14,
          textColor: AppColors.darkGreyColor,
          isColumn: true,
          fillColor: AppColors.whiteColor,
          borderColor: AppColors.lightGreyColor,
          //borderRadius: 24,
          fontWeightIndex: FontSelectionData.semiBoldFontFamily,
          isValidator: true,
          onChanged: (value) {
            context.read<CarModelCubit>().changeCar(value);
          },
        ),
      );
    });
  }
}
