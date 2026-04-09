import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../../../features/permissions/first_screen_permissions/logic/option_dashboard_cubit.dart';
import '../../../../../core/pages_widgets/text_form_field_widget.dart';
import '../../../../../core/theming/colors.dart';
import '../../../../../core/theming/fonts.dart';
import '../../../../../core/theming/text_styles.dart';

class TextWithTextFormFieldAsColumnWidget extends StatelessWidget {
  final String text, hint;
  final List<String>? options;
  final TextEditingController textFormController = TextEditingController();
  final int? maxLines;
  final double? textFormWidth, textFormHeight, borderRadius, textSize;

  TextWithTextFormFieldAsColumnWidget(
      {super.key,
      required this.text,
      required this.hint,
      this.options,
      this.maxLines,
      this.textFormWidth,
      this.textFormHeight,
      this.borderRadius,
      this.textSize});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          TextInAppWidget(
            text: text,
            textSize: textSize ?? 11,
            fontWeightIndex: FontSelectionData.regularFontFamily,
            textColor: AppColors.blackColor,
          ),
          const SizedBox(height: 8),
          options != null && options!.isNotEmpty
              ? BlocProvider(
                  create: (_) => OptionDashboardCubit(),
                  child: BlocBuilder<OptionDashboardCubit, String?>(
                    buildWhen: (previous, current) => previous != current,
                    builder: (context, selectedOption) {
                      return SizedBox(
                        height: textFormHeight ?? 35,
                        child: InputDecorator(
                          decoration: InputDecoration(
                            border: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.circular(borderRadius ?? 25),
                            ),
                            contentPadding: const EdgeInsets.symmetric(
                                horizontal: 12, vertical: 8),
                          ),
                          child: DropdownButtonHideUnderline(
                            child: DropdownButton<String>(
                              dropdownColor: AppColors.whiteColor,
                              isExpanded: true,
                              value: selectedOption,
                              hint: TextInAppWidget(
                                text: hint,
                                textSize: 13,
                                fontWeightIndex:
                                    FontSelectionData.regularFontFamily,
                                textColor: AppColors.darkColor.withOpacity(0.4),
                              ),
                              items: options!
                                  .map(
                                    (option) => DropdownMenuItem(
                                      value: option,
                                      child: TextInAppWidget(
                                        text: option,
                                        textSize: 13,
                                        fontWeightIndex:
                                            FontSelectionData.regularFontFamily,
                                        textColor: AppColors.blackColor,
                                      ),
                                    ),
                                  )
                                  .toList(),
                              onChanged: (value) {
                                context
                                    .read<OptionDashboardCubit>()
                                    .selectOption(value);
                                textFormController.text = value ?? "";
                              },
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                )
              : TextFormFieldWidget(
                  textFormController: textFormController,
                  fillColor: AppColors.transparent,
                  borderColor: AppColors.darkColor.withOpacity(0.2),
                  hintText: hint,
                  hintTextSize: 11,
                  hintTextColor: AppColors.darkColor.withOpacity(0.4),
                  textSize: 11,
                  contentPadding: EdgeInsetsGeometry.all(5),
                  textFormHeight: maxLines != null && maxLines! > 1
                      ? null
                      : (textFormHeight ?? 35),
                  maxLines: maxLines,
                  textFormWidth: textFormWidth,
                  focusedBorderRadius:
                      BorderRadius.circular(borderRadius ?? 15),
                  enabledBorderRadius:
                      BorderRadius.circular(borderRadius ?? 15),
                ),
        ],
      ),
    );
  }
}
