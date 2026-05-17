import 'package:emp_system_sun/features/store_page/presentation/bloc/facility_cubit/facility_tab_cubit/facility_tab_cubit.dart';
import 'package:emp_system_sun/features/store_page/presentation/bloc/facility_cubit/facility_tab_cubit/facility_tab_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../../../../core/theming/colors.dart';
import '../../../../../../../core/theming/text_styles.dart';
import '../../../../../../../core/language/language_constant.dart';


class IdentityContent extends StatelessWidget {
  const IdentityContent({super.key});

  @override
  Widget build(BuildContext context) {
    final cubit = FacilityTabCubit.get(context);

    return BlocBuilder<FacilityTabCubit, FacilityTabState>(
      builder: (context, state) {
        final image = cubit.identityImage;

        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const TextInAppWidget(
              text: AppLanguageKeys.facilityIdentityKey,
              textSize: 18,
            ),
            const SizedBox(height: 10),

            if (image == null)
              GestureDetector(
                onTap: cubit.uploadIdentityImage,
                child: Container(
                  width: 150,
                  height: 120,
                  decoration: BoxDecoration(
                    border: Border.all(color: AppColors.darkGreyColor),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: const Center(
                    child: Text("Upload"),
                  ),
                ),
              )
            else
              Container(
                width: 250,
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  border: Border.all(color: AppColors.darkGreyColor),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Column(
                  children: [
                    Image.memory(image, height: 120),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        IconButton(
                          onPressed: cubit.deleteIdentityImage,
                          icon: const Icon(Icons.delete, color: Colors.red),
                        ),
                        IconButton(
                          onPressed: cubit.uploadIdentityImage,
                          icon: const Icon(Icons.edit),
                        ),
                      ],
                    )
                  ],
                ),
              ),
          ],
        );
      },
    );
  }
}