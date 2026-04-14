import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'data_container_in_list_data_technical_support_admin_sun.dart';
import '../../../../../../core/theming/colors.dart';

class ListDataTechnicalSupportAdminSun extends StatelessWidget {
  const ListDataTechnicalSupportAdminSun({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding:const EdgeInsetsGeometry.all(10),
      decoration: BoxDecoration(
        color: AppColors.whiteColor,
        borderRadius:const BorderRadius.all(Radius.circular(20)),
        border: Border.all(
            color: AppColors.greyColor.withOpacity(0.3)
        ),
        boxShadow: [
          BoxShadow(
            color: AppColors.darkColor.withOpacity(0.1),
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: const DataContainerInListDataTechnicalSupportAdminSun(),
    );
  }
}
