import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../../../../features/store_page/model/facility_cubit/facility_tab_cubit/facility_tab_cubit.dart';
import '../../../../../../../features/store_page/model/facility_cubit/facility_tab_cubit/facility_tab_state.dart';
import '../../../../../../../core/theming/colors.dart';
import '../../../../../../../core/theming/fonts.dart';
import '../../../../../../../core/pages_widgets/general_widgets/custom_container.dart';
import '../../../../../../../core/theming/text_styles.dart';
import '../../../../../../../core/language/language_constant.dart';
import '../../working_hours_widget.dart';

class WorkingHoursContent extends StatelessWidget {
  WorkingHoursContent({super.key});

  @override
  Widget build(BuildContext context) {
    final cubit = FacilityTabCubit.get(context);

    return BlocBuilder<FacilityTabCubit, FacilityTabState>(
      builder: (context, state) {
        int? selectedIndex;
        if (state is WorkingHoursDaySelectedState) {
          selectedIndex = state.selectedIndex;
        }
        return Column(
          spacing: 10,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const TextInAppWidget(
              text: AppLanguageKeys.weekDaysKey,
              textSize: 18,
              fontWeightIndex: FontSelectionData.mediumFontFamily,
              textColor: AppColors.darkColor,
            ),
            const TextInAppWidget(
              text: AppLanguageKeys.selectWorkDaysKey,
              textSize: 15,
              fontWeightIndex: FontSelectionData.mediumFontFamily,
              textColor: AppColors.darkGreyColor,
            ),
            Wrap(
              spacing: 10,
              runSpacing: 10,
              children: List.generate(daysOfWeek.length, (index) {
                final tab = daysOfWeek[index];
                final isSelected = selectedIndex == index;
                return CustomContainer(
                  isSelected: isSelected,
                  onTap: () => cubit.selectDay(index),
                  text: tab,
                  textColor:
                      isSelected ? AppColors.orangeColor : AppColors.whiteColor,
                  containerColor: isSelected
                      ? AppColors.whiteColor
                      : AppColors.lightGreyColor,
                  border: isSelected
                      ? Border.all(color: AppColors.orangeColor)
                      : Border(),
                );
              }),
            ),
            const SizedBox(height: 20),
            const TextInAppWidget(
              text: AppLanguageKeys.availableTimesKey,
              textSize: 18,
              fontWeightIndex: FontSelectionData.mediumFontFamily,
              textColor: AppColors.darkColor,
            ),
            const TextInAppWidget(
              text: AppLanguageKeys.selectAvailableTimeKey,
              textSize: 15,
              fontWeightIndex: FontSelectionData.mediumFontFamily,
              textColor: AppColors.darkGreyColor,
            ),
            const WorkingHoursWidget(),
          ],
        );
      },
    );
  }

  final List<String> daysOfWeek = [
    AppLanguageKeys.saturdayKey,
    AppLanguageKeys.sundayKey,
    AppLanguageKeys.mondayKey,
    AppLanguageKeys.tuesdayKey,
    AppLanguageKeys.wednesdayKey,
    AppLanguageKeys.thursdayKey,
    AppLanguageKeys.fridayKey,
  ];
}
