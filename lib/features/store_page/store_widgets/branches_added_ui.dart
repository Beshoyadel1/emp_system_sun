import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../../../../features/store_page/model/facility_cubit/facility_tab_cubit/facility_tab_cubit.dart';
import '../../../../../../../features/store_page/model/facility_cubit/facility_tab_cubit/facility_tab_state.dart';
import '../../../../../core/pages_widgets/general_widgets/custom_container.dart';
import 'custom_add_button.dart';
import '../../../../../core/theming/assets.dart';
import '../../../../../core/theming/colors.dart';
import '../../../../../core/theming/fonts.dart';
import '../../../../../core/theming/text_styles.dart';
import '../../../../../core/language/language_constant.dart';

class BranchesAddedUi extends StatelessWidget {
  const BranchesAddedUi({super.key, required this.state});

  final FacilityTabState state;

  @override
  Widget build(BuildContext context) {
    final branches = context.read<FacilityTabCubit>().branches;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      spacing: 20,
      children: [
        ...branches.map((branch) {
          return CustomContainer(
            boxShadow: [
              BoxShadow(
                color: AppColors.lightGreyColor.withAlpha(110),
                blurRadius: 21,
                spreadRadius: 2,
                offset: const Offset(0, 6),
              ),
            ],
            border: const Border(),
            isSelected: false,
            onTap: () {},
            borderRadius: BorderRadius.circular(11),
            typeWidget: Row(
              spacing: 10,
              children: [
                Image.asset(AppImageKeys.locationBoxOrange,
                    height: 41, width: 41),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 12.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const TextInAppWidget(
                        text: AppLanguageKeys.mainBranchKey,
                        textSize: 16,
                        fontWeightIndex: FontSelectionData.boldFontFamily,
                      ),
                      TextInAppWidget(
                        text: branch.name,
                        textSize: 16,
                        fontWeightIndex: FontSelectionData.boldFontFamily,
                      ),
                    ],
                  ),
                ),
                const Spacer(),
                CustomContainer(
                  isSelected: false,
                  onTap: () {
                    context
                        .read<FacilityTabCubit>()
                        .editBranch(branches.indexOf(branch));
                  },
                  containerColor: AppColors.darkGreyColor,
                  containerWidth: 162,
                  containerHeight: 42,
                  typeWidget: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset(
                        AppImageKeys.boxEditIcon,
                        height: 24,
                        width: 24,
                      ),
                      const TextInAppWidget(
                        text: AppLanguageKeys.editKey,
                        textSize: 16,
                        textColor: AppColors.whiteColor,
                        fontWeightIndex: FontSelectionData.boldFontFamily,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
        }),
        CustomAddButton(
          width: 198,
          text: AppLanguageKeys.addNewBranchKey,
          onTap: () => context.read<FacilityTabCubit>().goToAddBranches(),
        ),
      ],
    );
  }
}
