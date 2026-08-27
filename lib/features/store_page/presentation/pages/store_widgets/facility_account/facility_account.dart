import 'package:emp_system_sun/features/store_page/data/model/facility_model/facility_model.dart';
import 'package:emp_system_sun/features/store_page/presentation/bloc/facility_cubit/facility_tab_cubit/facility_tab_cubit.dart';
import 'package:emp_system_sun/features/store_page/presentation/bloc/facility_cubit/facility_tab_cubit/facility_tab_state.dart';
import 'package:emp_system_sun/features/store_page/presentation/pages/store_widgets/car_model_widget/widgets/tabs_widget.dart';
import 'package:emp_system_sun/features/store_page/presentation/pages/store_widgets/facility_account/tabs/facility_data_content.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
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
                    typeWidget: const Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        //  TextInAppWidget(
                        //   text: AppLanguageKeys.continueFacilityDataKey,
                        //   textSize: 22,
                        //   fontWeightIndex: FontSelectionData.mediumFontFamily,
                        // ),
                        //  SizedBox(height: 10),
                        FacilityDataContent()
                      ],
                    ),
                    onTap: () {},
                  ),
                  const SizedBox(height: 20),

                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
