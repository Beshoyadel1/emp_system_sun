import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../../features/store_page/model/location_cubit/location_cubit.dart';
import '../../../../../features/store_page/model/location_cubit/location_state.dart';
import '../../../../../features/store_page/model/branch_model/branch_model_dashboard.dart';
import '../../../../../core/theming/colors.dart';
import '../../../../../core/theming/fonts.dart';
import '../../../../../../../features/store_page/model/facility_cubit/facility_tab_cubit/facility_tab_cubit.dart';
import '../../../../../core/pages_widgets/text_form_field_widget.dart';
import '../../../../../core/pages_widgets/general_widgets/custom_container.dart';
import '../../../../../core/theming/text_styles.dart';
import '../../../../../core/language/language_constant.dart';
import 'square_map_widget.dart';

class AddBranchUI extends StatelessWidget {
  AddBranchUI({super.key});

  final textController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<FacilityTabCubit>();

    if (cubit.editingIndex != null) {
      final editingBranch = cubit.branches[cubit.editingIndex!];
      textController.text = editingBranch.name;
    }

    return Column(
      spacing: 20,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        TextInAppWidget(
          text: cubit.editingIndex != null
              ? AppLanguageKeys.editKey
              : AppLanguageKeys.addMainBranchKey,
          textSize: 20,
          fontWeightIndex: FontSelectionData.mediumFontFamily,
        ),
        const SizedBox(height: 30),
        TextFormFieldWidget(
          textFormController: textController,
          text: AppLanguageKeys.branchAddressKey,
          isColumn: true,
          textColor: AppColors.darkGreyColor,
          fillColor: AppColors.whiteColor,
          textSize: 16,
          hintText: AppLanguageKeys.addressDetailsKey,
          textFormHeight: 35,
          contentPadding: const EdgeInsets.symmetric(horizontal: 10),
          fontWeightIndex: FontSelectionData.semiBoldFontFamily,
          borderColor: AppColors.lightGreyColor,
          //borderRadius: 20,
          onChanged: (value) {
            if (value.trim().isNotEmpty) {
              context.read<LocationCubit>().searchLocation(value.trim());
            }
          },
        ),
        const SizedBox(height: 30),
        const TextInAppWidget(
          text: AppLanguageKeys.confirmBranchLocationKey,
          textSize: 18,
          fontWeightIndex: FontSelectionData.regularFontFamily,
        ),
        SizedBox(
          height: 370,
          width: 408,
          child: SquareMapWidget(),
        ),
        const SizedBox(height: 20),
        CustomContainer(
          isSelected: false,
          onTap: () {
            final locationState = context.read<LocationCubit>().state;
            if (locationState is LocationLoaded &&
                textController.text.trim().isNotEmpty) {
              final branch = BranchModelDashboard(
                name: textController.text.trim(),
                location: locationState.latLng,
              );
              if (cubit.editingIndex != null) {
                cubit.updateBranch(branch);
              } else {
                cubit.addBranch(branch);
              }
            }
          },
          text: cubit.editingIndex != null
              ? AppLanguageKeys.editKey
              : AppLanguageKeys.saveKey,
          containerColor: AppColors.orangeColor,
          padding: const EdgeInsets.symmetric(horizontal: 70, vertical: 8),
        ),
      ],
    );
  }
}
