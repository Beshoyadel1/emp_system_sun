import 'package:flutter/material.dart';
import '../../../../../core/language/language_constant.dart';
import '../../../../../core/pages_widgets/text_form_field_widget.dart';
import '../../../../../core/theming/colors.dart';
import '../../../../../core/theming/fonts.dart';

class WorkingHoursWidget extends StatelessWidget {
  const WorkingHoursWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 20,
      runSpacing: 10,
      children: [
        SizedBox(
          width: 163,
          child: TextFormFieldWidget(
            isSpaceAfterText: true,
            textFormController: TextEditingController(),
            isColumn: false,
            text: AppLanguageKeys.fromKey,
            textColor: AppColors.darkGreyColor,
            textSize: 20,
            fontWeightIndex: FontSelectionData.mediumFontFamily,
            hintText: '00 : 00',
            hintTextColor: AppColors.darkColor,
            //prefixIcon: Icons.access_time,
            // prefixIconColor: AppColors.darkGreyColor,
            prefixIconSize: 19,
            borderColor: AppColors.lightGreyColor,
            //borderRadius: 10,
            fillColor: AppColors.whiteColor,
            textFormHeight: 35,
          ),
        ),
        SizedBox(
          width: 163,
          child: TextFormFieldWidget(
            isSpaceAfterText: true,
            textFormController: TextEditingController(),
            isColumn: false,
            text: AppLanguageKeys.toKey,
            //textFontWeight: FontWeight.w700,
            textColor: AppColors.darkGreyColor,
            textSize: 20,
            fontWeightIndex: FontSelectionData.mediumFontFamily,
            hintText: '00 : 00',
            hintTextColor: AppColors.darkColor,
            // prefixIcon: Icons.access_time,
            // prefixIconColor: AppColors.darkGreyColor,
            prefixIconSize: 19,
            borderColor: AppColors.lightGreyColor,
            //borderRadius: 10,
            fillColor: AppColors.whiteColor,
            textFormHeight: 35,
          ),
        ),
      ],
    );
  }
}
