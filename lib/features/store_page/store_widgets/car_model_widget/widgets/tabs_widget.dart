import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../../../../features/store_page/model/facility_cubit/facility_tab_cubit/facility_tab_cubit.dart';
import '../../../../../../../features/store_page/model/facility_cubit/facility_tab_cubit/facility_tab_state.dart';
import '../../../../../../../features/store_page/model/facility_model/facility_model.dart';
import '../../../../../../../core/theming/colors.dart';
import '../../../../../../../core/pages_widgets/general_widgets/custom_container.dart';

class TabsWidget extends StatelessWidget {
  const TabsWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<FacilityTabCubit, FacilityTabState>(
      builder: (context, state) {
        return Wrap(
          spacing: 10,
          runSpacing: 10,
          children: List.generate(facilityTabs.length, (index) {
            final isSelected =
                context.read<FacilityTabCubit>().selectedIndex == index;

            return ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 150),
              child: CustomContainer(
                isSelected: isSelected,
                onTap: () => context.read<FacilityTabCubit>().selectTab(index),
                text: facilityTabs[index].title,
                padding: isSelected
                    ? const EdgeInsets.symmetric(horizontal: 10, vertical: 5)
                    : const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                containerColor:
                    isSelected ? AppColors.orangeColor : AppColors.greyColor,
                border: const Border(),
              ),
            );
          }),
        );
      },
    );
  }
}
