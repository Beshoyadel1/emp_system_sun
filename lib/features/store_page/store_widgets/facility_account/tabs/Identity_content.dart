import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../../../../features/store_page/model/facility_cubit/facility_tab_cubit/facility_tab_cubit.dart';
import '../../../../../../../features/store_page/model/facility_cubit/facility_tab_cubit/facility_tab_state.dart';
import '../../../../../../../core/theming/colors.dart';
import '../../../../../../../core/theming/fonts.dart';
import '../../../../../../../core/pages_widgets/general_widgets/custom_container.dart';
import '../../../../../../../core/theming/text_styles.dart';
import '../../../../../../../core/language/language_constant.dart';

import '../../identity_image.dart';

class IdentityContent extends StatelessWidget {
  const IdentityContent({super.key});

  @override
  Widget build(BuildContext context) {
    final cubit = FacilityTabCubit.get(context);
    return BlocBuilder<FacilityTabCubit, FacilityTabState>(
      builder: (context, state) {
        final bool isUploaded = state is IdentityUploadedState;
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const TextInAppWidget(
              text: AppLanguageKeys.facilityIdentityKey,
              textSize: 18,
              fontWeightIndex: FontSelectionData.regularFontFamily,
            ),
            const SizedBox(height: 10),
            isUploaded
                ? IdentityImage(isUploaded: isUploaded, cubit: cubit)
                : CustomContainer(
                    containerWidth: 150,
                    isSelected: false,
                    border: const Border(),
                    onTap: () {
                      if (!isUploaded) {
                        cubit.uploadImage();
                      }
                    },
                    containerColor: AppColors.darkGreyColor,
                    typeWidget: const Center(
                      child: Column(
                        children: [
                          TextInAppWidget(
                            text: AppLanguageKeys.attachIdentityKey,
                            textSize: 14,
                            textColor: AppColors.whiteColor,
                          ),
                        ],
                      ),
                    ),
                  ),
            const SizedBox(height: 8),
            if (!isUploaded)
              const TextInAppWidget(
                text: AppLanguageKeys.imageRequirementsKey,
                textSize: 12,
                textColor: AppColors.darkGreyColor,
              ),
          ],
        );
      },
    );
  }
}
