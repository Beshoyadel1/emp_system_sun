import 'package:flutter/material.dart';
import '../../../../../../../features/store_page/model/facility_cubit/facility_tab_cubit/facility_tab_cubit.dart';
import '../../../../../core/pages_widgets/general_widgets/custom_container.dart';
import '../../../../../core/theming/assets.dart';
import '../../../../../core/theming/colors.dart';

class IdentityImage extends StatelessWidget {
  const IdentityImage(
      {super.key, required this.isUploaded, required this.cubit});

  final bool isUploaded;
  final FacilityTabCubit cubit;

  @override
  Widget build(BuildContext context) {
    return CustomContainer(
        containerWidth: double.infinity,
        isSelected: false,
        border: const Border(),
        onTap: () {
          if (!isUploaded) {
            cubit.uploadImage();
          }
        },
        containerColor: AppColors.whiteColor,
        typeWidget: Row(
          children: [
            CircleAvatar(
              radius: 50,
              backgroundImage: MemoryImage(cubit.image!),
            ),
            const SizedBox(width: 10),
            Padding(
              padding: const EdgeInsets.only(bottom: 98.0),
              child: Row(
                spacing: 10,
                children: [
                  GestureDetector(
                    onTap: cubit.deleteImage,
                    child: CircleAvatar(
                      radius: 16,
                      backgroundColor: AppColors.redColor,
                      child: Image.asset(
                        AppImageKeys.deleteIcon,
                        width: 20,
                        height: 20,
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: cubit.editImage,
                    child: CircleAvatar(
                      radius: 16,
                      backgroundColor: AppColors.darkGreyColor,
                      child: Image.asset(
                        AppImageKeys.editIcon,
                        width: 20,
                        height: 20,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ));
  }
}
