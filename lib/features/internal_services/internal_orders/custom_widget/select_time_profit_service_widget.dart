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
  final double? height, width, borderRadius, textSize;

  const SelectTimeProfitServiceWidget(
      {super.key,
      required this.hint,
      this.options,
      this.isTime = false,
      this.textColor,
      this.backGroundColor,
      this.width,
      this.height,
      this.borderColor,
      this.borderRadius,
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
              height: widget.height ?? 35,
              width: widget.width ?? 130,
              child: InputDecorator(
                decoration: InputDecoration(
                  filled: true,
                  fillColor: widget.backGroundColor ?? AppColors.blueColor,
                  border: OutlineInputBorder(
                    borderRadius:
                        BorderRadius.circular(widget.borderRadius ?? 25),
                    borderSide: widget.borderColor != null
                        ? BorderSide(color: widget.borderColor!)
                        : BorderSide.none,
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
                    : DropdownButtonHideUnderline(
                        child: DropdownButton<String>(
                          isExpanded: true,
                          dropdownColor:
                              widget.backGroundColor ?? AppColors.blueColor,
                          value: selectedOption,
                          hint: TextInAppWidget(
                            text: widget.hint,
                            textSize: 13,
                            fontWeightIndex:
                                FontSelectionData.regularFontFamily,
                            textColor: widget.textColor ?? AppColors.whiteColor,
                          ),
                          items: widget.options!
                              .map(
                                (option) => DropdownMenuItem(
                                  value: option,
                                  child: TextInAppWidget(
                                    text: option,
                                    textSize: widget.textSize ?? 13,
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
                            textFormController.text = value ?? "";
                          },
                        ),
                      ),
              ),
            ),
          );
        },
      ),
    );
  }
}
