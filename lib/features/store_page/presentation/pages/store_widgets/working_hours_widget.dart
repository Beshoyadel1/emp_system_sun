import 'package:emp_system_sun/features/store_page/presentation/bloc/work_time_cubit/work_time_cubit.dart';
import 'package:emp_system_sun/features/store_page/presentation/bloc/work_time_cubit/work_time_state.dart';
import 'package:flutter/material.dart';
import '../../../../../core/language/language_constant.dart';
import '../../../../../core/pages_widgets/text_form_field_widget.dart';
import '../../../../../core/theming/colors.dart';
import 'package:flutter_bloc/flutter_bloc.dart';


class WorkingHoursWidget extends StatelessWidget {
  const WorkingHoursWidget({super.key});

  Future<void> pickTime(BuildContext context, bool isFrom) async {
    final cubit = UpdateWorkTimeCubit.get(context);

    final time = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );

    if (time != null) {
      final formatted =
          "${time.hour.toString().padLeft(2, '0')}:"
          "${time.minute.toString().padLeft(2, '0')}:00";

      print("SELECTED TIME => $formatted");

      if (isFrom) {
        cubit.setFromTime(formatted);
      } else {
        cubit.setToTime(formatted);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<UpdateWorkTimeCubit, WorkTimeState>(
      builder: (context, state) {
        final cubit = UpdateWorkTimeCubit.get(context);

        return Wrap(
          spacing: 20,
          runSpacing: 10,
          children: [

            /// FROM
            SizedBox(
              width: 163,
              child: GestureDetector(
                onTap: () => pickTime(context, true),
                child: AbsorbPointer(
                  child: TextFormFieldWidget(
                    textSize: 13,
                    textFormController: TextEditingController(
                        text: cubit.fromTime ?? ""),
                    isColumn: false,
                    text: AppLanguageKeys.fromKey,
                    hintText: '00 : 00',
                    textColor: AppColors.darkGreyColor,
                    hintTextColor: AppColors.darkColor,
                    borderColor: AppColors.lightGreyColor,
                    fillColor: AppColors.whiteColor,
                    textFormHeight: 35,
                    contentPadding:
                    const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                  ),
                ),
              ),
            ),

            /// TO
            SizedBox(
              width: 163,
              child: GestureDetector(
                onTap: () => pickTime(context, false),
                child: AbsorbPointer(
                  child: TextFormFieldWidget(
                    textSize: 13,
                    textFormController: TextEditingController(
                        text: cubit.toTime ?? ""),
                    isColumn: false,
                    text: AppLanguageKeys.toKey,
                    hintText: '00 : 00',
                    textColor: AppColors.darkGreyColor,
                    hintTextColor: AppColors.darkColor,
                    borderColor: AppColors.lightGreyColor,
                    fillColor: AppColors.whiteColor,
                    textFormHeight: 35,
                    contentPadding:
                    const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                  ),
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}