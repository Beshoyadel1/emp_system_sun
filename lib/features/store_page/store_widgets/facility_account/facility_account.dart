import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../../../features/store_page/store_widgets/car_model_widget/widgets/tabs_widget.dart';
import '../../../../../../features/store_page/store_widgets/navigator_button.dart';
import '../../../../../../../features/store_page/model/facility_model/facility_model.dart';
import '../../../../../../../features/store_page/model/facility_cubit/facility_tab_cubit/facility_tab_cubit.dart';
import '../../../../../../../features/store_page/model/facility_cubit/facility_tab_cubit/facility_tab_state.dart';
import '../../../../../../core/theming/colors.dart';
import '../../../../../../core/theming/fonts.dart';
import '../../../../../../core/pages_widgets/general_widgets/custom_container.dart';
import '../../../../../../core/theming/text_styles.dart';
import '../../../../../../core/language/language_constant.dart';

class FacilityAccount extends StatelessWidget {
  const FacilityAccount({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => FacilityTabCubit(),
      child: BlocBuilder<FacilityTabCubit, FacilityTabState>(
        buildWhen: (previous, current) => current is ChangeIndexState,
        builder: (context, state) {
          return Padding(
            padding: const EdgeInsets.all(16.0),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  CustomContainer(
                    containerWidth: double.infinity,
                    isSelected: false,
                    border: const Border(
                      top: BorderSide(color: AppColors.lightGreyColor),
                      left: BorderSide(color: AppColors.lightGreyColor),
                      right: BorderSide(color: AppColors.lightGreyColor),
                    ),
                    borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(10),
                      topRight: Radius.circular(10),
                    ),
                    typeWidget: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const TextInAppWidget(
                          text: AppLanguageKeys.continueFacilityDataKey,
                          textSize: 22,
                          fontWeightIndex: FontSelectionData.mediumFontFamily,
                        ),
                        const SizedBox(height: 10),
                        const TabsWidget(),
                        const SizedBox(height: 30),
                        facilityTabs[
                                context.read<FacilityTabCubit>().selectedIndex]
                            .content,
                        const SizedBox(height: 100),
                      ],
                    ),
                    onTap: () {},
                  ),
                  BlocBuilder<FacilityTabCubit, FacilityTabState>(
                    builder: (context, state) {
                      final cubit = context.read<FacilityTabCubit>();
                      final isLastTab =
                          cubit.selectedIndex == facilityTabs.length - 1;
                      return isLastTab
                          ? NavigatorButton(
                              textGrayButton: AppLanguageKeys.backKey,
                              onTapGrayButton: () => cubit.previousTab(),
                            )
                          : NavigatorButton(
                              textOrangeButton: AppLanguageKeys.nextKey,
                              textGrayButton: AppLanguageKeys.backKey,
                              onTapGrayButton: () => cubit.previousTab(),
                              onTapOrangeButton: () => cubit.nextTab(),
                            );
                    },
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
