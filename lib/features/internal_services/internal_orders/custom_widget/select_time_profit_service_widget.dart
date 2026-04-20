import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../../../features/permissions/first_screen_permissions/logic/option_dashboard_cubit.dart';
import '../../../../../core/theming/colors.dart';
import '../../../../../core/theming/fonts.dart';
import '../../../../../core/theming/text_styles.dart';

class SelectTimeProfitServiceWidget extends StatefulWidget {
  final String hint;
  final List<String>? options;
  final bool isTime;
  final Color? backGroundColor, textColor, borderColor;
  final double?  width, borderRadius, textSize;
  final Function(String value)? onChanged;
  final String? Function(String?)? validator;
  final String? errorText;

  const SelectTimeProfitServiceWidget(
      {super.key,
      required this.hint,
      this.options,
      this.isTime = false,
      this.textColor,
      this.backGroundColor,
      this.width,
      this.borderColor,
      this.borderRadius,
      this.onChanged,
        this.errorText,
        this.validator,
      this.textSize});

  @override
  State<SelectTimeProfitServiceWidget> createState() =>
      _SelectTimeProfitServiceWidgetState();
}

class _SelectTimeProfitServiceWidgetState
    extends State<SelectTimeProfitServiceWidget> {
  final TextEditingController textFormController = TextEditingController();

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
    );

    if (pickedDate != null) {
      setState(() {
        textFormController.text =
            "${pickedDate.day.toString().padLeft(2, '0')}/${pickedDate.month.toString().padLeft(2, '0')}/${pickedDate.year}";
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => OptionDashboardCubit(),
      child: BlocBuilder<OptionDashboardCubit, String?>(
        buildWhen: (previous, current) => previous != current,
        builder: (context, selectedOption) {
          return GestureDetector(
            onTap: widget.isTime
                ? () async {
                    await _selectDate(context);
                  }
                : null,
            child: SizedBox(
              width: widget.width ?? 130,
              child: InputDecorator(
                decoration: InputDecoration(
                  filled: true,
                  fillColor: widget.backGroundColor ?? AppColors.blueColor,

                  /// ✅ نفس فكرة TextField
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(widget.borderRadius ?? 10),
                    borderSide: BorderSide(
                      color: widget.borderColor ?? Colors.transparent,
                    ),
                  ),

                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(widget.borderRadius ?? 10),
                    borderSide: BorderSide(
                      color: widget.borderColor ?? Colors.transparent,
                      width: 1.5, // optional
                    ),
                  ),

                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(widget.borderRadius ?? 10),
                    borderSide: BorderSide(
                      color: widget.borderColor ?? Colors.transparent,
                    ),
                  ),

                  contentPadding:
                  const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                ),
                child: widget.isTime
                    ? Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            child: TextInAppWidget(
                              text: textFormController.text.isEmpty
                                  ? widget.hint
                                  : textFormController.text,
                              textSize: widget.textSize ?? 13,
                              fontWeightIndex:
                                  FontSelectionData.regularFontFamily,
                              textColor:
                                  widget.textColor ?? AppColors.whiteColor,
                            ),
                          ),
                          Icon(Icons.calendar_today,
                              color: widget.textColor ?? AppColors.whiteColor,
                              size: widget.textSize ?? 13),
                        ],
                      )
                    : FormField<String>(
                  validator: widget.validator,
                  builder: (formFieldState) {
                    return Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,                      children: [
                        DropdownButtonHideUnderline(
                          child: DropdownButton<String>(
                            isExpanded: true,
                            value: selectedOption,
                            dropdownColor:
                            widget.backGroundColor ?? AppColors.blueColor,
                            hint: TextInAppWidget(
                              text: widget.hint,
                              textSize: 13,
                              fontWeightIndex:
                              FontSelectionData.regularFontFamily,
                              textColor:
                              widget.textColor ?? AppColors.whiteColor,
                            ),
                            items: widget.options!
                                .map(
                                  (option) => DropdownMenuItem(
                                value: option,
                                child: TextInAppWidget(
                                  text: option,
                                  textSize: widget.textSize ?? 12,
                                  fontWeightIndex:
                                  FontSelectionData.regularFontFamily,
                                  textColor: widget.textColor ??
                                      AppColors.whiteColor,
                                ),
                              ),
                            )
                                .toList(),
                            iconEnabledColor:
                            widget.textColor ?? AppColors.whiteColor,
                            onChanged: (value) {
                              context
                                  .read<OptionDashboardCubit>()
                                  .selectOption(value);

                              formFieldState.didChange(value);

                              if (value != null && widget.onChanged != null) {
                                widget.onChanged!(value);
                              }
                            },
                          ),
                        ),

                        if (formFieldState.hasError)
                          Padding(
                            padding: const EdgeInsets.only(top: 5),
                            child: TextInAppWidget(
                              text: formFieldState.errorText!,
                              textColor: AppColors.redColor,
                              textSize: 12,
                            ),
                          ),
                      ],
                    );
                  },
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
