import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../../core/language/language_cubit/language_cubit.dart';
import '../../../../../core/language/language_cubit/language_states.dart';
import '../../../../../core/language/language_model.dart';
import '../../../../../core/pages_widgets/text_form_field_widget.dart';
import '../../../../../core/theming/fonts.dart';
import '../../../../../core/theming/text_styles.dart';
import '../../../../../core/theming/colors.dart';

class FirstNameTextfieldPersonalDataWidget extends StatefulWidget {
  final String name;
  final String? hint;
  final bool isLanguage;
  final bool isCard;
  final bool? isRegular;
  final int? maxLines;
  final TextEditingController? textFormController;
  final double? textFormWidth, textFormHeight;

  const FirstNameTextfieldPersonalDataWidget(
      {super.key,
      required this.name,
      this.hint,
      this.isLanguage = false,
      this.isCard = false,
      this.isRegular = false,
      this.maxLines,
      this.textFormController,
      this.textFormWidth,
      this.textFormHeight});

  @override
  State<FirstNameTextfieldPersonalDataWidget> createState() =>
      _FirstNameTextfieldPersonalDataWidgetState();
}

class _FirstNameTextfieldPersonalDataWidgetState
    extends State<FirstNameTextfieldPersonalDataWidget> {
  late LanguageCubit cubit;
  late TextEditingController textFormController2;

  @override
  void initState() {
    super.initState();
    cubit = LanguageCubit.get(context);
    textFormController2 = TextEditingController();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      spacing: 10,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        TextInAppWidget(
          text: widget.name,
          textSize: 12,
          fontWeightIndex: widget.isRegular!
              ? FontSelectionData.regularFontFamily
              : FontSelectionData.mediumFontFamily,
          textColor:
              widget.isRegular! ? AppColors.blackColor44 : AppColors.greyColor,
        ),
        if (widget.isLanguage)
          BlocBuilder<LanguageCubit, LanguageStates>(
            builder: (context, state) {
              return Container(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                decoration: BoxDecoration(
                  border: Border.all(
                    color: AppColors.darkColor.withOpacity(0.2),
                  ),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: DropdownButtonHideUnderline(
                  child: DropdownButton<LanguageModel>(
                    isExpanded: true,
                    focusColor: AppColors.whiteColor,
                    dropdownColor: AppColors.whiteColor,
                    value: cubit.languageDropDownValue,
                    items: cubit.languageItemsDropDown.map((lang) {
                      return DropdownMenuItem(
                        value: lang,
                        child: TextInAppWidget(
                          text: cubit.isAllAppLanguageArabic
                              ? lang.arName!
                              : lang.enName!,
                          textSize: 15,
                        ),
                      );
                    }).toList(),
                    onChanged: (value) {
                      if (value != null) {
                        cubit.languageDropDownValue = value;
                        cubit.changeAllAppLanguage(value.number!);
                      }
                    },
                  ),
                ),
              );
            },
          )
        else
          Container(
            decoration: widget.isCard
                ? BoxDecoration(
                    color: AppColors.whiteColor,
                    borderRadius: BorderRadius.circular(12),
                    boxShadow: [
                      BoxShadow(
                        color: AppColors.darkColor.withOpacity(0.1),
                        blurRadius: 5,
                        offset: Offset(1, 4),
                      ),
                    ],
                  )
                : null,
            child: TextFormFieldWidget(
              textFormController:
                  widget.textFormController ?? textFormController2,
              fillColor: AppColors.transparent,
              borderColor: AppColors.darkColor.withOpacity(0.2),
              hintText: widget.hint,
              hintTextSize: 12,
              hintTextColor: AppColors.darkColor.withOpacity(0.4),
              textSize: 15,
              textFormWidth: widget.textFormWidth ?? 500,
              textFormHeight: widget.textFormHeight,
              enabledBorderRadius: widget.isCard
                  ? BorderRadius.all(CupertinoScrollbar.defaultRadius)
                  : null,
              contentPadding:
                  const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
              maxLines: widget.maxLines,
            ),
          ),
      ],
    );
  }
}
